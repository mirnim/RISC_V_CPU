module instruction_decode( //COMBINATORIAL
    output logic reg_write,
    output logic jump,

    output logic [2:0] load_type,
    output logic [1:0] store_type,
    output logic [2:0] writeback_type,
    output logic [2:0] branch_type,
    output logic [1:0] alu_source,
    output logic [3:0] alu_op,
    output logic [2:0] imm_type,

    output logic [4:0] rd,
    output logic [4:0] rs1,
    output logic [4:0] rs2,

    input logic [31:0] instruction
); 

    localparam LOAD = 7'b0000011, 
               STORE = 7'b0100011,
               R_TYPE = 7'b0110011,
               I_TYPE = 7'b0010011,
               BRANCH = 7'b1100011,
               JALR = 7'b1100111, //jump & link (register + offset)
               LUI = 7'b0110111, //load upper immediate
               AUIPC = 7'b0010111, //add upper immediate to PC
               JAL = 7'b1101111; //jump & link (immediate)

    typedef enum logic [2:0] {
        WRITEBACK_NONE,
        WRITEBACK_ALU,
        WRITEBACK_MEM,
        WRITEBACK_PC4,
        WRITEBACK_IMM
    } writeback_enum;

    typedef enum logic [2:0] {
        LOAD_NONE,
        LOAD_BYTE,
        LOAD_HALF,
        LOAD_WORD,
        LOAD_BYTE_U,
        LOAD_HALF_U
    } load_type_enum;

    typedef enum logic [1:0] {
        STORE_NONE,
        STORE_BYTE,
        STORE_HALF,
        STORE_WORD
    } store_type_enum;

    typedef enum logic [2:0] {
        BRANCH_NONE,
        BRANCH_BEQ,
        BRANCH_BNE,
        BRANCH_BLT,
        BRANCH_BGE,
        BRANCH_BLTU,
        BRANCH_BGEU
    } branch_type_enum;

    typedef enum logic [1:0] {
        REG_REG,
        REG_IMM,
        PC_IMM
    } alu_source_enum;

    typedef enum logic [3:0] {
        ALU_ADD,
        ALU_SUB,
        ALU_AND,
        ALU_OR,
        ALU_XOR,
        ALU_SLL, //Shift left logical
        ALU_SRL, //Shift right logical
        ALU_SRA, //Shift right arithmetic (keeps sign bit)
        ALU_SLT, //Set less than (1 if A<B else 0)
        ALU_SLTU //SLT but with unsigned
    } alu_op_enum;

    typedef enum logic [2:0] {
        IMM_NONE,
        IMM_I,
        IMM_S,
        IMM_B,
        IMM_U,
        IMM_J
    } imm_type_enum;
    
    wire [6:0] opcode = instruction[6:0];
    wire [2:0] funct3 = instruction[14:12];
    wire [6:0] funct7 = instruction[31:25];
    assign rd =  instruction[11:7];
    assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    
    always_comb begin
        reg_write = 0;
        jump = 0;
        load_type = LOAD_NONE;
        store_type = STORE_NONE;
        writeback_type = WRITEBACK_NONE;
        branch_type = BRANCH_NONE;
        alu_source = REG_REG;
        alu_op = ALU_ADD;
        imm_type = IMM_NONE;
        
        case (opcode)
            LOAD: begin
                reg_write = 1;
                writeback_type = WRITEBACK_MEM;
                alu_source = REG_IMM;
                imm_type = IMM_I;
                case (func3)
                    3'b000: load_type = LOAD_BYTE;
                    3'b001: load_type = LOAD_HALF;
                    3'b010: load_type = LOAD_WORD;
                    3'b100: load_type = LOAD_BYTE_U;
                    3'b101: load_type = LOAD_HALF_U;
                endcase
            end
            STORE: begin
                alu_source = REG_IMM;
                imm_type = IMM_S;
                case (func3)
                    3'b000: store_type = STORE_BYTE;
                    3'b001: store_type = STORE_HALF;
                    3'b010: store_type = STORE_WORD;
                endcase
            end
            R_TYPE: begin
                reg_write = 1;
                writeback_type = WRITEBACK_ALU;
                alu_source = REG_REG;
                case (func7)
                    7'b0000000: begin
                        case (func3)
                            3'b000: alu_op = ALU_ADD;
                            3'b001: alu_op = ALU_SLL;
                            3'b010: alu_op = ALU_SLT;
                            3'b011: alu_op = ALU_SLTU;
                            3'b100: alu_op = ALU_XOR;
                            3'b101: alu_op = ALU_SRL;
                            3'b110: alu_op = ALU_OR;
                            3'b111: alu_op = ALU_AND;
                        endcase
                    end
                    7'b0100000: begin
                        case (func3)
                            3'b000: alu_op = ALU_SUB;
                            3'b101: alu_op = ALU_SRA;
                        endcase
                    end
                endcase
            end
            I_TYPE: begin
                reg_write = 1;
                writeback_type = WRITEBACK_ALU;
                alu_source = REG_IMM;
                imm_type = IMM_I;
                case (func3)
                    3'b000: alu_op = ALU_ADD;
                    3'b001: alu_op = ALU_SLL;
                    3'b010: alu_op = ALU_SLT;
                    3'b011: alu_op = ALU_SLTU;
                    3'b100: alu_op = ALU_XOR;
                    3'b101: case (func7)
                        7'b0000000: alu_op = ALU_SRL;
                        7'b0100000: alu_op = ALU_SRA;
                    endcase
                    3'b110: alu_op = ALU_OR;
                    3'b111: alu_op = ALU_AND;
                endcase
            end
            BRANCH: begin
                imm_type = IMM_B;
                case (func3)
                    3'b000: branch_type = BRANCH_BEQ;
                    3'b001: branch_type = BRANCH_BNE;
                    3'b100: branch_type = BRANCH_BLT;
                    3'b101: branch_type = BRANCH_BGE;
                    3'b110: branch_type = BRANCH_BLTU;
                    3'b111: branch_type = BRANCH_BGEU;
                endcase
            end
            JALR: begin
                reg_write = 1;
                jump = 1;
                writeback_type = WRITEBACK_PC4;
                alu_source = REG_IMM;
                imm_type = IMM_I;
            end
            LUI: begin
                reg_write = 1;
                writeback_type = WRITEBACK_IMM;
                imm_type = IMM_U;
            end
            AUIPC: begin
                reg_write = 1;
                writeback_type = WRITEBACK_ALU;
                alu_source = PC_IMM;
                imm_type = IMM_U;
            end
            JAL: begin
                reg_write = 1;
                jump = 1;
                writeback_type = WRITEBACK_PC4;
                alu_source = PC_IMM;
                imm_type = IMM_J;
            end
        end
    end
endmodule