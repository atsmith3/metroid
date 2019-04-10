transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit {/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit/Synchronizers.sv}
vlog -sv -work work +incdir+/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit {/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit/Router.sv}
vlog -sv -work work +incdir+/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit {/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit/HexDriver.sv}
vlog -sv -work work +incdir+/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit {/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit/Control.sv}
vlog -sv -work work +incdir+/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit {/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit/compute.sv}
vlog -sv -work work +incdir+/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit {/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit/Bit_Serial_Processor.sv}
vlog -sv -work work +incdir+/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit {/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit/Reg_8.sv}
vlog -sv -work work +incdir+/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit {/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit/Register_unit.sv}
vlog -sv -work work +incdir+/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit {/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit/Processor.sv}
vlog -sv -work work +incdir+/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit {/home/atsmith3/ece385/ECE_385/Lab04/8-bit_logic_processor/logic_processor_4bit/testbench_8.sv}

