add wave -r /*
do user_radix.do
view wave -new -title TOP
add wave -position insertpoint sim:/i2c_master_top_tb/*
view wave -new -title TOP_I2C
add wave -position insertpoint sim:/i2c_master_top_tb/DUT/*
