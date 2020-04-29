`include "uvm.sv"
interface itf;
bit			reset;
bit			clk;
bit			wr;
bit			sel;
bit [7:0]	addr;
wire[7:0]	data;

always #5 clk = !clk;
endinterface

module tb;
itf itf();

dut inst(.clk(itf.clk),
		 .reset(itf.reset),
		 .sel(itf.sel),
		 .wr(itf.wr),
		 .addr(itf.addr),
		 .data(itf.data)
);

initial begin
automatic uvm_coreservice_t cs_ = uvm_coreservice_t::get();
uvm_config_db#(virtual itf)::set(cs_.get_root(),"*","vif",itf);
end
initial begin
run_test();
end

endmodule
