# 1 "compiler_test.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 384 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "compiler_test.c" 2








enum
{
   PJPG_NO_MORE_BLOCKS = 1,
   PJPG_BAD_DHT_COUNTS,
   PJPG_BAD_DHT_INDEX,
   PJPG_BAD_DHT_MARKER,
   PJPG_BAD_DQT_MARKER,
   PJPG_BAD_DQT_TABLE,
   PJPG_BAD_PRECISION,
   PJPG_BAD_HEIGHT,
   PJPG_BAD_WIDTH,
   PJPG_TOO_MANY_COMPONENTS,
   PJPG_BAD_SOF_LENGTH,
   PJPG_BAD_VARIABLE_MARKER,
   PJPG_BAD_DRI_LENGTH,
   PJPG_BAD_SOS_LENGTH,
   PJPG_BAD_SOS_COMP_ID,
   PJPG_W_EXTRA_BYTES_BEFORE_MARKER,
   PJPG_NO_ARITHMITIC_SUPPORT,
   PJPG_UNEXPECTED_MARKER,
   PJPG_NOT_JPEG,
   PJPG_UNSUPPORTED_MARKER,
   PJPG_BAD_DQT_LENGTH,
   PJPG_TOO_MANY_BLOCKS,
   PJPG_UNDEFINED_QUANT_TABLE,
   PJPG_UNDEFINED_HUFF_TABLE,
   PJPG_NOT_SINGLE_SCAN,
   PJPG_UNSUPPORTED_COLORSPACE,
   PJPG_UNSUPPORTED_SAMP_FACTORS,
   PJPG_DECODE_ERROR,
   PJPG_BAD_RESTART_MARKER,
   PJPG_ASSERTION_ERROR,
   PJPG_BAD_SOS_SPECTRAL,
   PJPG_BAD_SOS_SUCCESSIVE,
   PJPG_STREAM_READ_ERROR,
   PJPG_NOTENOUGHMEM,
   PJPG_UNSUPPORTED_COMP_IDENT,
   PJPG_UNSUPPORTED_QUANT_TABLE,
   PJPG_UNSUPPORTED_MODE,
};


typedef enum
{
   PJPG_GRAYSCALE,
   PJPG_YH1V1,
   PJPG_YH2V1,
   PJPG_YH1V2,
   PJPG_YH2V2
} pjpeg_scan_type_t;

typedef struct
{

   int m_width;
   int m_height;


   int m_comps;


   int m_MCUSPerRow;
   int m_MCUSPerCol;


   pjpeg_scan_type_t m_scanType;


   int m_MCUWidth;
   int m_MCUHeight;
# 104 "compiler_test.c"
   unsigned char *m_pMCUBufR;
   unsigned char *m_pMCUBufG;
   unsigned char *m_pMCUBufB;
} pjpeg_image_info_t;

typedef unsigned char (*pjpeg_need_bytes_callback_t)(unsigned char* pBuf, unsigned char buf_size, unsigned char *pBytes_actually_read, void *pCallback_data);





unsigned char pjpeg_decode_init(pjpeg_image_info_t *pInfo, pjpeg_need_bytes_callback_t pNeed_bytes_callback, void *pCallback_data, unsigned char reduce);




unsigned char pjpeg_decode_mcu(void);
# 140 "compiler_test.c"
typedef unsigned char uint8;
typedef unsigned short uint16;
typedef signed char int8;
typedef signed short int16;
# 196 "compiler_test.c"
typedef enum
{
   M_SOF0 = 0xC0,
   M_SOF1 = 0xC1,
   M_SOF2 = 0xC2,
   M_SOF3 = 0xC3,

   M_SOF5 = 0xC5,
   M_SOF6 = 0xC6,
   M_SOF7 = 0xC7,

   M_JPG = 0xC8,
   M_SOF9 = 0xC9,
   M_SOF10 = 0xCA,
   M_SOF11 = 0xCB,

   M_SOF13 = 0xCD,
   M_SOF14 = 0xCE,
   M_SOF15 = 0xCF,

   M_DHT = 0xC4,

   M_DAC = 0xCC,

   M_RST0 = 0xD0,
   M_RST1 = 0xD1,
   M_RST2 = 0xD2,
   M_RST3 = 0xD3,
   M_RST4 = 0xD4,
   M_RST5 = 0xD5,
   M_RST6 = 0xD6,
   M_RST7 = 0xD7,

   M_SOI = 0xD8,
   M_EOI = 0xD9,
   M_SOS = 0xDA,
   M_DQT = 0xDB,
   M_DNL = 0xDC,
   M_DRI = 0xDD,
   M_DHP = 0xDE,
   M_EXP = 0xDF,

   M_APP0 = 0xE0,
   M_APP15 = 0xEF,

   M_JPG0 = 0xF0,
   M_JPG13 = 0xFD,
   M_COM = 0xFE,

   M_TEM = 0x01,

   M_ERROR = 0x100,

   RST0 = 0xD0
} JPEG_MARKER;

