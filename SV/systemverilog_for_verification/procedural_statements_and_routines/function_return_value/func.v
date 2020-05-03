module top;
function int myfunc_a ();
endfunction
function int myfunc_b ();
int a;
myfunc_c();
endfunction
function int myfunc_c ();
myfunc_c = 1;
return 2;
endfunction
int a,b,c,d;
initial begin
a = myfunc_a();
$display("no return no statement %d",a);
b = myfunc_b();
$display("no return has statement %d",b);
c = myfunc_c();
$display("write function %d",c);
end

endmodule
