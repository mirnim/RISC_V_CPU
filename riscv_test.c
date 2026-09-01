/*
 * decoders.c
 *
 * Reference implementations of ~20 variable-length decoding algorithms,
 * written as a grounding/test harness for custom-ISA decode-acceleration
 * work. Each decoder is a standalone function operating on a plain byte
 * buffer (byte-oriented codes) or a BitReader (bit-oriented codes).
 *
 * Where an encoding has both a memory-efficient and a time-efficient
 * decode strategy (canonical Huffman), both are implemented separately
 * so the tradeoff is visible in code, not just in description.
 *
 * A minimal BitWriter + matching encode helpers are included ONLY to
 * generate correct test vectors for the bit-level codes; the encoders
 * are not the point of this file and are kept deliberately small.
 *
 * Build:   gcc -std=c11 -Wall -Wextra -O2 -o decoders decoders.c
 * Run:     ./decoders
 */


/* =========================================================================
 * Bit-level I/O helpers (MSB-first within each byte)
 * ========================================================================= */

typedef struct {
    const unsigned char *data;
    unsigned int len;       /* total bytes available */
    unsigned int byte_pos;
    int bit_pos;      /* 0..7 */
} BitReader;

static void br_init(BitReader *br, const unsigned char *data, unsigned int len) {
    br->data = data;
    br->len = len;
    br->byte_pos = 0;
    br->bit_pos = 0;
}

/* returns 0 or 1, or -1 if the stream is exhausted */
static int br_read_bit(BitReader *br) {
    if (br->byte_pos >= br->len) return -1;
    int bit = (br->data[br->byte_pos] >> (7 - br->bit_pos)) & 1;
    br->bit_pos++;
    if (br->bit_pos == 8) {
        br->bit_pos = 0;
        br->byte_pos++;
    }
    return bit;
}

static unsigned int br_read_bits(BitReader *br, int n) {
    unsigned int v = 0;
    for (int i = 0; i < n; i++) {
        int b = br_read_bit(br);
        if (b < 0) b = 0; /* pad with zeros past end of stream */
        v = (v << 1) | (unsigned int)b;
    }
    return v;
}

typedef struct {
    unsigned char *data;
    unsigned int byte_pos;
    int bit_pos;
} BitWriter;

static void bw_init(BitWriter *bw, unsigned char *data) {
    bw->data = data;
    bw->byte_pos = 0;
    bw->bit_pos = 0;
    bw->data[0] = 0;
}

static void bw_write_bit(BitWriter *bw, int bit) {
    if (bit) bw->data[bw->byte_pos] |= (unsigned char)(1u << (7 - bw->bit_pos));
    bw->bit_pos++;
    if (bw->bit_pos == 8) {
        bw->bit_pos = 0;
        bw->byte_pos++;
        bw->data[bw->byte_pos] = 0;
    }
}

static void bw_write_bits(BitWriter *bw, unsigned int value, int n) {
    for (int i = n - 1; i >= 0; i--) bw_write_bit(bw, (int)((value >> i) & 1));
}

static unsigned int bw_total_bytes(const BitWriter *bw) {
    return bw->byte_pos + (bw->bit_pos > 0 ? 1 : 0);
}

/* =========================================================================
 * 1. UNARY CODE
 *
 * N is represented as N ones followed by a terminating zero. The simplest
 * possible prefix code; used as a building block inside Golomb-Rice and
 * Exponential-Golomb below.
 * ========================================================================= */

static unsigned int decode_unary(BitReader *br) {
    unsigned int n = 0;
    while (br_read_bit(br) == 1) n++;
    return n;
}

static void encode_unary(BitWriter *bw, unsigned int n) {
    for (unsigned int i = 0; i < n; i++) bw_write_bit(bw, 1);
    bw_write_bit(bw, 0);
}

/* =========================================================================
 * 2. ELIAS GAMMA CODE
 *
 * N (N >= 1) is split into e = floor(log2(N)) leading zero bits, followed
 * by the (e+1)-bit binary representation of N itself (which starts with
 * the implicit 1 that terminates the unary prefix). Used for values with
 * a roughly geometric/exponential distribution, e.g. gap lengths.
 * ========================================================================= */

static unsigned int decode_elias_gamma(BitReader *br) {
    unsigned int e = 0;
    while (br_read_bit(br) == 0) e++;   /* consumes the terminating 1 too */
    if (e == 0) return 1;
    unsigned int mantissa = (unsigned int)br_read_bits(br, (int)e);
    return (1u << e) | mantissa;
}

static void encode_elias_gamma(BitWriter *bw, unsigned int n) {
    int e = 0;
    unsigned int t = n;
    while (t > 1) { t >>= 1; e++; }
    for (int i = 0; i < e; i++) bw_write_bit(bw, 0);
    bw_write_bits(bw, n, e + 1);
}

/* =========================================================================
 * 3. ELIAS DELTA CODE
 *
 * Like gamma, but the *length* L = floor(log2(N))+1 is itself gamma-coded
 * (rather than sent in unary), followed by the L-1 mantissa bits of N.
 * More efficient than gamma for large N, at the cost of a slightly more
 * involved decode (a gamma-decode nested inside the delta-decode).
 * ========================================================================= */