static const int8 ZAG[] =
{
   0, 1, 8, 16, 9, 2, 3, 10,
   17, 24, 32, 25, 18, 11, 4, 5,
   12, 19, 26, 33, 40, 48, 41, 34,
   27, 20, 13, 6, 7, 14, 21, 28,
   35, 42, 49, 56, 57, 50, 43, 36,
   29, 22, 15, 23, 30, 37, 44, 51,
   58, 59, 52, 45, 38, 31, 39, 46,
   53, 60, 61, 54, 47, 55, 62, 63,
};


static int16 gCoeffBuf[8*8];


static uint8 gMCUBufR[256];
static uint8 gMCUBufG[256];
static uint8 gMCUBufB[256];


static int16 gQuant0[8*8];
static int16 gQuant1[8*8];


static int16 gLastDC[3];

typedef struct HuffTableT
{
   uint16 mMinCode[16];
   uint16 mMaxCode[16];
   uint8 mValPtr[16];
} HuffTable;


static HuffTable gHuffTab0;

static uint8 gHuffVal0[16];

static HuffTable gHuffTab1;
static uint8 gHuffVal1[16];


static HuffTable gHuffTab2;
static uint8 gHuffVal2[256];

static HuffTable gHuffTab3;
static uint8 gHuffVal3[256];

static uint8 gValidHuffTables;
static uint8 gValidQuantTables;

static uint8 gTemFlag;

static uint8 gInBuf[256];
static uint8 gInBufOfs;
static uint8 gInBufLeft;

static uint16 gBitBuf;
static uint8 gBitsLeft;

static uint16 gImageXSize;
static uint16 gImageYSize;
static uint8 gCompsInFrame;
static uint8 gCompIdent[3];
static uint8 gCompHSamp[3];
static uint8 gCompVSamp[3];
static uint8 gCompQuant[3];

static uint16 gRestartInterval;
static uint16 gNextRestartNum;
static uint16 gRestartsLeft;

static uint8 gCompsInScan;
static uint8 gCompList[3];
static uint8 gCompDCTab[3];
static uint8 gCompACTab[3];

static pjpeg_scan_type_t gScanType;

static uint8 gMaxBlocksPerMCU;
static uint8 gMaxMCUXSize;
static uint8 gMaxMCUYSize;
static uint16 gMaxMCUSPerRow;
static uint16 gMaxMCUSPerCol;

static uint16 gNumMCUSRemainingX, gNumMCUSRemainingY;

static uint8 gMCUOrg[6];

static pjpeg_need_bytes_callback_t g_pNeedBytesCallback;
static void *g_pCallback_data;
static uint8 gCallbackStatus;
static uint8 gReduce;

static void fillInBuf(void)
{
   unsigned char status;


   gInBufOfs = 4;
   gInBufLeft = 0;

   status = (*g_pNeedBytesCallback)(gInBuf + gInBufOfs, 256 - gInBufOfs, &gInBufLeft, g_pCallback_data);
   if (status)
   {


      gCallbackStatus = status;
   }
}

static uint8 getChar(void)
{
   if (!gInBufLeft)
   {
      fillInBuf();
      if (!gInBufLeft)
      {
         gTemFlag = ~gTemFlag;
         return gTemFlag ? 0xFF : 0xD9;
      }
   }

   gInBufLeft--;
   return gInBuf[gInBufOfs++];
}

static void stuffChar(uint8 i)
{
   gInBufOfs--;
   gInBuf[gInBufOfs] = i;
   gInBufLeft++;
}

static uint8 getOctet(uint8 FFCheck)
{
   uint8 c = getChar();

   if ((FFCheck) && (c == 0xFF))
   {
      uint8 n = getChar();

      if (n)
      {
         stuffChar(n);
         stuffChar(0xFF);
      }
   }

   return c;
}

static uint16 getBits(uint8 numBits, uint8 FFCheck)
{
   uint8 origBits = numBits;
   uint16 ret = gBitBuf;

   if (numBits > 8)
   {
      numBits -= 8;

      gBitBuf <<= gBitsLeft;

      gBitBuf |= getOctet(FFCheck);

      gBitBuf <<= (8 - gBitsLeft);

      ret = (ret & 0xFF00) | (gBitBuf >> 8);
   }

   if (gBitsLeft < numBits)
   {
      gBitBuf <<= gBitsLeft;

      gBitBuf |= getOctet(FFCheck);

      gBitBuf <<= (numBits - gBitsLeft);

      gBitsLeft = 8 - (numBits - gBitsLeft);
   }
   else
   {
      gBitsLeft = (uint8)(gBitsLeft - numBits);
      gBitBuf <<= numBits;
   }

   return ret >> (16 - origBits);
}

static uint16 getBits1(uint8 numBits)
{
   return getBits(numBits, 0);
}

static uint16 getBits2(uint8 numBits)
{
   return getBits(numBits, 1);
}

static uint8 getBit(void)
{
   uint8 ret = 0;
   if (gBitBuf & 0x8000)
      ret = 1;

   if (!gBitsLeft)
   {
      gBitBuf |= getOctet(1);

      gBitsLeft += 8;
   }

   gBitsLeft--;
   gBitBuf <<= 1;

   return ret;
}

