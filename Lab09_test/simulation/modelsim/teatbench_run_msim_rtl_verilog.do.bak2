transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/Lab09_1 {E:/School/University of Illinois/ECE 385/ECE_385/Lab09_1/SubBytes.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/Lab09_1 {E:/School/University of Illinois/ECE 385/ECE_385/Lab09_1/InvShiftRows.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/Lab09_1 {E:/School/University of Illinois/ECE 385/ECE_385/Lab09_1/InvMixColumns.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/Lab09_1 {E:/School/University of Illinois/ECE 385/ECE_385/Lab09_1/InvAddRoundKey.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/Lab09_1 {E:/School/University of Illinois/ECE 385/ECE_385/Lab09_1/aes_controller.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/Lab09_1 {E:/School/University of Illinois/ECE 385/ECE_385/Lab09_1/KeyExpansion.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/Lab09_1 {E:/School/University of Illinois/ECE 385/ECE_385/Lab09_1/AES.sv}

vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/ECE_385/Lab09_test/../Lab09_1 {E:/School/University of Illinois/ECE 385/ECE_385/Lab09_test/../Lab09_1/TestBench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1000 ns
