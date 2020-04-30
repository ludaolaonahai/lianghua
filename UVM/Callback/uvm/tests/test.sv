class my_test extends uvm_test;
`uvm_component_utils(my_test)
my_env env;
function new(string name="",uvm_component parent=null);
	super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
env = my_env::type_id::create("env",this);
uvm_config_db#(uvm_object_wrapper)::set(this,"env.sequencer.main_phase","default_sequence",test_seq::get_type());
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
super.end_of_elaboration_phase(phase);
uvm_factory::get().print();
uvm_top.print_topology();
endfunction


endclass

class my_test_derive extends my_test;
`uvm_component_utils(my_test_derive)
my_callback inst_callback;
function new(string name="",uvm_component parent=null);
	super.new(name,parent);
endfunction



function void build_phase(uvm_phase phase);
super.build_phase(phase);
uvm_config_db#(uvm_object_wrapper)::set(this,"env.sequencer.main_phase","default_sequence",test_seq_02::get_type());
endfunction

function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
inst_callback = new("drv_callback");
uvm_callbacks#(my_driver,my_callback_base)::add(env.driver,inst_callback);
uvm_callbacks#(my_driver,my_callback_base)::display();
endfunction

endclass
