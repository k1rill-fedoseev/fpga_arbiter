module display(rst, clk, vld, digits, dots, led_ptr_out, led_out);
	localparam D_0 = 7'b0111111;
	localparam D_1 = 7'b0000110;
	localparam D_2 = 7'b1011011;
	localparam D_3 = 7'b1001111;
	localparam D_4 = 7'b1100110;
	localparam D_5 = 7'b1101101;
	localparam D_6 = 7'b1111101;
	localparam D_7 = 7'b0000111;
	localparam D_8 = 7'b1111111;
	localparam D_9 = 7'b1101111;
	localparam D_E = 7'b1111001;
	localparam D_EMPTY = 7'b0000000;

	input clk;
	input rst;
	input [7:0] vld;
	input [3:0] digits [7:0];
	input [7:0] dots;
	output [7:0] led_ptr_out;
	output [7:0] led_out;
	
	reg [15:0] counter;
	reg [6:0] led;
	
	wire [2:0] led_ptr = counter[15:13];
	
	always @(posedge clk)
	   if (rst)
			counter <= 0;
		else
			counter <= counter + 1;
			
	wire valid = vld[led_ptr];
	wire dot = valid & dots[led_ptr];

	always @(posedge clk)
		if (valid)
			case (digits[led_ptr])
				0: led <= D_0;
				1: led <= D_1;
				2: led <= D_2;
				3: led <= D_3;
				4: led <= D_4;
				5: led <= D_5;
				6: led <= D_6;
				7: led <= D_7;
				8: led <= D_8;
				9: led <= D_9;
				default: led <= D_E;
			endcase
		else
			led <= D_EMPTY;
	
	assign led_out = ~{dot, led};
	assign led_ptr_out = ~(8'b00000001 << led_ptr);
endmodule