onerror {resume}
radix define SIG_CTRL_FSM {
    "3'b000" "s0" -color "#FFC0CB",
    "3'b001" "s1" -color "#FFC0CB",
    "3'b010" "s2" -color "#FFC0CB",
    "3'b011" "s3" -color "#FFC0CB",
    "3'b100" "s4" -color "#FFC0CB",
    "3'b101" "s1prs" -color "#FFC0CB",
    "3'b110" "s2prs" -color "#FFC0CB",
    "3'b111" "s4prs" -color "#FFC0CB",
    -default hexadecimal
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sig_control_tb/DUT/hwy
add wave -noupdate /sig_control_tb/DUT/cntry
add wave -noupdate /sig_control_tb/DUT/X
add wave -noupdate /sig_control_tb/DUT/clock
add wave -noupdate -color {Spring Green} -itemcolor White -radix SIG_CTRL_FSM /sig_control_tb/DUT/state_next
add wave -noupdate -radix SIG_CTRL_FSM /sig_control_tb/DUT/state_current
add wave -noupdate -radix unsigned /sig_control_tb/DUT/counter
add wave -noupdate /sig_control_tb/DUT/time_over
add wave -noupdate /sig_control_tb/DUT/clear
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {305015000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {5145 us}
