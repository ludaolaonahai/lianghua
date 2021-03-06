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
uvm_analysis_port#(packet) broadcast_port;
function new(string name="",uvm_component parent=null);
super.new(name,parent);
broadcast_port = new("broadcast_port",this);
endfunction

task send();
	repeat(5) begin
		packet tmp = new;
		tmp.randomize();
		tmp.display();
		broadcast_port.write(tmp);
	end
endtask

endclass

class dest extends uvm_component;
uvm_analysis_imp#(packet,dest) recv_port;
function new(string name="",uvm_component parent=null);
super.new(name,parent);
recv_port = new("recv_port",this);
endfunction
packet data [$];
function void write (packet item);
	packet ele = new;
	ele.copy(item);
	data.push_back(ele);
endfunction
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
src_inst.broadcast_port.connect(dest_inst.recv_port);
endfunction

task run_phase (uvm_phase phase);
super.run_phase(phase);
phase.raise_objection(this);
src_inst.send();
#10;
foreach(dest_inst.data[i]) begin
	$display("%d,%d",dest_inst.data[i].a,dest_inst.data[i].b);
end
phase.drop_objection(this);
endtask

endclass
initial begin
run_test("test");
end

endmodule
