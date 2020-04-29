module dut(
	input		clk,
	input		reset,
	input		sel,
	input		wr,
	input[7:0]	addr,
	inout[7:0]	data
);


reg [7:0] status_reg;

always@(posedge clk or negedge reset) begin
	if(!reset)
		status_reg <= 8'b00000001;
	else 
		if (sel == 1'b1  && addr == 8'h23 && wr == 1'b1)
			status_reg <= data; 
		else
			status_reg <= status_reg;
end

reg[7:0] data_tmp = 8'hz;
always@(sel or wr or status_reg) begin
	if (sel == 1'b1 && addr==8'h23 && wr == 1'b0)
		data_tmp = status_reg;
	else
		data_tmp = data_tmp;
end

assign data = wr ? data : data_tmp;


endmodule
