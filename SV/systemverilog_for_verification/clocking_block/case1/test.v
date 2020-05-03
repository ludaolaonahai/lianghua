module clk_gen(output clk0);
bit clk;
always #5	clk		= ~ clk;
assign		clk0	= clk;
endmodule

module data_out(input clk,output reg[3:0] data);
always@(posedge clk) begin
	data = $random();
	$display("%t:data %d",$time,data);
end
endmodule

module top;
bit clk;
clk_gen gen(clk);
wire[3:0] data;
reg[3:0] dataout;
data_out dout(clk,data);
clocking sb @(posedge clk);
input #1step data;
output negedge dataout;
endclocking
reg[3:0] test;
initial begin
@sb;
$display("clocking block:%t,%d",$time,sb.data);
$display("normal module:%t,%d",$time,data);
@sb;
sb.dataout <= sb.data;
#100 $finish;
end

endmodule
