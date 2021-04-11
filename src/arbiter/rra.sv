module rra #(parameter N=4, parameter LN=$clog2(N)) (
  input clk,
  input clk_en,
  input rst,
  input [N-1:0] req,
  output [LN-1:0] grant,
  output valid
);
  reg [LN-1:0] pointer_reg;
  reg [LN-1:0] grant_reg;
  
  assign grant = grant_reg;
  assign valid = |req[N-1:0];
  
  always @(posedge clk) begin
    if (rst) begin
	   pointer_reg <= 0;
		grant_reg <= 0;
	 end
	 else
		if (clk_en) begin
		  pointer_reg <= grant_reg + 1;
    case (pointer_reg)
      0:
        if      (req[0])  grant_reg = 0;
        else if (req[1])  grant_reg = 1;
        else if (req[2])  grant_reg = 2;
        else if (req[3])  grant_reg = 3;
        else if (req[4])  grant_reg = 4;
        else if (req[5])  grant_reg = 5;
        else if (req[6])  grant_reg = 6;
        else if (req[7])  grant_reg = 7;
      1:
        if      (req[1])  grant_reg = 1;
        else if (req[2])  grant_reg = 2;
        else if (req[3])  grant_reg = 3;
        else if (req[4])  grant_reg = 4;
        else if (req[5])  grant_reg = 5;
        else if (req[6])  grant_reg = 6;
        else if (req[7])  grant_reg = 7;
        else if (req[0])  grant_reg = 0;
      2:
        if      (req[2])  grant_reg = 2;
        else if (req[3])  grant_reg = 3;
        else if (req[4])  grant_reg = 4;
        else if (req[5])  grant_reg = 5;
        else if (req[6])  grant_reg = 6;
        else if (req[7])  grant_reg = 7;
        else if (req[0])  grant_reg = 0;
        else if (req[1])  grant_reg = 1;
      3:
        if      (req[3])  grant_reg = 3;
        else if (req[4])  grant_reg = 4;
        else if (req[5])  grant_reg = 5;
        else if (req[6])  grant_reg = 6;
        else if (req[7])  grant_reg = 7;
        else if (req[0])  grant_reg = 0;
        else if (req[1])  grant_reg = 1;
        else if (req[2])  grant_reg = 2;
		4:
        if      (req[4])  grant_reg = 4;
        else if (req[5])  grant_reg = 5;
        else if (req[6])  grant_reg = 6;
        else if (req[7])  grant_reg = 7;
        else if (req[0])  grant_reg = 0;
        else if (req[1])  grant_reg = 1;
        else if (req[2])  grant_reg = 2;
        else if (req[3])  grant_reg = 3;
		5:
        if      (req[5])  grant_reg = 5;
        else if (req[6])  grant_reg = 6;
        else if (req[7])  grant_reg = 7;
        else if (req[0])  grant_reg = 0;
        else if (req[1])  grant_reg = 1;
        else if (req[2])  grant_reg = 2;
        else if (req[3])  grant_reg = 3;
        else if (req[4])  grant_reg = 4;
		6:
        if      (req[6])  grant_reg = 6;
        else if (req[7])  grant_reg = 7;
        else if (req[0])  grant_reg = 0;
        else if (req[1])  grant_reg = 1;
        else if (req[2])  grant_reg = 2;
        else if (req[3])  grant_reg = 3;
        else if (req[4])  grant_reg = 4;
        else if (req[5])  grant_reg = 5;
		7:
        if      (req[7])  grant_reg = 7;
        else if (req[0])  grant_reg = 0;
        else if (req[1])  grant_reg = 1;
        else if (req[2])  grant_reg = 2;
        else if (req[3])  grant_reg = 3;
        else if (req[4])  grant_reg = 4;
        else if (req[5])  grant_reg = 5;
        else if (req[6])  grant_reg = 6;
    endcase
	 end
	 end
endmodule
