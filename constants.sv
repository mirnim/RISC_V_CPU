package constants;
    parameter LOAD = 7'b0000011, 
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
    } writeback_type_enum;

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

    typedef enum logic [3:0] {
        BRANCH_NONE,
        BRANCH_BEQ,
        BRANCH_BNE,
        BRANCH_BLT,
        BRANCH_BGE,
        BRANCH_BLTU,
        BRANCH_BGEU,
        BRANCH_JAL,
        BRANCH_JALR
    } branch_type_enum;

    typedef enum logic [0:0] {
        INPUT1_REG,
        INPUT1_PC
    } alu_source1_enum;

    typedef enum logic [0:0] {
        INPUT2_REG,
        INPUT2_IMM
    } alu_source2_enum;

    typedef enum logic [3:0] {
        ALU_NONE,
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

    typedef enum logic [1:0] {
        FORWARD_NONE,
        FORWARD_EX_MEM,
        FORWARD_MEM_WB
    } forward_type_enum;
    
endpackage