static unsigned int decode_elias_delta(BitReader *br) {
    unsigned int L = decode_elias_gamma(br);   /* L = bit-length of N */
    if (L == 1) return 1;
    unsigned int mantissa = (unsigned int)br_read_bits(br, (int)(L - 1));
    return (1u << (L - 1)) | mantissa;
}

static void encode_elias_delta(BitWriter *bw, unsigned int n) {
    int L = 0;
    unsigned int t = n;
    while (t > 0) { L++; t >>= 1; }
    encode_elias_gamma(bw, (unsigned int)L);
    if (L > 1) bw_write_bits(bw, n, L - 1);
}

/* =========================================================================
 * 4. GOLOMB-RICE CODE (parameter k, power-of-two Golomb)
 *
 * value = (quotient << k) | remainder, where quotient = value >> k is sent
 * in unary and remainder is a fixed k-bit field. Standard for FLAC/Shorten
 * style audio compression and any near-geometric residual distribution.
 * ========================================================================= */

static unsigned int decode_rice(BitReader *br, int k) {
    unsigned int q = decode_unary(br);
    unsigned int r = (unsigned int)br_read_bits(br, k);
    return (q << k) | r;
}

static void encode_rice(BitWriter *bw, unsigned int value, int k) {
    unsigned int q = value >> k;
    unsigned int r = value & ((1u << k) - 1u);
    encode_unary(bw, q);
    bw_write_bits(bw, r, k);
}

/* =========================================================================
 * 5. EXPONENTIAL-GOLOMB CODE (order 0, as used in H.264/H.265 headers)
 *
 * codeNum is recovered from: M leading zero bits, a 1 bit, then M suffix
 * bits, giving codeNum = 2^M - 1 + suffix. Similar shape to Elias gamma
 * but a different value mapping (codeNum vs N), and the one actually used
 * in real video codec bitstreams.
 * ========================================================================= */

static unsigned int decode_exp_golomb(BitReader *br) {
    unsigned int zeros = 0;
    while (br_read_bit(br) == 0) zeros++;
    unsigned int suffix = zeros > 0 ? (unsigned int)br_read_bits(br, (int)zeros) : 0;
    return (1u << zeros) - 1u + suffix;
}

static void encode_exp_golomb(BitWriter *bw, unsigned int codeNum) {
    unsigned int temp = codeNum + 1;
    int M = 0;
    unsigned int t = temp;
    while (t > 1) { t >>= 1; M++; }
    for (int i = 0; i < M; i++) bw_write_bit(bw, 0);
    bw_write_bits(bw, temp, M + 1);
}

/* =========================================================================
 * 6. FIBONACCI CODING (Zeckendorf representation)
 *
 * value = sum of a subset of Fibonacci numbers F(2)=1, F(3)=2, F(4)=3, ...
 * with no two consecutive Fibonacci numbers used (Zeckendorf's theorem
 * guarantees a unique such representation). Bits are written least-
 * significant-Fibonacci-number first, then terminated with an extra 1 bit;
 * since the data portion can never contain "11" by construction, "11" is
 * an unambiguous end-of-code marker. Self-synchronizing: a bit error can't
 * cascade past the next terminator, unlike most prefix codes.
 * ========================================================================= */

static const unsigned int FIB[] = {
    1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,
    2584,4181,6765,10946,17711,28657,46368
};
#define FIB_COUNT (int)(sizeof(FIB)/sizeof(FIB[0]))

static unsigned int decode_fibonacci(BitReader *br) {
    unsigned int sum = 0;
    int prev_bit = 0;
    int idx = 0;
    while (idx < FIB_COUNT) {
        int bit = br_read_bit(br);
        if (bit < 0) break;
        if (bit == 1) {
            if (prev_bit == 1) break;   /* terminator: stop, don't count it */
            sum += FIB[idx];
            prev_bit = 1;
        } else {
            prev_bit = 0;
        }
        idx++;
    }
    return sum;
}

static void encode_fibonacci(BitWriter *bw, unsigned int value) {
    int bits[FIB_COUNT];
    int top = -1;
    unsigned int rem = value;
    for (int i = FIB_COUNT - 1; i >= 0; i--) {
        if (FIB[i] <= rem) {
            bits[i] = 1;
            rem -= FIB[i];
            if (top < i) top = i;
        } else {
            bits[i] = 0;
        }
    }
    if (top < 0) top = 0; /* value == 0 edge case: encode as a single terminator */
    for (int i = 0; i <= top; i++) bw_write_bit(bw, bits[i]);
    bw_write_bit(bw, 1);
}

/* =========================================================================
 * 7. LEB128 UNSIGNED VARINT
 *
 * The workhorse of protobuf, WASM, DWARF, git. 7 payload bits per byte,
 * little-endian group order, continuation flag in the top bit of each byte.
 * ========================================================================= */

