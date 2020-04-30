class base_trans extends uvm_sequence_item;
rand bit[7:0] addr;
rand bit[7:0] data;
rand bit	  reset;
rand bit	  sel;
rand bit	  wr;
`uvm_object_utils_begin(base_trans)
`uvm_field_int(addr,UVM_ALL_ON)
`uvm_field_int(data,UVM_ALL_ON)
`uvm_field_int(reset,UVM_ALL_ON)
`uvm_field_int(sel,UVM_ALL_ON)
`uvm_field_int(wr,UVM_ALL_ON)
`uvm_object_utils_end
function new(string name="");
super.new(name);
endfunction
endclass

class test_seq extends uvm_sequence#(base_trans);
`uvm_object_utils(test_seq)
function new(string name="");
super.new(name);
set_automatic_phase_objection(1);
endfunction
task body();
`uvm_do_with(req,{req.sel==1;req.wr==1;req.addr==8'h23;req.data==8'h1;})
endtask
endclass

class test_seq_01 extends test_seq;
`uvm_object_utils(test_seq_01)
function new(string name="");
super.new(name);
endfunction
task body();
`uvm_do_with(req,{req.sel==1;req.wr==1;req.addr==8'h23;req.data==8'h2;})
endtask
endclass

class test_seq_02 extends test_seq;
`uvm_object_utils(test_seq_02)
function new(string name="");
super.new(name);
endfunction
task body();
`uvm_do_with(req,{req.sel==1;req.wr==1;req.addr==8'h23;req.data==8'h3;})
endtask
endclass
