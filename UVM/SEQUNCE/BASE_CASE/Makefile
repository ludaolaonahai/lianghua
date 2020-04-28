clean:
	rm -rf csrc simv.daidir novas.conf novas.rc simv vc_hdrs.h comp.log
compile:
	vcs -full64 -sverilog -f run.f -ntb_opts uvm-1.2 -l comp.log -q -debug_access+all -lca 
sim:
	./simv +UVM_TESTNAME=my_test -l sim.log -ucli -i dump.do