static unsigned int decode_leb128_unsigned(const unsigned char *data, unsigned int *pos) {
    unsigned int result = 0;
    int shift = 0;
    unsigned char byte;
    do {
        byte = data[*pos];
        (*pos)++;
        result |= (unsigned int)(byte & 0x7F) << shift;
        shift += 7;
    } while (byte & 0x80);
    return result;
}

static unsigned int encode_leb128_unsigned(unsigned int value, unsigned char *out) {
    unsigned int n = 0;
    do {
        unsigned char byte = value & 0x7F;
        value >>= 7;
        if (value) byte |= 0x80;
        out[n++] = byte;
    } while (value);
    return n;
}

/* =========================================================================
 * 8. LEB128 SIGNED VARINT (protobuf "sint" zigzag flavor)
 *
 * The raw LEB128 payload is zigzag-coded: (n << 1) ^ (n >> 63) at encode
 * time, so small-magnitude negative numbers stay small after encoding.
 * Decode reverses the LEB128 unsigned read, then undoes the zigzag map.
 * ========================================================================= */

static unsigned int decode_leb128_signed_zigzag(const unsigned char *data, unsigned int *pos) {
    unsigned int u = decode_leb128_unsigned(data, pos);
    return (unsigned int)(u >> 1) ^ -(unsigned int)(u & 1);
}

static unsigned int encode_leb128_signed_zigzag(unsigned int value, unsigned char *out) {
    unsigned int zz = ((unsigned int)value << 1) ^ (unsigned int)(value >> 31);
    return encode_leb128_unsigned(zz, out);
}

/* =========================================================================
 * 9. SQLITE-STYLE VARINT
 *
 * Big-endian group order (unlike LEB128), 7 payload bits per byte for the
 * first 8 bytes, but the 9th byte (if reached) contributes a full 8 bits.
 * This caps every varint at exactly 9 bytes regardless of value, which
 * simplifies bounds-checking versus open-ended LEB128.
 * ========================================================================= */

static unsigned int decode_sqlite_varint(const unsigned char *data, unsigned int *pos) {
    unsigned int result = 0;
    for (int i = 0; i < 8; i++) {
        unsigned char b = data[*pos + (unsigned int)i];
        result = (result << 7) | (unsigned int)(b & 0x7F);
        if (!(b & 0x80)) {
            *pos += (unsigned int)i + 1;
            return result;
        }
    }
    unsigned char b = data[*pos + 8];
    result = (result << 8) | b;
    *pos += 9;
    return result;
}

/* =========================================================================
 * 10. MIDI VARIABLE-LENGTH QUANTITY (VLQ)
 *
 * Same 7-bits-per-byte/continuation-flag idea as LEB128, but big-endian
 * group order (most significant group first) -- the format used for delta
 * timestamps in Standard MIDI Files.
 * ========================================================================= */

static unsigned int decode_midi_vlq(const unsigned char *data, unsigned int *pos) {
    unsigned int value = 0;
    unsigned char byte;
    do {
        byte = data[*pos];
        (*pos)++;
        value = (value << 7) | (byte & 0x7F);
    } while (byte & 0x80);
    return value;
}

/* =========================================================================
 * 11. UTF-8 DECODE
 *
 * 1-4 byte variable-width encoding. The lead byte's high-bit pattern
 * announces the total sequence length; continuation bytes each contribute
 * 6 payload bits. Ubiquitous for text.
 * ========================================================================= */

static unsigned int decode_utf8(const unsigned char *data, unsigned int *pos) {
    unsigned char b0 = data[(*pos)++];
    if ((b0 & 0x80) == 0) return b0;               /* 0xxxxxxx: ASCII */
    int extra;
    unsigned int cp;
    if ((b0 & 0xE0) == 0xC0)      { extra = 1; cp = b0 & 0x1F; }
    else if ((b0 & 0xF0) == 0xE0) { extra = 2; cp = b0 & 0x0F; }
    else if ((b0 & 0xF8) == 0xF0) { extra = 3; cp = b0 & 0x07; }
    else return 0xFFFD; /* invalid lead byte */
    for (int i = 0; i < extra; i++) {
        unsigned char b = data[(*pos)++];
        cp = (cp << 6) | (b & 0x3F);
    }
    return cp;
}

/* =========================================================================
 * 12. UTF-16 DECODE (surrogate pairs)
 *
 * Code points above U+FFFF are represented as a "surrogate pair": a high
 * surrogate in 0xD800-0xDBFF followed by a low surrogate in 0xDC00-0xDFFF.
 * Everything else is a single 16-bit unit.
 * ========================================================================= */

static unsigned int decode_utf16(const unsigned short *data, unsigned int *pos) {
    unsigned short w1 = data[(*pos)++];
    if (w1 < 0xD800 || w1 > 0xDBFF) return w1;      /* BMP character */
    unsigned short w2 = data[(*pos)++];
    unsigned int cp = 0x10000u + (((unsigned int)(w1 - 0xD800)) << 10) + (w2 - 0xDC00);
    return cp;
}

