transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/lab06_1 {E:/School/University of Illinois/ECE 385/ECE_385/lab06_1/slc3.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/lab06_1 {E:/School/University of Illinois/ECE 385/ECE_385/lab06_1/MemoryModules.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/lab06_1 {E:/School/University of Illinois/ECE 385/ECE_385/lab06_1/hexdriver.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/lab06_1 {E:/School/University of Illinois/ECE 385/ECE_385/lab06_1/Test_Bench.sv}

