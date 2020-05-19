module top;
import uvm_pkg::*;

class packet extends uvm_object;
rand int a;
rand int b;
function new(string name="");
	super.new(name);
endfunction

function void copy(packet rhs);
this.a = rhs.a;
this.b = rhs.b;
endfunction

function void display();
$display("a=%d;b=%d",a,b);
endfunction
endclass

class src extends uvm_component;
uvm_blocking_transport_port#(packet,packet) get_port;
function new(string name="",uvm_component parent=null);
super.new(name,parent);
get_port = new("put_port",this);
endfunction

task send();
	repeat(5) begin
		packet tmpo;
		packet tmpi;
		tmpi = new ();
		tmpi.randomize();
		tmpi.display();
		get_port.transport(tmpi,tmpo);
		tmpo.display();
	end
endtask

endclass

class dest extends uvm_component;
uvm_blocking_transport_imp#(packet,packet,dest) get_imp_port;
function new(string name="",uvm_component parent=null);
super.new(name,parent);
get_imp_port = new("imp_port",this);
endfunction
packet data [$];

task transport (input packet itemi,output packet itemo);
	packet ele = new;
	ele.copy(itemi);
	itemo = ele;
	ele = null;
endtask 

endclass

class test extends uvm_test;
`uvm_component_utils(test)
src		src_inst;
dest	dest_inst;

function new(string name="",uvm_component parent=null);
super.new(name,parent);
src_inst = new("src");
dest_inst = new("dest");
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
src_inst.get_port.connect(dest_inst.get_imp_port);
endfunction

task run_phase (uvm_phase phase);
super.run_phase(phase);
phase.raise_objection(this);
src_inst.send();
#10;
phase.drop_objection(this);
endtask

endclass
initial begin
run_test("test");
end

endmodule
