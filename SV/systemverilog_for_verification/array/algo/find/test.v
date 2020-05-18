module top;
int data [$];
task q_init(ref int data[$]);
	for(int i=0;i<20;i++) begin
		data.push_front($urandom_range(10,1));
	end
	foreach(data[i]) begin
		$display("%d,%d",i,data[i]);
	end
	$display("queque size is %d",data.size());
endtask

task q_find(ref int data[$],input int value);
	int res [$];
	int res_index [$];
	int fdata [$];
	typedef int q_t [$];
	q_t max,min,u;
	res = data.find() with (item%value == 0);
	res_index = data.find_index() with (item%value == 0);
	foreach(res_index[i])begin
		$display("index:%d",res_index[i]);
	end
	fdata = data.find_first with (item > value);
	$display("data:%d",fdata[0]);
	fdata = data.find_first_index with (item > value);
	$display("data:%d",fdata[0]);
	max = data.max() with (item%2 == 0);
	$display("size %d",max.size());
	u = data.unique() with (item%9 == 0);
	$display("size %d",u.size());
	data.sort();
	foreach(data[i]) begin
		$display("data is %d",data[i]);
	end
endtask

int value=6;
initial begin
q_init(data);
q_find(data,value);
end
endmodule
