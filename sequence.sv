
class OFDM_sequence extends uvm_sequence #(OFDM_sequence_item);
  `uvm_object_utils(OFDM_sequence)
  
   function new(string name = "OFDM_sequence", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new
  
  OFDM_sequence_item trx;
  
  virtual task body();
    trx = new();
    repeat(2) begin
    start_item(trx);
      trx.randomize() with {trx.datain == 25;};
    finish_item(trx);
    end
    
  endtask : body
  
endclass : OFDM_sequence