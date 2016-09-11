transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/Lab04/SystemVerilog_L04 {E:/School/University of Illinois/ECE 385/Lab04/SystemVerilog_L04/full_adder.sv}
vlog -sv -work work +incdir+E:/School/University\ of\ Illinois/ECE\ 385/Lab04/SystemVerilog_L04 {E:/School/University of Illinois/ECE 385/Lab04/SystemVerilog_L04/adder2.sv}

