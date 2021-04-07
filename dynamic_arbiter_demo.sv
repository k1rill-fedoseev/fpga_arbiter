module dynamic_arbiter_demo(rst, clk, switches, led, led_ptr);
	input clk;
	input rst;
	input [7:0] switches;
	output [7:0] led_ptr;
	output [7:0] led;
	
	wire [3:0] digits [7:0] = '{7, 5, 4, 5, 5, 2, 0, 2};
	
	wire [7:0] vld = ~switches;
	wire [7:0] dots = 8'b00000001 << grant;
	
	display d(
		.rst(~rst),
		.clk(clk),
		.vld(vld),
		.dots(dots),
		.digits(digits),
		.led_ptr_out(led_ptr),
		.led_out(led)
	);
	
	wire valid;
	wire [2:0] grant;
	
	slow_arbiter #(8) sa(
		.clk(clk),
		.rst(~rst),
		.req(~switches),
		.prt(digits),
		.valid(valid),
		.grant(grant),
	);
endmodule


