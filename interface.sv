
interface OFDM_interface(input reg clk, input reg rst);
  //logic clk;
  //logic rst;
  logic stopout;
  logic pushin;
  logic [5:0] datain;
  logic firstin;
  logic stopin;
  logic pushout;
  logic [31:0] dataout;
  logic firstout;
  
endinterface : OFDM_interface 