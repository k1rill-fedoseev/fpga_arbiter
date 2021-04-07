module slow_arbiter #(parameter N = 4, parameter LN = $clog2(N)) (
  input clk,
  input rst,
  input [N-1:0] req,
  input [LN-1:0] prt [N-1:0],
  output [LN-1:0] grant,
  output valid
);
  reg [23:0] counter;
  
  always @(posedge clk)
    if (rst)
	   counter <= 0;
	 else
	   counter <= counter + 1;
		

  wire clk_en = &counter;
  
  dynamic_priority_arbiter_rra #(N) dpar(
    .clk(clk),
    .clk_en(clk_en),
    .rst(rst),
    .req(req),
    .prt(prt),
    .grant(grant),
    .valid(valid)
  );
endmodule
