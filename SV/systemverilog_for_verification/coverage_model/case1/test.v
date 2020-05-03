module top;
class a;
bit[7:0] bus;
covergroup g1;
value: coverpoint bus;
endgroup
function new();
g1 = new;
endfunction
endclass
 
a obj1,obj2;
initial begin
int i=0;
obj1 = new;
repeat(128) begin
	obj1.bus = i++;
	#1; 
	obj1.g1.sample();
end
obj2 = new;
repeat(128) begin
	obj2.bus = i++;
	#1; 
	obj2.g1.sample();
end

#100 $finish;
end
endmodule
