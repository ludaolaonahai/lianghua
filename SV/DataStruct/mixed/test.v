module top;
bit[7:0] d_dyn_arr[];
int d_queue[$] = {3,1,2};
bit d_ass_arr[string];
initial begin
d_ass_arr["a"] = 1;
d_ass_arr["c"] = 2;
d_ass_arr["b"] = 3;
end
initial begin
	d_dyn_arr = new[4];
	d_dyn_arr[0] = $random();
	d_dyn_arr[1] = $random();
	d_dyn_arr[2] = $random();
	d_dyn_arr[3] = $random();
end

initial begin
#1;
d_dyn_arr.sort();
d_queue.sort();
$display("-------");
$display(d_dyn_arr);
$display("-------");
$display(d_queue);
$display("-------");
$display(d_ass_arr);
#1 $finish;
end

endmodule
