
class OFDM_test extends uvm_test;
  `uvm_component_utils(OFDM_test)
  
  function new(string name = "OFDM_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new
  
  OFDM_environment envr;
  OFDM_sequence sqnc;
  virtual OFDM_inf v_if;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(OFDM_sequence_item)::get(this, "*", "v_if", v_if))
      begin
        `uvm_fatal(get_type_name(), "Virtual interface not found")
      end
    envr = OFDM_environment::type_id::create("envr", this); //type id create method
    sqnc = OFDM_sequence::type_id::create("sqnc", this);
    //sqnc = new("sqnc", this); new method
  endfunction : build_phase
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    sqnc.start(envr.agnt.seqr);
    phase.drop_objection(this);
  endtask : run_phase
  
endclass : OFDM_test