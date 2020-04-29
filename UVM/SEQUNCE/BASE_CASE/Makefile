clean:
	rm -rf csrc simv.daidir novas.conf novas.rc simv vc_hdrs.h comp.log inter.vpd novas.fsdb ucli.key vc_hdrs.h sim.log DVEfiles nWaveLog novas_dump.log tr_db.log 
compile:
	vcs -full64 -sverilog -f run.f -ntb_opts uvm-1.2 -l comp.log -q -debug_access+all -lca 
sim:
	./simv +UVM_TESTNAME=my_test -l sim.log -ucli -i dump.do

sim_01:
	./simv +UVM_TESTNAME=my_test -l sim.log -ucli -i dump.do +uvm_set_type_override=test_seq,test_seq_01

sim_02:
	./simv +UVM_TESTNAME=my_test -l sim.log -ucli -i dump.do +uvm_set_inst_override=test_seq,test_seq_02,uvm_test_top.seq
	
