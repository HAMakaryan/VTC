onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix binary -radixshowbase 0 /delay_control/x
add wave -noupdate -radix binary -radixshowbase 0 /delay_control/y
add wave -noupdate -radix binary -radixshowbase 0 /delay_control/z
add wave -noupdate -radix binary -radixshowbase 0 /delay_control/p
add wave -noupdate -radix binary -radixshowbase 0 /delay_control/q
add wave -noupdate -radix binary -radixshowbase 0 /delay_control/m
add wave -noupdate -radix binary -radixshowbase 0 /delay_control/temp_pq
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15186 ps} 0}
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
WaveRestoreZoom {0 ps} {157500 ps}
