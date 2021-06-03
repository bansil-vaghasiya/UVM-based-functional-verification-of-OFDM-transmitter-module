
class OFDM_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(OFDM_scoreboard)
  
  logic signed [31:0] dataout_prd;
  logic  signed [15:0] data_I_prd;
  logic  signed [15:0] data_Q_prd;
  reg [1:0] data_in;
  
  function new(string name = "OFDM_scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new
  
  uvm_tlm_analysis_fifo #(OFDM_sequence_item) original;
  OFDM_sequence_item trx;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
  endfunction : build_phase
  
  virtual task run_phase();
    super.run_phase(phase);
    forever begin 
      original.get(trx);
      
      case({trx.firstin, trx.pushin})
        2'b11: data_in = datain[1:0];
        2'b01: data_in = datain[1:0];
        default: data_in = 0;
      endcase
      
      if(trx.pushout==1'b1) begin 
        data_Q_prd = (data_in[1])? 16'h2D40:-16'h2d40;
        data_I_prd = (data_in[0])? 16'h2D40:-16'h2d40;
        dataout_prd = {data_I_prd, data_Q_prd};
      end
      
      if(dataout_prd == trx.dataout) begin 
        `uvm_info(get_type_name(), "Test Passed", UVM_HIGH);
      end else begin 
        `uvm_info(get_type_name(), "Test Failed", UVM_HIGH);
      end
    end
  endtask : run_phase
  
endclass : OFDM_scoreboard