static uint16 getExtendTest(uint8 i)
{
   switch (i)
   {
      case 0: return 0;
      case 1: return 0x0001;
      case 2: return 0x0002;
      case 3: return 0x0004;
      case 4: return 0x0008;
      case 5: return 0x0010;
      case 6: return 0x0020;
      case 7: return 0x0040;
      case 8: return 0x0080;
      case 9: return 0x0100;
      case 10: return 0x0200;
      case 11: return 0x0400;
      case 12: return 0x0800;
      case 13: return 0x1000;
      case 14: return 0x2000;
      case 15: return 0x4000;
      default: return 0;
   }
}

static int16 getExtendOffset(uint8 i)
{
   switch (i)
   {
      case 0: return 0;
      case 1: return ((-1)<<1) + 1;
      case 2: return ((-1)<<2) + 1;
      case 3: return ((-1)<<3) + 1;
      case 4: return ((-1)<<4) + 1;
      case 5: return ((-1)<<5) + 1;
      case 6: return ((-1)<<6) + 1;
      case 7: return ((-1)<<7) + 1;
      case 8: return ((-1)<<8) + 1;
      case 9: return ((-1)<<9) + 1;
      case 10: return ((-1)<<10) + 1;
      case 11: return ((-1)<<11) + 1;
      case 12: return ((-1)<<12) + 1;
      case 13: return ((-1)<<13) + 1;
      case 14: return ((-1)<<14) + 1;
      case 15: return ((-1)<<15) + 1;
      default: return 0;
   }
};

static int16 huffExtend(uint16 x, uint8 s)
{
   return ((x < getExtendTest(s)) ? ((int16)x + getExtendOffset(s)) : (int16)x);
}

static uint8 huffDecode(const HuffTable* pHuffTable, const uint8* pHuffVal)
{
   uint8 i = 0;
   uint8 j;
   uint16 code = getBit();




   for ( ; ; )
   {
      uint16 maxCode;

      if (i == 16)
         return 0;

      maxCode = pHuffTable->mMaxCode[i];
      if ((code <= maxCode) && (maxCode != 0xFFFF))
         break;

      i++;
      code <<= 1;
      code |= getBit();
   }

   j = pHuffTable->mValPtr[i];
   j = (uint8)(j + (code - pHuffTable->mMinCode[i]));

   return pHuffVal[j];
}

static void huffCreate(const uint8* pBits, HuffTable* pHuffTable)
{
   uint8 i = 0;
   uint8 j = 0;

   uint16 code = 0;

   for ( ; ; )
   {
      uint8 num = pBits[i];

      if (!num)
      {
         pHuffTable->mMinCode[i] = 0x0000;
         pHuffTable->mMaxCode[i] = 0xFFFF;
         pHuffTable->mValPtr[i] = 0;
      }
      else
      {
         pHuffTable->mMinCode[i] = code;
         pHuffTable->mMaxCode[i] = code + num - 1;
         pHuffTable->mValPtr[i] = j;

         j = (uint8)(j + num);

         code = (uint16)(code + num);
      }

      code <<= 1;

      i++;
      if (i > 15)
         break;
   }
}

static HuffTable* getHuffTable(uint8 index)
{


   switch (index)
   {
      case 0: return &gHuffTab0;
      case 1: return &gHuffTab1;
      case 2: return &gHuffTab2;
      case 3: return &gHuffTab3;
      default: return 0;
   }
}

static uint8* getHuffVal(uint8 index)
{


   switch (index)
   {
      case 0: return gHuffVal0;
      case 1: return gHuffVal1;
      case 2: return gHuffVal2;
      case 3: return gHuffVal3;
      default: return 0;
   }
}

static uint16 getMaxHuffCodes(uint8 index)
{
   return (index < 2) ? 12 : 255;
}

static uint8 readDHTMarker(void)
{
   uint8 bits[16];
   uint16 left = getBits1(16);

   if (left < 2)
      return PJPG_BAD_DHT_MARKER;

   left -= 2;

   while (left)
   {
      uint8 i, tableIndex, index;
      uint8* pHuffVal;
      HuffTable* pHuffTable;
      uint16 count, totalRead;

      index = (uint8)getBits1(8);

      if ( ((index & 0xF) > 1) || ((index & 0xF0) > 0x10) )
         return PJPG_BAD_DHT_INDEX;

      tableIndex = ((index >> 3) & 2) + (index & 1);

      pHuffTable = getHuffTable(tableIndex);
      pHuffVal = getHuffVal(tableIndex);

      gValidHuffTables |= (1 << tableIndex);

      count = 0;
      for (i = 0; i <= 15; i++)
      {
         uint8 n = (uint8)getBits1(8);
         bits[i] = n;
         count = (uint16)(count + n);
      }

      if (count > getMaxHuffCodes(tableIndex))
         return PJPG_BAD_DHT_COUNTS;

      for (i = 0; i < count; i++)
         pHuffVal[i] = (uint8)getBits1(8);

      totalRead = 1 + 16 + count;

      if (left < totalRead)
         return PJPG_BAD_DHT_MARKER;

      left = (uint16)(left - totalRead);

      huffCreate(bits, pHuffTable);
   }

   return 0;
}