/* =========================================================================
 * 13. BASE64 DECODE
 *
 * 4 six-bit symbols -> 3 bytes. Included as a variable-*output*-length
 * decode (trailing '=' padding shortens the final group), a different
 * flavor from the variable-*input*-length codes above.
 * ========================================================================= */

static int b64_val(char c) {
    if (c >= 'A' && c <= 'Z') return c - 'A';
    if (c >= 'a' && c <= 'z') return c - 'a' + 26;
    if (c >= '0' && c <= '9') return c - '0' + 52;
    if (c == '+') return 62;
    if (c == '/') return 63;
    return -1;
}

static unsigned int decode_base64(const char *in, unsigned char *out) {
    unsigned int out_len = 0;
    int vals[4];
    int vi = 0;
    for (const char *p = in; *p; p++) {
        if (*p == '=') break;
        int v = b64_val(*p);
        if (v < 0) continue; /* skip whitespace/newlines */
        vals[vi++] = v;
        if (vi == 4) {
            out[out_len++] = (unsigned char)((vals[0] << 2) | (vals[1] >> 4));
            out[out_len++] = (unsigned char)((vals[1] << 4) | (vals[2] >> 2));
            out[out_len++] = (unsigned char)((vals[2] << 6) | vals[3]);
            vi = 0;
        }
    }
    if (vi >= 2) {
        out[out_len++] = (unsigned char)((vals[0] << 2) | (vals[1] >> 4));
        if (vi == 3) out[out_len++] = (unsigned char)((vals[1] << 4) | (vals[2] >> 2));
    }
    return out_len;
}

/* =========================================================================
 * 14. ASN.1 BER LENGTH DECODE
 *
 * Short form: a single byte (top bit 0) is the length directly. int form:
 * top bit 1, low 7 bits give the number of following big-endian length
 * bytes. Used throughout X.509 certificates, LDAP, SNMP.
 * ========================================================================= */

static unsigned int decode_ber_length(const unsigned char *data, unsigned int *pos) {
    unsigned char first = data[(*pos)++];
    if (!(first & 0x80)) return first;              /* short form */
    int num_bytes = first & 0x7F;
    unsigned int len = 0;
    for (int i = 0; i < num_bytes; i++) {
        len = (len << 8) | data[(*pos)++];
    }
    return len;
}

/* =========================================================================
 * 15. RLE DECODE -- byte-oriented (PackBits / TIFF style)
 *
 * A signed control byte n: n >= 0 means "copy the next n+1 literal bytes
 * verbatim"; n < 0 means "repeat the next single byte (1-n) times".
 * ========================================================================= */

static unsigned int decode_rle_packbits(const unsigned char *in, unsigned int in_len, unsigned char *out) {
    unsigned int i = 0, o = 0;
    while (i < in_len) {
        unsigned char n = (unsigned char)in[i++];
        if (n >= 0) {
            int count = n + 1;
            for (int j = 0; j < count; j++) out[o++] = in[i++];
        } else if (n != -128) {
            int count = 1 - n;
            unsigned char b = in[i++];
            for (int j = 0; j < count; j++) out[o++] = b;
        }
    }
    return o;
}

/* =========================================================================
 * 16. RLE DECODE -- bit-oriented (alternating-run style, fax/CCITT flavor)
 *
 * The bitstream alternates between runs of 0 and runs of 1, starting with
 * 0; each run's length is itself unary-coded. Distinct hardware/software
 * shape from the byte-oriented version above: everything happens through
 * the bit reader, one run at a time, rather than one byte at a time.
 * ========================================================================= */

static unsigned int decode_rle_bitwise(BitReader *br, unsigned char *out_bits, unsigned int max_bits) {
    unsigned int o = 0;
    int current_bit = 0;
    while (o < max_bits && br->byte_pos < br->len) {
        unsigned int run = decode_unary(br) + 1;
        for (unsigned int j = 0; j < run && o < max_bits; j++) out_bits[o++] = (unsigned char)current_bit;
        current_bit ^= 1;
    }
    return o;
}

/* =========================================================================
 * 17. MOVE-TO-FRONT DECODE (bzip2-style, post-BWT stage)
 *
 * Maintains a 256-entry symbol table, initially identity-ordered. Each
 * input byte is an *index* into the current table; the symbol at that
 * index is emitted and then moved to the front of the table. Turns
 * "recently seen" symbols into small indices, which is what makes BWT
 * output compress well downstream.
 * ========================================================================= */

static void decode_mtf(const unsigned char *indices, unsigned int len, unsigned char *out) {
    unsigned char table[256];
    for (int i = 0; i < 256; i++) table[i] = (unsigned char)i;
    for (unsigned int i = 0; i < len; i++) {
        unsigned char idx = indices[i];
        unsigned char val = table[idx];
        out[i] = val;
        for (int j = idx; j > 0; j--) table[j] = table[j - 1];
        table[0] = val;
    }
}

/* =========================================================================
 * 18a. CANONICAL HUFFMAN DECODE -- memory-efficient (bit-serial tree walk)
 *
 * No explicit tree is stored. Only per-length bookkeeping is needed:
 * count[l] (codes of length l), first_code[l] (first canonical codeword
 * of that length), and a symbols[] array sorted by (length, symbol).
 * Decode reads one bit at a time, extending a running "code" value, and
 * checks after each bit whether it falls within the valid range for the
 * current length -- O(max code length) time, O(number of symbols) memory,
 * with no tree-node overhead at all.
 * ========================================================================= */

