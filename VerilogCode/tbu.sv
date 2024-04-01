module tbu
(
   input       clk,
   input       rst,
   input       enable,
   input       selection,
   input [7:0] d_in_0,
   input [7:0] d_in_1,
   output logic  d_o,
   output logic  wr_en);

   logic         d_o_reg;
   logic         wr_en_reg;
   
   logic   [2:0] pstate;
   logic   [2:0] nstate;

   logic         selection_buf;

   always @(posedge clk)    begin
      selection_buf  <= selection;
      wr_en          <= wr_en_reg;
      d_o            <= d_o_reg;
   end
   always @(posedge clk, negedge rst) begin
      if(!rst)
         pstate   <= 3'b000;
      else if(!enable)
         pstate   <= 3'b000;
      else if(selection_buf && !selection)
         pstate   <= 3'b000;
      else
         pstate   <= nstate;
   end

   always_comb begin
      wr_en_reg = selection;
      if(selection) begin
         d_o_reg = d_in_1[pstate];
      end
      else begin
         d_o_reg = 0;
      end

   end

   always_comb begin
      if(selection) begin
         nstate[2:1] = pstate[1:0];
         nstate[0]  = (d_in_1[pstate]^pstate[2])^pstate[0];
      end
      else begin
         nstate[2:1] = pstate[1:0];
         nstate[0]  = (d_in_0[pstate]^pstate[2])^pstate[0];

      end
      
   end
/*  combinational logic drives:
wr_en_reg, d_o_reg, nstate (next state)
from selection, d_in_1[pstate], d_in_0[pstate]
See assignment text for details
*/

endmodule
