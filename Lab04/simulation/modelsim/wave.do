onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix symbolic /adder2/c_in
add wave -noupdate /adder2/A
add wave -noupdate /adder2/B
add wave -noupdate -expand /adder2/S
add wave -noupdate /adder2/c_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {305837 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1050 ns}
