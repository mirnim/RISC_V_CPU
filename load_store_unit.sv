module load_store_unit import constants::*; (
    input load_type_enum load_type,
    input store_type_enum store_type,

    input logic [31:0] address,

    input logic [31:0] memory_read_data,
    input logic [31:0] store_data,

    output logic [31:0] write_data,
    output logic [3:0] byte_enable,

    output logic [31:0] load_result
);

    logic [7:0] selected_byte;
    logic [15:0] selected_half;

    always_comb begin
        selected_byte = 8'b0;
        selected_half = 16'b0;

        case (address[1:0])
            2'b00: begin
                selected_byte = memory_read_data[7:0];
                selected_half = memory_read_data[15:0];
            end
            2'b01: selected_byte = memory_read_data[15:8];
            2'b10: begin
                selected_byte = memory_read_data[23:16];
                selected_half = memory_read_data[31:16];
            end
            2'b11: selected_byte = memory_read_data[31:24];
        endcase

        write_data = 32'b0;
        byte_enable = 4'b0;
        load_result = 32'b0;

        if (load_type != LOAD_NONE) begin
            case (load_type)
                LOAD_BYTE: load_result = {{24{selected_byte[7]}}, selected_byte};
                LOAD_HALF: load_result = {{16{selected_half[15]}}, selected_half};
                LOAD_WORD: if (address[1:0] == 2'b00) load_result = memory_read_data;
                LOAD_BYTE_U: load_result = {24'b0, selected_byte};
                LOAD_HALF_U: load_result = {16'b0, selected_half};
            endcase
        end
        else if (store_type != STORE_NONE) begin
            case (store_type)
                STORE_BYTE: begin
                    case (address[1:0])
                        2'b00: begin
                            byte_enable = 4'b0001;
                            write_data = {24'b0, store_data[7:0]};
                        end
                        2'b01: begin
                            byte_enable = 4'b0010;
                            write_data = {16'b0, store_data[7:0], 8'b0};
                        end
                        2'b10: begin
                            byte_enable = 4'b0100;
                            write_data = {8'b0, store_data[7:0], 16'b0};
                        end
                        2'b11: begin
                            byte_enable = 4'b1000;
                            write_data = {store_data[7:0], 24'b0};
                        end
                    endcase 
                end
                STORE_HALF: begin
                    case (address[1:0])
                        2'b00: begin
                            byte_enable = 4'b0011;
                            write_data = {16'b0, store_data[15:0]};
                        end
                        2'b10: begin
                            byte_enable = 4'b1100;
                            write_data = {store_data[15:0], 16'b0};
                        end
                        default: ;
                    endcase 
                end
                STORE_WORD: begin
                    if (address[1:0] == 2'b00) begin
                        byte_enable = 4'b1111;
                        write_data = store_data;
                    end
                end
            endcase
        end
    end

endmodule