#define MAX_HUFF_BITS 16
#define MAX_SYMBOLS   256

typedef struct {
    unsigned char lengths[MAX_SYMBOLS]; /* 0 = symbol unused */
    int num_symbols;
} HuffmanCodeLengths;

typedef struct {
    int count[MAX_HUFF_BITS + 1];
    int first_code[MAX_HUFF_BITS + 1];
    int first_symbol_index[MAX_HUFF_BITS + 1];
    unsigned char symbols[MAX_SYMBOLS]; /* sorted by (length, symbol) */
} CanonicalHuffmanTable;

static void build_canonical_huffman(const HuffmanCodeLengths *cl, CanonicalHuffmanTable *t) {

    for (int i = 0; i < cl->num_symbols; i++) {
        if (cl->lengths[i] > 0) t->count[cl->lengths[i]]++;
    }

    int start_index[MAX_HUFF_BITS + 1];
    int running = 0;
    for (int l = 1; l <= MAX_HUFF_BITS; l++) {
        start_index[l] = running;
        running += t->count[l];
    }

    int fill[MAX_HUFF_BITS + 1];
    for (int i = 0; i < cl->num_symbols; i++) {
        int l = cl->lengths[i];
        if (l > 0) t->symbols[fill[l]++] = (unsigned char)i;
    }

    int code = 0;
    for (int l = 1; l <= MAX_HUFF_BITS; l++) {
        t->first_code[l] = code;
        t->first_symbol_index[l] = start_index[l];
        code = (code + t->count[l]) << 1;
    }
}

static int decode_huffman_bitserial(BitReader *br, const CanonicalHuffmanTable *t) {
    int code = 0;
    for (int l = 1; l <= MAX_HUFF_BITS; l++) {
        int bit = br_read_bit(br);
        if (bit < 0) return -1;
        code = (code << 1) | bit;
        int count = t->count[l];
        if (count > 0 && (code - t->first_code[l]) < count && code >= t->first_code[l]) {
            int sym_index = t->first_symbol_index[l] + (code - t->first_code[l]);
            return t->symbols[sym_index];
        }
    }
    return -1; /* invalid/corrupt code */
}

/* helper (test-vector generation only): find the canonical code for a symbol */
static int get_huffman_code(const CanonicalHuffmanTable *t, const HuffmanCodeLengths *cl,
                             int symbol, unsigned int *code_out, int *len_out) {
    int len = cl->lengths[symbol];
    if (len == 0) return -1;
    int base = t->first_symbol_index[len];
    int count = t->count[len];
    for (int i = 0; i < count; i++) {
        if (t->symbols[base + i] == symbol) {
            *code_out = (unsigned int)(t->first_code[len] + i);
            *len_out = len;
            return 0;
        }
    }
    return -1;
}

/* =========================================================================
 * 18b. CANONICAL HUFFMAN DECODE -- time-efficient (table-driven)
 *
 * Same canonical code space as above, but a full 2^FAST_BITS lookup table
 * is precomputed once: every possible bit pattern of width FAST_BITS maps
 * directly to (symbol, actual code length). Decode becomes O(1): peek
 * FAST_BITS bits, look up, consume only the bits the matched code actually
 * used. Trades O(2^FAST_BITS) memory for O(1) decode time -- the classic
 * software Huffman speed/memory tradeoff (codes inter than FAST_BITS
 * would need a secondary fallback table, omitted here for clarity).
 * ========================================================================= */

#define FAST_BITS 9

typedef struct {
    unsigned char symbol[1 << FAST_BITS];
    unsigned char length[1 << FAST_BITS]; /* 0 = no code fits (would need fallback) */
} FastHuffmanTable;

static void build_fast_huffman_table(const CanonicalHuffmanTable *t, FastHuffmanTable *ft) {

    for (int l = 1; l <= MAX_HUFF_BITS && l <= FAST_BITS; l++) {
        int count = t->count[l];
        for (int i = 0; i < count; i++) {
            int code = t->first_code[l] + i;
            int symbol = t->symbols[t->first_symbol_index[l] + i];
            int shift = FAST_BITS - l;
            int base = code << shift;
            for (int fillv = 0; fillv < (1 << shift); fillv++) {
                ft->symbol[base + fillv] = (unsigned char)symbol;
                ft->length[base + fillv] = (unsigned char)l;
            }
        }
    }
}

static int decode_huffman_table_driven(BitReader *br, const FastHuffmanTable *ft) {
    BitReader peek = *br;
    unsigned int bits = (unsigned int)br_read_bits(&peek, FAST_BITS);
    unsigned char len = ft->length[bits];
    if (len == 0) return -1; /* code inter than FAST_BITS: fallback not implemented */
    unsigned char sym = ft->symbol[bits];
    br_read_bits(br, len); /* consume only the bits the real code used */
    return sym;
}

