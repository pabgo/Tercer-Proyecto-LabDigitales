vsim -gui -L unisim prueba4 unisim.glbl
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /prueba4/clk
add wave -noupdate /prueba4/datolisto
add wave -noupdate /prueba4/reset
add wave -noupdate /prueba4/uk
add wave -noupdate /prueba4/yk
add wave -noupdate /prueba4/salfk
add wave -noupdate /prueba4/salfk1
add wave -noupdate /prueba4/salfk2
add wave -noupdate /prueba4/salarit
add wave -noupdate /prueba4/resulisto
add wave -noupdate /prueba4/en1
add wave -noupdate /prueba4/en2
add wave -noupdate /prueba4/en3
add wave -noupdate /prueba4/en4
add wave -noupdate /prueba4/en5
add wave -noupdate /prueba4/en6
add wave -noupdate /prueba4/en7
add wave -noupdate /prueba4/datos_uk
add wave -noupdate /prueba4/i
add wave -noupdate /prueba4/salida
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {901888 ps}
run -all