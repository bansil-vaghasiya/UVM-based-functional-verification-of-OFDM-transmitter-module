
class OFDM_environment extends uvm_environment;
  `uvm_component_utils(OFDM_environment)
  
  function new(string name = "OFDM_environment", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new
  
  OFDM_scoreboard scbr;
  OFDM_agent agnt;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scbr = OFDM_scoreboard::type_id::create("scbr", this);
    agnt = OFDM_agent::type_id::create("agnt", this);
  endfunction : build_phase
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agnt.monr.monitor_analysis_port.connect(scbr.original.analysis_export);
  endfunction : connect_phase
  
endclass : OFDM_environment