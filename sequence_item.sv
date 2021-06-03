class OFDM_sequence_item extends uvm_sequence_item;
  `uvm_object_utils(OFDM_sequence_item)
  
  //logic clk;
  //logic rst;
  //logic stopout;
  //logic pushin;
  rand logic[5:0] datain;
  //logic firstin;
  
  //outputs
  logic stopin;
  logic pushout;
  logic[31:0] dataout;
  logic firstout;
  
  
  function new(string name = "OFDM_sequence_item", uvm_component parent = null);
    super.new(name, parent)
  endfunction : new
  

endclass : OFDM_sequence_item