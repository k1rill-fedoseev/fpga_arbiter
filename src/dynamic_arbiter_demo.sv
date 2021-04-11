module dynamic_arbiter_demo(rst, clk, switches, led, led_ptr);
	input clk;
	input rst;
	input [7:0] switches;
	output [7:0] led_ptr;
	output [7:0] led;
	
	wire [3:0] digits [7:0] = '{7, 5, 4, 5, 5, 2, 0, 2};
	
	wire [7:0] sw;
	
	sync_and_debounce #(8, 8) debounce(
		.clk(clk),
		.reset(~rst),
		.sw_in(~switches),
		.sw_out(sw)
	);
	wire [7:0] dots = 8'b00000001 << grant;
	
	display d(
		.rst(~rst),
		.clk(clk),
		.vld(sw),
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
		.req(sw),
		.prt(digits),
		.valid(valid),
		.grant(grant)
	);
endmodule


