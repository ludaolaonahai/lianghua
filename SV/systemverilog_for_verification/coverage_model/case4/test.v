module top;
class a;
bit[7:0] bus;
bit rst;

covergroup g1;
option.auto_bin_max = 4;

value: 
coverpoint bus iff (!rst) { 
	bins dvalue[] =  { [0:23] }; 
	bins cvalue   =  { 128 };
}
endgroup

function new();
g1 = new;
endfunction

endclass
 
a obj1,obj2;
initial begin
int i=0;
obj1 = new;
repeat(1) begin
	obj1.bus = i;
	#1; 
	obj1.g1.sample();
end
obj2 = new;
obj2.rst = 1;
repeat(1) begin
	obj2.bus = i+128;
	#1; 
	obj2.g1.sample();
end

#100 $finish;
end
endmodule
