transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/altera/15.0/zhijiej2/lab4/download\ files/processor2 {C:/altera/15.0/zhijiej2/lab4/download files/processor2/Synchronizers.sv}
vlog -sv -work work +incdir+C:/altera/15.0/zhijiej2/lab4/download\ files/processor2 {C:/altera/15.0/zhijiej2/lab4/download files/processor2/Router.sv}
vlog -sv -work work +incdir+C:/altera/15.0/zhijiej2/lab4/download\ files/processor2 {C:/altera/15.0/zhijiej2/lab4/download files/processor2/Reg_4.sv}
vlog -sv -work work +incdir+C:/altera/15.0/zhijiej2/lab4/download\ files/processor2 {C:/altera/15.0/zhijiej2/lab4/download files/processor2/HexDriver.sv}
vlog -sv -work work +incdir+C:/altera/15.0/zhijiej2/lab4/download\ files/processor2 {C:/altera/15.0/zhijiej2/lab4/download files/processor2/Control.sv}
vlog -sv -work work +incdir+C:/altera/15.0/zhijiej2/lab4/download\ files/processor2 {C:/altera/15.0/zhijiej2/lab4/download files/processor2/compute.sv}
vlog -sv -work work +incdir+C:/altera/15.0/zhijiej2/lab4/download\ files/processor2 {C:/altera/15.0/zhijiej2/lab4/download files/processor2/Register_unit.sv}
vlog -sv -work work +incdir+C:/altera/15.0/zhijiej2/lab4/download\ files/processor2 {C:/altera/15.0/zhijiej2/lab4/download files/processor2/Processor.sv}

vlog -sv -work work +incdir+C:/altera/15.0/zhijiej2/lab4/download\ files/processor2 {C:/altera/15.0/zhijiej2/lab4/download files/processor2/testbench_8.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run 1000 ns
