module instruction_decode( //COMBINATORIAL
    output logic reg_write,
    output logic jump,

    output logic [2:0] load_type,
    output logic [1:0] store_type,
    output logic [2:0] writeback_type,
    output logic [2:0] branch_type,
    output logic [0:0] alu_source, //0 is reg&reg, 1 is reg&imm
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
               JUMP = 7'b1100011;
               

    typedef enum logic [2:0] {
        writeback_NONE,
        writeback_ALU,
        writeback_MEM,
        writeback_PC4,
        writeback_IMM
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

    typedef enum logic [0:0] {
        REG_REG,
        REG_IMM
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
        
        case (opcode) begin
            LOAD: begin
                reg_write = 1;
                writeback_type = WRITEBACK_MEM;
                alu_source = REG_IMM;
                imm_type = IMM_I;
                case (func3) begin
                    000: load_type = LOAD_BYTE;
                    001: load_type = LOAD_HALF;
                    010: load_type = LOAD_WORD;
                    100: load_type = LOAD_BYTE_U;
                    101: load_type = LOAD_HALF_U;
                end
            end
            STORE: begin
                alu_source = REG_IMM;
                imm_type = IMM_S;
                case (func3) begin
                    000: store_type = STORE_BYTE;
                    001: store_type = STORE_HALF;
                    010: store_type = STORE_WORD;
                end
            end
            R_TYPE: begin
                reg_write = 1;
                writeback_type = WRITEBACK_ALU;
                alu_source = REG_REG;
                case (func7) begin
                    7'b0000000: begin
                        case (func3) begin
                            000: alu_op = ALU_ADD;
                            001: alu_op = ALU_SLL;
                            010: alu_op = ALU_SLT;
                            011: alu_op = ALU_SLTU;
                            100: alu_op = ALU_XOR;
                            101: alu_op = ALU_SRL;
                            110: alu_op = ALU_OR;
                            111: alu_op = ALU_AND;
                        end
                    end
                    7'b0100000: begin
                        case (func3) begin
                            000: alu_op = ALU_SUB;
                            101: alu_op = ALU_SRA;
                        end
                    end
                end
            end
            I_TYPE: begin
                reg_write = 1;
                writeback_type = WRITEBACK_ALU;
                alu_source = REG_IMM;
                imm_type = IMM_I;
                case (func3) begin
                    
                end
            end
            JUMP: begin
                
            end
        end
    end
endmodule