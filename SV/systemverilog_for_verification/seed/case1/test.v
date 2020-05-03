module top;
class a;
rand int b;
function new();
endfunction
endclass
a obj;
initial begin
obj = new;
#1
obj.b = $urandom();
$display("urandom %d",obj.b);
#1
obj.b = $random();
$display("random %d",obj.b);
#1
obj.randomize();
$display("class randomize %d",obj.b);

end
endmodule
