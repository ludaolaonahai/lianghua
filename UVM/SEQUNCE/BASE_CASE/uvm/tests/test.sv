class my_test extends uvm_test;
`uvm_component_utils(my_test)
my_env env;
function new(string name="",uvm_component parent=null);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
env = my_env::type_id::create("env",this);
endfunction

task run_phase (uvm_phase phase);
test_seq seq;
phase.raise_objection(this);
seq = new("");
seq.start(env.sequencer,null);
#20;
phase.drop_objection(this);
endtask

endclass
