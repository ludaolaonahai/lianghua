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

function void end_of_elaboration_phase(uvm_phase phase);
super.end_of_elaboration_phase(phase);
uvm_factory::get().print();
uvm_top.print_topology();
endfunction

task run_phase (uvm_phase phase);
test_seq seq;
phase.raise_objection(this);
seq = test_seq::type_id::create("seq",,get_full_name());
//seq = test_seq::type_id::create("seq");
seq.start(env.sequencer);
#20;
phase.drop_objection(this);
endtask

endclass
