clean:
	rm -rf csrc simv.daidir vdCovLog ucli.key simv coverage DVEfiles simv.vdb urgReport cm.log 
comp:
	vcs -full64 -sverilog test.v -cm assert+branch+line+fsm+cond+tgl
sim:
	./simv -cm assert+branch+line+fsm+cond+tgl
cov:
	urg -dir simv.vdb -full64
check:
	firefox urgReport
run:comp sim cov check
