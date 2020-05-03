compile:
	vcs -full64 -sverilog test.v
sim_seed_1:
	./simv +ntb_random_seed=5
sim_seed_2:
	./simv +ntb_random_seed=50
run: clean compile sim_seed_1 sim_seed_2
	@echo "run"
clean:
	rm -rf csrc simv.daidir simv ucli.key
