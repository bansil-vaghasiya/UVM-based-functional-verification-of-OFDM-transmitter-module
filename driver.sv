
class OFDM_driver extends uvm_driver #(OFDM_sequence_item);
  `uvm_component_utils(OFDM_driver)
  
  function new(string name = "OFDM_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new
  
  virtual OFDM_inf v_if;
  OFDM_sequence_item trx;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual OFDM_inf)::get(this, "*", "v_if", v_if))
      begin
        `uvm_fatal(get_type_name(), "Virtual Interface not found")
      end
  endfunction : build_phase
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(uvm_phase phase);
    trx = OFDM_sequence_item::type_id::create("trx", this);
    forever begin
      OFDM_sequence_item_port.get_next_item(trx); //driver-sequencer communication mechanism, blocking get call
      @(posedge v_if.clk) begin
        if(v_if.stopin==1'b0) begin 
      		drive(trx);
        end
      end
      OFDM_sequence_item_port.item_done(trx); //item done method to indicate that the communication is completed
    end
  endtask : run_phase
  
  task drive(OFDM_sequence_item trx);
    v_if.pushin <= 1'b1;
    v_if.firstin <= 1'b1;
    v_if.datain <= trx.datain;
    v_if.stopout<=1'b1;
    @(posedge v_if.clk) begin 
      v_if.stop_out<=1'b0;
    end
  endtask : drive
  
  
endclass : OFDM_driver