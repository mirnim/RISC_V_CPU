module alu import constants::*; (
    input alu_op_enum alu_op,
    input logic [31:0] input1,
    input logic [31:0] input2,

    output logic [31:0] result
);

    always_comb begin
        result = 32'b0;
        case (alu_op)
        ALU_NONE: ;
        ALU_ADD: result = input1 + input2;
        ALU_SUB: result = input1 - input2;
        ALU_AND: result = input1 & input2;
        ALU_OR: result = input1 | input2;
        ALU_XOR: result = input1 ^ input2;
        ALU_SLL: result = input1 << input2[4:0];
        ALU_SRL: result = input1 >> input2[4:0];
        ALU_SRA: result = $signed(input1) >>> input2[4:0];
        ALU_SLT: result = ($signed(input1) < $signed(input2)) ? 32'b1 : 32'b0;
        ALU_SLTU: result = (input1 < input2) ? 32'b1 : 32'b0;
        ALU_ANDN: result = input1 & ~input2;
        ALU_ORN: result = input1 | ~input2;
        ALU_XNOR: result = ~(input1 ^ input2);
        ALU_CLZ: begin
            for (i = 31; i >= 0; i = i-1) begin
                if (input1[i]) begin
                    result = 32-i;
                    break;
                end
            end
        end
        ALU_CTZ: begin
            for (i = 0; i < 32; i = i+1) begin
                if (input1[i]) begin
                    result = i;
                    break;
                end
            end
        end
        ALU_CPOP: begin
            for (i = 0; i < 32; i = i+1) begin
                if (input1[i]) begin
                    result = result + 1;
                end
            end
        end
        
        default: ;
        endcase
    end
endmodule
