transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/lab06_1 {E:/School/University of Illinois/ECE 385/ECE_385/lab06_1/HexDriver.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/lab06_2 {E:/School/University of Illinois/ECE 385/ECE_385/lab06_2/registerFIle.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/lab06_1 {E:/School/University of Illinois/ECE 385/ECE_385/lab06_1/tristate.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/lab06_1 {E:/School/University of Illinois/ECE 385/ECE_385/lab06_1/ISDU.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/lab06_1 {E:/School/University of Illinois/ECE 385/ECE_385/lab06_1/standard_modules.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/lab06_1 {E:/School/University of Illinois/ECE 385/ECE_385/lab06_1/MemoryModules.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/lab06_1 {E:/School/University of Illinois/ECE 385/ECE_385/lab06_1/Datapath.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/lab06_1 {E:/School/University of Illinois/ECE 385/ECE_385/lab06_1/slc3.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/lab06_1 {E:/School/University of Illinois/ECE 385/ECE_385/lab06_1/Test_Bench.sv}

