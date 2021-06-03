
class OFDM_monitor extends uvm_monitor;
  `uvm_component_utils(OFDM_monitor)
  
  function new(string name = "OFDM_monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new
  
  virtual OFDM_inf v_if;
  OFDM_sequence_item trx;
  uvm_analysis_port #(OFDM_sequence_item) monitor_analysis_port;//analysis port to broadcast the messages from the monitor
 
  
  function void build_phase(uvm_phase phase);
    super.new(phase);
    if(!uvm_config_db #(virtual OFDM_inf)::get(this, "*", "v_if", v_if)) 
      begin
        `uvm_fatal(get_type_name(), "Virtual Interface not found")
      end
    monitor_analysis_port = new("monitor_analysis_port", this);
  endfunction : build_phase
  
  virtual task run_phase(uvm_phase phase);
    super.new(phase);
    forever begin 
      @(posedge v_if.clk) begin 
        read_input(trx);
        if(v_if.stop_out==1'b0) begin 
          read_output(trx);
        end
        monitor_analysis_port.write(trx);
      end
    end
  endtask : run_phase
  
  virtual task read_input(OFDM_sequence_item trx);
    trx.datain <= v_if.data_in;
  endtask : read_input
  
  virtual task read_output(OFDM_sequence_item trx);
    trx.stopin <= v_if.stopin;
    trx.pushout <= v_if.pushout;
    trx.dataout <= dataout;
    trx.firstout <= firstout;
  endtask : read_output
  
  
  
endclass : OFDM_monitor