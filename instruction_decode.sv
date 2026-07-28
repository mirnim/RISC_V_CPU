module instruction_decode import constants::*; ( 
    input logic [31:0] instruction,

    output logic reg_write,

    output load_type_enum load_type,
    output store_type_enum store_type,
    output writeback_type_enum writeback_type,
    output branch_type_enum branch_type,
    output alu_source1_enum alu_source1,
    output alu_source2_enum alu_source2,
    output alu_op_enum alu_op,
    output imm_type_enum imm_type,

    output logic [4:0] rd,
    output logic [4:0] rs1,
    output logic [4:0] rs2
); 
    
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
        alu_source1 = INPUT1_REG;
        alu_source2 = INPUT2_REG;
        alu_op = ALU_ADD;
        imm_type = IMM_NONE;
        
        case (opcode)
            LOAD: begin
                reg_write = 1;
                writeback_type = WRITEBACK_MEM;
                alu_source1 = INPUT1_REG;
                alu_source2 = INPUT2_IMM;
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
                alu_source1 = INPUT1_REG;
                alu_source2 = INPUT2_IMM;
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
                alu_source1 = INPUT1_REG;
                alu_source2 = INPUT2_IMM;
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
                alu_op = ALU_NONE;
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
                alu_op = ALU_NONE;
                branch_type = BRANCH_JALR;
                writeback_type = WRITEBACK_PC4;
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
                alu_source1 = INPUT1_PC;
                alu_source2 = INPUT2_IMM;
                imm_type = IMM_U;
            end
            JAL: begin
                reg_write = 1;
                alu_op = ALU_NONE;
                branch_type = BRANCH_JAL;
                writeback_type = WRITEBACK_PC4;
                imm_type = IMM_J;
            end
        end
    end
endmodule