module instruction_decode(
    output logic reg_write,
    output logic mem_read,
    output logic mem_write,
    output logic mem_to_reg,
    output logic ALU_source, //0 is reg&reg, 1 is reg&imm
    output logic branch,

    output logic [2:0] load_type,
    output logic [1:0] store_type,
    output logic [2:0] write_back_type,
    output logic [2:0] branch_type,
    output logic [2:0] compare_type,
    output logic [3:0] ALU_op,

    input logic [31:0] instruction
); 

    localparam LOAD = 7'b0000011, 
               STORE = 7'b0100011,
               JUMP = 7'b1100011, 
               R_TYPE = 7'b0110011,
               I_TYPE = 7'b0010011;

    typedef enum logic [2:0] {
        WRITE_BACK_NONE,
        WRITE_BACK_ALU,
        WRITE_BACK_MEM,
        WRITE_BACK_PC4,
        WRITE_BACK_IMM
    } write_back_enum;

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

    function void set_status(input reg_write_input,
                             input mem_read_input, 
                             input mem_write_input, 
                             input mem_to_reg_input, 
                             input ALU_source_input,
                             input branch_input,
                             input [2:0] write_back_type_input,
                             input [2:0] load_type_input,
                             input [1:0] store_type_input,
                             input [2:0] branch_type_input,
                             input [3:0] ALU_op_input
                             );
        reg_write = reg_write_input;
        mem_read = mem_read_input;
        mem_write = mem_write_input;
        mem_to_reg = mem_to_reg_input;
        ALU_source = ALU_source_input;
        branch = branch_input;
        write_back_type = write_back_type_input;
        load_type = load_type_input;
        store_type = store_type_input;
        branch_type = branch_type_input;
        ALU_op = ALU_op_input;
    endfunction
    
    wire [6:0] opcode = instruction[6:0];
    wire [2:0] funct3 = instruction[14:12];
    wire [6:0] funct7 = instruction[31:25];
    wire [4:0] rd =  instruction[11:7];
    wire [4:0] rs1 = instruction[19:15];
    wire [4:0] rs2 = instruction[24:20];
    
    always_comb begin
        set_status(0, 0, 0, 0, 0, 0, WRITE_BACK_NONE, LOAD_NONE, STORE_NONE, BRANCH_NONE, ALU_ADD);
        case (instruction[6:0]) begin
            LOAD: begin
                
                set_status(1, 1, 0, 1, 1, 0, 4'b0010)
            end
            STORE: begin
                reg_write = 0;
                mem_read = 0;
                mem_write = 1;
                mem_to_reg = 0;
                ALU_source = 1;
                branch = 0;
                ALU_op = 4'b0010;
            end
            JUMP: begin
                reg_write = 0;
                mem_read = 0;
                mem_write = 1;
                mem_to_reg = 0;
                ALU_source = 0;
                branch = 1;
                ALU_op = 4'b0110;
            end
            R_TYPE: begin
                reg_write = 1;
                mem_read = 0;
                mem_write = 0;
                mem_to_reg = 0;
                ALU_source = 1;
                branch = 0;
                ALU_op
            end
            I_TYPE: begin
                
            end
            default: begin
                reg_write = 0;
                mem_read = 0;
                mem_write = 0;
                mem_to_reg = 0;
                ALU_source = 0;
                branch = 0;
                ALU_op = 4'b0000;
            end
        end
    end
endmodule