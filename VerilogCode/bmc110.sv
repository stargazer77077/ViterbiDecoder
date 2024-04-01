module bmc110
(
   input    [1:0] rx_pair,
   output logic [1:0] path_0_bmc,
   output logic [1:0] path_1_bmc);
   
   logic tmp00;
   logic tmp01;
   logic tmp10;
   logic tmp11;

always_comb begin
   
   tmp00 = rx_pair[0];
   tmp01 = ~rx_pair[1];
   tmp10 = ~tmp00;
   tmp11 = ~tmp01;

   path_0_bmc[1] = tmp00 & tmp01;   
   path_0_bmc[0] = tmp00 ^ tmp01;

   path_1_bmc[1] = tmp10 & tmp11;  
   path_1_bmc[0] = tmp10 ^ tmp11;

end
endmodule
