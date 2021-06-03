
class OFDM_sequencer extends uvm_sequencer #(OFDM_sequence_item);
  `uvm_component_utils(OFDM_sequencer)
  
  function new(string name = "OFDM_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new
  
endclass : OFDM_sequencer