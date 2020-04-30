class my_callback_base extends uvm_callback;

function new(string name="");
super.new(name);
endfunction

virtual function void pre_send(base_trans trans);
endfunction

virtual function void post_send(base_trans trans);
endfunction

endclass

class my_callback extends my_callback_base;
function new(string name="");
super.new(name);
endfunction

virtual function void pre_send(base_trans trans);
	$display("--------------pre_send--------------");
	trans.print();
endfunction

virtual function void post_send(base_trans trans);
	$display("--------------post_send--------------");
	trans.print();
endfunction

endclass

class my_driver extends uvm_driver#(base_trans);
`uvm_component_utils(my_driver)
`uvm_register_cb(my_driver,my_callback_base)
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
//real logic
seq_item_port.get_next_item(req);
`uvm_do_callbacks(my_driver,my_callback_base,pre_send(req));
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
`uvm_do_callbacks(my_driver,my_callback_base,post_send(rsp));
endtask

endclass