/* =========================================================================
 * 19. LZ77 TOKEN DECODE (length-distance pair reconstruction)
 *
 * The compressed stream is a sequence of tokens, each either a literal
 * byte or a (distance, length) back-reference into the already-decoded
 * output. Copies must proceed byte-by-byte (not memcpy) because distance
 * can be smaller than length, producing overlapping/self-referential runs
 * (e.g. run-length patterns compress to distance=1).
 * ========================================================================= */

typedef struct {
    unsigned short distance;
    unsigned short length;
    unsigned char literal;
    int is_match;
} LZ77Token;

static unsigned int decode_lz77(const LZ77Token *tokens, unsigned int num_tokens, unsigned char *out) {
    unsigned int o = 0;
    for (unsigned int i = 0; i < num_tokens; i++) {
        if (!tokens[i].is_match) {
            out[o++] = tokens[i].literal;
        } else {
            unsigned int start = o - tokens[i].distance;
            for (int j = 0; j < tokens[i].length; j++) {
                out[o] = out[start + (unsigned int)j]; /* byte-by-byte: may overlap */
                o++;
            }
        }
    }
    return o;
}

/* =========================================================================
 * 20. DELTA-ENCODED VARINT STREAM DECODE (columnar formats)
 *
 * Common in columnar/analytics formats (Parquet-style delta encoding):
 * rather than storing each value directly, store the zigzag-varint-coded
 * *difference* from the previous value, then reconstruct via running sum.
 * Compresses well for sorted or slowly-changing columns (timestamps, IDs).
 * ========================================================================= */

static unsigned int decode_delta_varint_stream(const unsigned char *data, unsigned int data_len, unsigned int *out) {
    unsigned int pos = 0, o = 0;
    unsigned int prev = 0;
    while (pos < data_len) {
        unsigned int delta = decode_leb128_signed_zigzag(data, &pos);
        prev += delta;
        out[o++] = prev;
    }
    return o;
}

/* =========================================================================
 * 21. GENERIC FIXED-WIDTH BIT-PACKING DECODE
 *
 * When a whole column's values are known to fit in W bits (W chosen per
 * block, e.g. from the block's max value), packing them at exactly W bits
 * each (no padding to byte boundaries) beats byte-aligned storage. Used in
 * Parquet, ORC, and most SIMD-friendly compressed columnar layouts.
 * ========================================================================= */

static void decode_bitpacked_fixed_width(BitReader *br, int width, unsigned int num_values, unsigned int *out) {
    for (unsigned int i = 0; i < num_values; i++) {
        out[i] = (unsigned int)br_read_bits(br, width);
    }
}

/* =========================================================================
 * Demo / self-test driver
 * ========================================================================= */

static int g_failures = 0;

static void check_u64(const char *name, unsigned int got, unsigned int want) {
    if (got == want) {
        
    } else {
        g_failures++;
    }
}

static void check_i64(const char *name, unsigned int got, unsigned int want) {
    if (got == want) {
        
    } else {
        
        g_failures++;
    }
}

