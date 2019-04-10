transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/Lab04/adders {E:/School/University of Illinois/ECE 385/ECE_385/Lab04/adders/ripple_adder.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/Lab04/adders {E:/School/University of Illinois/ECE 385/ECE_385/Lab04/adders/HexDriver.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/Lab04/adders {E:/School/University of Illinois/ECE 385/ECE_385/Lab04/adders/carry_select_adder.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/Lab04/adders {E:/School/University of Illinois/ECE 385/ECE_385/Lab04/adders/standard_modules.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/Lab04/adders {E:/School/University of Illinois/ECE 385/ECE_385/Lab04/adders/adder_modules.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/Lab04/adders {E:/School/University of Illinois/ECE 385/ECE_385/Lab04/adders/testbench_8.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/Lab04/adders {E:/School/University of Illinois/ECE 385/ECE_385/Lab04/adders/lab4_adders_toplevel.sv}

