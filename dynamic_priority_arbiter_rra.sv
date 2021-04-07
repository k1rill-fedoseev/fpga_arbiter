module dynamic_priority_arbiter_rra #(parameter N = 4, parameter LN = $clog2(N)) (
  input clk,
  input clk_en,
  input rst,
  input [N-1:0] req,
  input [LN-1:0] prt [N-1:0],
  output [LN-1:0] grant,
  output valid
);
  wire [LN-1:0] min [N-1:0];
  
  assign min[0] = req[0] ? prt[0] : N - 1;
  genvar i;
  generate
    for (i=1; i<N; i=i+1) begin: a
	  assign min[i] = (req[i] && prt[i] <= min[i - 1]) ? prt[i] : min[i - 1];
    end
  endgenerate
  
  wire [N-1:0] req2;
  genvar j;
  generate
    for (j=0; j<N; j=j+1) begin: b
      assign req2[j] = req[j] & (prt[j] == min[N-1]);
    end
  endgenerate
  
  rra #(N) RRA(
    .clk(clk),
	 .clk_en(clk_en),
	 .rst(rst),
    .req(req2),
    .grant(grant),
    .valid(valid)
  );
  
endmodule
