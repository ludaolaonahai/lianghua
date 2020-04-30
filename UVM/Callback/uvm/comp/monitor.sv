class my_monitor extends uvm_monitor;
`uvm_component_utils(my_monitor)
function new(string name="",uvm_component parent=null);
	super.new(name,parent);
endfunction
endclass
