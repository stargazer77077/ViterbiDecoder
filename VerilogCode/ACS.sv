module ACS		                        // add-compare-select
(
   input       path_0_valid,
   input       path_1_valid,
   input [1:0] path_0_bmc,	         // branch metric computation
   input [1:0] path_1_bmc,				
   input [7:0] path_0_pmc,				// path metric computation
   input [7:0] path_1_pmc,

   output logic        selection,
   output logic        valid_o,
   output logic     [7:0] path_cost);  

   logic  [7:0] path_cost_0;			   // branch metric + path metric
   logic  [7:0] path_cost_1;

/* Fill in the guts per ACS instructions
*/
   always_comb begin
      // path cost(i) = path matric(i) + branch matric(i)
      path_cost_0 = path_0_bmc + path_0_pmc;
      path_cost_1 = path_1_bmc + path_1_pmc;

      // compare path costs and select the path with the lower cost
      if (path_0_valid && path_1_valid) begin
         if (path_cost_0 > path_cost_1) begin
            selection = 1;
            path_cost[7:0] = path_cost_1[7:0];
         end
         else begin
            selection = 0;
            path_cost[7:0] = path_cost_0[7:0];
         end
         valid_o = 1;
      end
      else if (path_0_valid && !path_1_valid) begin
         selection = 0;
         path_cost[7:0] = path_cost_0[7:0];
         valid_o = 1;
      end
      else if (path_1_valid && !path_0_valid) begin
         selection = 1;
         path_cost[7:0] = path_cost_1[7:0];
         valid_o = 1;
      end
      else begin
         // both paths are invalid
         selection = 0;
         path_cost = 0; 
         valid_o = 0;
      end
   end


endmodule
