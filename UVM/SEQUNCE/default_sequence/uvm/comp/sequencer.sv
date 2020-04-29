class my_sequencer extends uvm_sequencer#(base_trans);
`uvm_component_utils(my_sequencer)
function new(string name="",uvm_component parent=null);
	super.new(name,parent);
endfunction
endclass
