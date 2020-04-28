class my_driver extends uvm_driver#(base_trans);
`uvm_component_utils(my_driver)
virtual itf vif; 
function new(string name="",uvm_component parent=null);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
if(!uvm_config_db#(virtual itf)::get(this,"","vif",vif)) 
	`uvm_fatal("my_driver","vif not set")
endfunction

task run_phase(uvm_phase phase);
seq_item_port.get_next_item(req);
$cast(rsp, req.clone());
rsp.set_id_info(req);
@(posedge vif.clk);
//vif.sel = seq.sel;
vif.wr  = req.wr;
vif.data = req.data;
vif.addr = req.addr;
@(posedge vif.clk);
vif.sel = 1'bz;
vif.wr  = 1'bz;
vif.data = 8'hz;
vif.addr = 8'hz; 
seq_item_port.item_done();
seq_item_port.put_response(rsp);
endtask

endclass

