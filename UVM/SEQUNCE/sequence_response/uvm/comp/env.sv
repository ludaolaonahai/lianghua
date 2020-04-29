class my_env extends uvm_env;
`uvm_component_utils(my_env)
my_driver driver;
my_monitor monitor;
my_sequencer sequencer;

function new(string name="",uvm_component parent=null);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
driver		= my_driver::type_id::create("driver",this);
monitor		= my_monitor::type_id::create("monitor",this);
sequencer	= my_sequencer::type_id::create("sequencer",this);
endfunction

function void connect_phase(uvm_phase phase);
driver.seq_item_port.connect(sequencer.seq_item_export);
endfunction

endclass
