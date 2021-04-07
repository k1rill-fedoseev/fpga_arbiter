module linear_dynamic_priority_arbiter #(parameter N = 4) (
  input [N-1:0] req,
  input [$clog2(N)-1:0] prt [N-1:0],
  output [$clog2(N)-1:0] grant,
  output valid
);
  // best_prt[i] is the lowest priority among active requests in range req[0:i]
  wire [$clog2(N)-1:0] best_prt [0:N-1];
  // best_idx[i] is the index for lowest priority among active requests in range req[0:i]
  wire [$clog2(N)-1:0] best_idx [0:N-1];
  
  // trivial base cases
  assign best_prt[0] = req[0] ? prt[0] : N-1;
  assign best_idx[0] = 0;
  
  genvar i;
  generate
    for (i=1; i<N; i=i+1) begin: a
      wire is_better = req[i] && (prt[i] <= best_prt[i-1]);
      assign best_prt[i] = is_better ? prt[i] : best_prt[i-1];
      assign best_idx[i] = is_better ? i : best_idx[i-1];
    end
  endgenerate

  assign grant = best_idx[N-1];
  assign valid = req[grant];
endmodule
