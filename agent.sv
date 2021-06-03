
class OFDM_agent extends uvm_agent;
  `uvm_component_utils(OFDM_agent)
  
  function new(string name = "OFDM_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new
  
  OFDM_sequencer seqr;
  OFDM_driver drvr;
  OFDM_monitor monr;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    seqr = OFDM_sequencer::type_id::create("seqr", this);
    drvr = OFDM_driver::type_id::create("drvr", this);
    monr = OFDM_monitor::type_id::create("monr", this);
  endfunction : new
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drvr.seq_item_port.connect(seqr.seq_item_export);
  endfunction : connect_phase
  
endclass : OFDM_agent