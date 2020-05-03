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
//test sequence method
base_trans trans01,trans02;
uvm_object trans03;
bit content[];
//meathod
trans01 = base_trans::type_id::create("trans01");
trans02 = base_trans::type_id::create("trans02");
trans02.copy(trans01);

$display("---copy meathod---");
$display(trans02.get_type_name());
$display(trans02.get_name());
if(trans02.compare(trans01)) 
	$display("match");
else
	$display("mismatch");
trans03 = trans01.clone();
$cast(trans02,trans03);
$display("---clone meathod---");
$display(trans02.get_type_name());
$display(trans02.get_name());
if(trans02.compare(trans01)) 
	$display("match");
else
	$display("mismatch");
trans02.sel = 1;
if(trans02.compare(trans01)) 
	$display("match");
else
	$display("mismatch");
trans02.pack(content);
$display(content);
content[0] = 1;
trans02.unpack(content);
trans02.print();

//real logic
seq_item_port.get_next_item(req);
req.print();
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

