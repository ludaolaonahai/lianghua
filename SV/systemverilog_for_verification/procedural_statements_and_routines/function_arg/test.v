module top;
function int myfunc (ref int a);
a = 1;
endfunction
int a;
initial begin
myfunc(a);
$display("%d",a);
end
endmodule