int main(void) {
    unsigned char buf[256];
    BitReader br;
    BitWriter bw;

    
    bw_init(&bw, buf);
    encode_unary(&bw, 5);
    br_init(&br, buf, bw_total_bytes(&bw));
    check_u64("unary(5)", decode_unary(&br), 5);

    
    bw_init(&bw, buf);
    encode_elias_gamma(&bw, 1);
    encode_elias_gamma(&bw, 5);
    encode_elias_gamma(&bw, 17);
    br_init(&br, buf, bw_total_bytes(&bw));
    check_u64("gamma(1)", decode_elias_gamma(&br), 1);
    check_u64("gamma(5)", decode_elias_gamma(&br), 5);
    check_u64("gamma(17)", decode_elias_gamma(&br), 17);

    
    bw_init(&bw, buf);
    encode_elias_delta(&bw, 1);
    encode_elias_delta(&bw, 5);
    encode_elias_delta(&bw, 1000);
    br_init(&br, buf, bw_total_bytes(&bw));
    check_u64("delta(1)", decode_elias_delta(&br), 1);
    check_u64("delta(5)", decode_elias_delta(&br), 5);
    check_u64("delta(1000)", decode_elias_delta(&br), 1000);

    
    bw_init(&bw, buf);
    encode_rice(&bw, 0, 3);
    encode_rice(&bw, 7, 3);
    encode_rice(&bw, 100, 3);
    br_init(&br, buf, bw_total_bytes(&bw));
    check_u64("rice(0,k=3)", decode_rice(&br, 3), 0);
    check_u64("rice(7,k=3)", decode_rice(&br, 3), 7);
    check_u64("rice(100,k=3)", decode_rice(&br, 3), 100);

    
    bw_init(&bw, buf);
    encode_exp_golomb(&bw, 0);
    encode_exp_golomb(&bw, 6);
    encode_exp_golomb(&bw, 41);
    br_init(&br, buf, bw_total_bytes(&bw));
    check_u64("exp_golomb(0)", decode_exp_golomb(&br), 0);
    check_u64("exp_golomb(6)", decode_exp_golomb(&br), 6);
    check_u64("exp_golomb(41)", decode_exp_golomb(&br), 41);

    
    bw_init(&bw, buf);
    encode_fibonacci(&bw, 1);
    encode_fibonacci(&bw, 4);
    encode_fibonacci(&bw, 65);
    br_init(&br, buf, bw_total_bytes(&bw));
    check_u64("fibonacci(1)", decode_fibonacci(&br), 1);
    check_u64("fibonacci(4)", decode_fibonacci(&br), 4);
    check_u64("fibonacci(65)", decode_fibonacci(&br), 65);

    
    {
        unsigned char vb[16];
        unsigned int pos = 0;
        unsigned int n1 = encode_leb128_unsigned(300, vb);
        unsigned int n2 = encode_leb128_unsigned(624485, vb + n1);
        (void)n2;
        unsigned int v1 = decode_leb128_unsigned(vb, &pos);
        unsigned int v2 = decode_leb128_unsigned(vb, &pos);
        check_u64("leb128_unsigned(300)", v1, 300);
        check_u64("leb128_unsigned(624485)", v2, 624485);
    }

    
    {
        unsigned char vb[16];
        unsigned int pos = 0;
        unsigned int n1 = encode_leb128_signed_zigzag(-2, vb);
        encode_leb128_signed_zigzag(300, vb + n1);
        unsigned int v1 = decode_leb128_signed_zigzag(vb, &pos);
        unsigned int v2 = decode_leb128_signed_zigzag(vb, &pos);
        check_i64("leb128_signed(-2)", v1, -2);
        check_i64("leb128_signed(300)", v2, 300);
    }

    
    {
        /* 0x81 0x00 = (0x01<<7)|0x00 = 128 */
        unsigned char vb[] = {0x81, 0x00, 0x7F};
        unsigned int pos = 0;
        unsigned int v1 = decode_sqlite_varint(vb, &pos);
        unsigned int v2 = decode_sqlite_varint(vb, &pos);
        check_u64("sqlite_varint(128)", v1, 128);
        check_u64("sqlite_varint(127)", v2, 127);
    }

    
    {
        /* 0x81 0x48 = big-endian 7-bit groups: (0x01<<7)|0x48 = 200 */
        unsigned char vb[] = {0x81, 0x48, 0x40};
        unsigned int pos = 0;
        unsigned int v1 = decode_midi_vlq(vb, &pos);
        unsigned int v2 = decode_midi_vlq(vb, &pos);
        check_u64("midi_vlq(200)", v1, 200);
        check_u64("midi_vlq(64)", v2, 64);
    }

    
    {
        /* 'A' (1 byte), Euro sign U+20AC (3 bytes: E2 82 AC), U+1F600 (4 bytes) */
        unsigned char vb[] = {0x41, 0xE2, 0x82, 0xAC, 0xF0, 0x9F, 0x98, 0x80};
        unsigned int pos = 0;
        unsigned int v1 = decode_utf8(vb, &pos);
        unsigned int v2 = decode_utf8(vb, &pos);
        unsigned int v3 = decode_utf8(vb, &pos);
        check_u64("utf8('A')", v1, 0x41);
        check_u64("utf8(euro sign)", v2, 0x20AC);
        check_u64("utf8(U+1F600)", v3, 0x1F600);
    }

    
    {
        unsigned short vb[] = {0x0041, 0xD83D, 0xDE00}; /* 'A', then U+1F600 */
        unsigned int pos = 0;
        unsigned int v1 = decode_utf16(vb, &pos);
        unsigned int v2 = decode_utf16(vb, &pos);
        check_u64("utf16('A')", v1, 0x41);
        check_u64("utf16(U+1F600)", v2, 0x1F600);
    }

    
    {
        unsigned char out[64];
        unsigned int n = decode_base64("SGVsbG8sIFdvcmxkIQ==", out); /* "Hello, World!" */
        out[n] = 0;
        
    }

    
    {
        unsigned char vb[] = {0x05, 0x82, 0x01, 0x2C}; /* short form 5, int form 300 */
        unsigned int pos = 0;
        unsigned int v1 = decode_ber_length(vb, &pos);
        unsigned int v2 = decode_ber_length(vb, &pos);
        check_u64("ber_length(short=5)", v1, 5);
        check_u64("ber_length(int=300)", v2, 300);
    }

    
    {
        /* literal run "AB", then repeat 'X' 4 times: [1,'A','B', -3,'X'] */
        unsigned char vb[] = {1, 'A', 'B', (unsigned char)-3, 'X'};
        unsigned char out[16];
        unsigned int n = decode_rle_packbits(vb, sizeof(vb), out);
        
    }

    
    {
        /* run of 3 zeros, run of 2 ones, run of 1 zero:
           unary(2)=110, unary(1)=10, unary(0)=0 -> bits: 1 1 0 1 0 0 */
        bw_init(&bw, buf);
        encode_unary(&bw, 2);
        encode_unary(&bw, 1);
        encode_unary(&bw, 0);
        br_init(&br, buf, bw_total_bytes(&bw));
        unsigned char bits[16];
        unsigned int n = decode_rle_bitwise(&br, bits, 6);
        unsigned char expect[] = {0,0,0,1,1,0};
    
    }

    
    {
        /* Encoding "banana" under MTF with an a-z initial table would need
           a full 256-symbol alphabet; demonstrate with a small custom table
           instead: indices chosen assuming identity-initialized 256 table
           and input bytes 'b','a','n','a','n','a'. */
        unsigned char indices[] = {'b', 'a' + 1, 'n' + 1, 1, 1, 1};
        /*
         * table starts as identity (0..255).
         * 'b' (idx='b'=98) -> emits table[98]='b', moves 'b' to front
         * 'a' is now at index 97+1=98? simpler: just verify round-trip
         * property instead of hand-deriving indices; see encode below.
         */
        (void)indices;
        unsigned char table[256];
        for (int i = 0; i < 256; i++) table[i] = (unsigned char)i;
        const char *msg = "banana";
        unsigned int len = 12;
        unsigned char enc_idx[16];
        /* encode: for each symbol, find its index in current table, emit
           index, move symbol to front (mirrors decode_mtf's own table
           management so this is a true round-trip test) */
        for (unsigned int i = 0; i < len; i++) {
            unsigned char sym = (unsigned char)msg[i];
            int idx = 0;
            while (table[idx] != sym) idx++;
            enc_idx[i] = (unsigned char)idx;
            for (int j = idx; j > 0; j--) table[j] = table[j - 1];
            table[0] = sym;
        }
        unsigned char out[16];
        decode_mtf(enc_idx, len, out);
        
    }

    
    {
        /* 5-symbol alphabet, typical skewed length distribution:
           symbols 'A'..'E', lengths {2,2,2,3,3} */
        HuffmanCodeLengths cl;

        cl.num_symbols = 256;
        cl.lengths['A'] = 2;
        cl.lengths['B'] = 2;
        cl.lengths['C'] = 2;
        cl.lengths['D'] = 3;
        cl.lengths['E'] = 3;

        CanonicalHuffmanTable t;
        build_canonical_huffman(&cl, &t);

        FastHuffmanTable ft;
        build_fast_huffman_table(&t, &ft);

        const char *msg = "ABCDEA";
        bw_init(&bw, buf);
        for (const char *p = msg; *p; p++) {
            unsigned int code;
            int len;
            if (get_huffman_code(&t, &cl, (unsigned char)*p, &code, &len) != 0) {
                
                g_failures++;
                continue;
            }
            bw_write_bits(&bw, code, len);
        }

        /* decode with the memory-efficient bit-serial walker */
        br_init(&br, buf, bw_total_bytes(&bw));
        char out1[16];
        for (unsigned int i = 0; i < 12; i++) {
            int sym = decode_huffman_bitserial(&br, &t);
            out1[i] = (char)sym;
        }
        out1[12] = 0;

        /* decode with the time-efficient table-driven walker */
        br_init(&br, buf, bw_total_bytes(&bw));
        char out2[16];
        for (unsigned int i = 0; i < 12; i++) {
            int sym = decode_huffman_table_driven(&br, &ft);
            out2[i] = (char)sym;
        }
        out2[12] = 0;
    }

    
    {
        /* "abcabcabc" as: literals a,b,c then two back-references */
        LZ77Token toks[] = {
            {0, 0, 'a', 0},
            {0, 0, 'b', 0},
            {0, 0, 'c', 0},
            {3, 6, 0, 1}, /* copy 6 bytes from 3 back: reconstructs "abcabc" */
        };
        unsigned char out[16];
        unsigned int n = decode_lz77(toks, 4, out);
        
    }

    
    {
        /* values 100, 103, 101, 150 -> deltas 100, 3, -2, 49 */
        unsigned char vb[32];
        unsigned int p = 0;
        p += encode_leb128_signed_zigzag(100, vb + p);
        p += encode_leb128_signed_zigzag(3, vb + p);
        p += encode_leb128_signed_zigzag(-2, vb + p);
        p += encode_leb128_signed_zigzag(49, vb + p);
        unsigned int out[8];
        unsigned int n = decode_delta_varint_stream(vb, p, out);
        int ok = (n == 4 && out[0] == 100 && out[1] == 103 && out[2] == 101 && out[3] == 150);
        
    }

    
    {
        /* five 5-bit values: 3, 31, 0, 17, 8 */
        bw_init(&bw, buf);
        bw_write_bits(&bw, 3, 5);
        bw_write_bits(&bw, 31, 5);
        bw_write_bits(&bw, 0, 5);
        bw_write_bits(&bw, 17, 5);
        bw_write_bits(&bw, 8, 5);
        br_init(&br, buf, bw_total_bytes(&bw));
        unsigned int out[5];
        decode_bitpacked_fixed_width(&br, 5, 5, out);
        int ok = (out[0]==3 && out[1]==31 && out[2]==0 && out[3]==17 && out[4]==8);
    }

    return g_failures == 0 ? 0 : 1;
}