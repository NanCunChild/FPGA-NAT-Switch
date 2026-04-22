# 主时钟约束：100 MHz，周期 10 ns，占空比 50%
#create_clock -period 10.000 -name clk -waveform {0.000 5.000} [get_ports clk]

# 千兆尝试，计划先尝试100MHz之后总结
#create_clock -period 8.000 -name clk -waveform {0.000 4.000} [get_ports clk]

#####################################################################

##system_clk
set_property PACKAGE_PIN H19 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_SSTL12 [get_ports sys_clk_p]

##MASTER_SLAVE 10GMAC
##set_property PACKAGE_PIN H19 [get_ports USER_CLOCK_P_10MAC]
##set_property IOSTANDARD DIFF_SSTL12 [get_ports USER_CLOCK_P_10MAC]
##create_clock -period 3.333 [get_ports USER_CLOCK_P_10MAC]

set_property PACKAGE_PIN AE36 [get_ports gt_refclk_p]
##set_property PACKAGE_PIN AE36 [get_ports gt_ref_clk_p_10MAC_2]

##40GMAC_0

##set_property PACKAGE_PIN H19 [get_ports sys_clk_p_40MAC_0]
##set_property IOSTANDARD DIFF_SSTL12 [get_ports sys_clk_p_40MAC_0]

##set_property PACKAGE_PIN H11 [get_ports gt_ref_clk_p_40MAC_1]
##set_property PACKAGE_PIN T11 [get_ports gt_ref_clk_p_40MAC_0]
##set_property PACKAGE_PIN D11 [get_ports gt_ref_clk_p_40MAC_3]
##40GMAC_1

##set_property PACKAGE_PIN H19 [get_ports sys_clk_p_40MAC_1]
##set_property PACKAGE_PIN H18 [get_ports sys_clk_n_40MAC_1]
##set_property IOSTANDARD DIFF_SSTL12 [get_ports sys_clk_p_40MAC_1]
##set_property IOSTANDARD DIFF_SSTL12 [get_ports sys_clk_n_40MAC_1]

##set_property PACKAGE_PIN Y10 [get_ports gt_ref_clk_n_40MAC_1]
##create_clock -period 3.200 [get_ports gt_ref_clk_n_40MAC_1]


##************************************************************
##MASTER_SLAVE 10GMAC
##set_false_path -from [get_pins U_vio_0/probe_out0] -to all_registers

##  -group [get_clocks -include_generated_clocks -of_objects [get_pins inst_clk_gen/clk_out1]] ##  -group [get_clocks -include_generated_clocks -of_objects [get_pins inst_clk_gen/clk_out2]] ##  -group [get_clocks -include_generated_clocks -of_objects [get_pins inst_clk_gen/clk_out3_125] ##  -group [get_clocks -include_generated_clocks -of_objects [get_pins inst_clk_gen/clk_out4_125v]]

#set_clock_groups -asynchronous -group [get_clocks init_clk] -group [get_clocks pkt_clk] -group [get_clocks -include_generated_clocks gt_ref_clk_p_10MAC] -group [get_clocks -include_generated_clocks gt_ref_clk_p_40MAC]
#set_clock_groups -asynchronous -group [get_clocks sys_clk_p] -group [get_clocks -include_generated_clocks gt_ref_clk_p_40MAC_0] -group [get_clocks *clk_out1*] -group [get_clocks *clk_out2*]

##set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] 3.200
##set_max_delay -datapath_only -from [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/TXOUTCLK}]] -to [get_clocks -of_objects [get_pins -hierarchical -filter {NAME =~ */channel_inst/*_CHANNEL_PRIM_INST/RXOUTCLK}]] 3.200


##************************************************************

##MASTER_SLAVE 10GMAC
set_property PACKAGE_PIN AE45 [get_ports gt_rxp_in_0]
set_property PACKAGE_PIN AE46 [get_ports gt_rxn_in_0]
set_property PACKAGE_PIN AE40 [get_ports gt_txp_out_0]
set_property PACKAGE_PIN AE41 [get_ports gt_txn_out_0]

set_property PACKAGE_PIN AD43 [get_ports gt_rxp_in_1]
set_property PACKAGE_PIN AD44 [get_ports gt_rxn_in_1]
set_property PACKAGE_PIN AD38 [get_ports gt_txp_out_1]
set_property PACKAGE_PIN AD39 [get_ports gt_txn_out_1]

set_property PACKAGE_PIN AC45 [get_ports gt_rxp_in_2]
set_property PACKAGE_PIN AC46 [get_ports gt_rxn_in_2]
set_property PACKAGE_PIN AC40 [get_ports gt_txp_out_2]
set_property PACKAGE_PIN AC41 [get_ports gt_txn_out_2]

set_property PACKAGE_PIN AB43 [get_ports gt_rxp_in_3]
set_property PACKAGE_PIN AB44 [get_ports gt_rxn_in_3]
set_property PACKAGE_PIN AB38 [get_ports gt_txp_out_3]
set_property PACKAGE_PIN AB39 [get_ports gt_txn_out_3]
##set_property PACKAGE_PIN AB43 [get_ports gt_rxp_in_10MAC_1]
##set_property PACKAGE_PIN AB44 [get_ports gt_rxn_in_10MAC_1]
##set_property PACKAGE_PIN AB38 [get_ports gt_txp_out_10MAC_1]
##set_property PACKAGE_PIN AB39 [get_ports gt_txn_out_10MAC_1]

# #40GMAC_0
# set_property PACKAGE_PIN K2 [get_ports {gt_rxp_in_40MAC_0[3]}]
# set_property PACKAGE_PIN K1 [get_ports {gt_rxn_in_40MAC_0[3]}]
# set_property PACKAGE_PIN K7 [get_ports {gt_txp_out_40MAC_0[3]}]
# set_property PACKAGE_PIN K6 [get_ports {gt_txn_out_40MAC_0[3]}]

# set_property PACKAGE_PIN L4 [get_ports {gt_rxp_in_40MAC_0[2]}]
# set_property PACKAGE_PIN L3 [get_ports {gt_rxn_in_40MAC_0[2]}]
# set_property PACKAGE_PIN L9 [get_ports {gt_txp_out_40MAC_0[2]}]
# set_property PACKAGE_PIN L8 [get_ports {gt_txn_out_40MAC_0[2]}]


# set_property PACKAGE_PIN M2 [get_ports {gt_rxp_in_40MAC_0[1]}]
# set_property PACKAGE_PIN M1 [get_ports {gt_rxn_in_40MAC_0[1]}]
# set_property PACKAGE_PIN M7 [get_ports {gt_txp_out_40MAC_0[1]}]
# set_property PACKAGE_PIN M6 [get_ports {gt_txn_out_40MAC_0[1]}]

# set_property PACKAGE_PIN N4 [get_ports {gt_rxp_in_40MAC_0[0]}]
# set_property PACKAGE_PIN N3 [get_ports {gt_rxn_in_40MAC_0[0]}]
# set_property PACKAGE_PIN N9 [get_ports {gt_txp_out_40MAC_0[0]}]
# set_property PACKAGE_PIN N8 [get_ports {gt_txn_out_40MAC_0[0]}]


# #40GAMC_1
# set_property PACKAGE_PIN K2 [get_ports {gt_rxp_in_40MAC_1[3]}]
# set_property PACKAGE_PIN K1 [get_ports {gt_rxn_in_40MAC_1[3]}]
# set_property PACKAGE_PIN K7 [get_ports {gt_txp_out_40MAC_1[3]}]
# set_property PACKAGE_PIN K6 [get_ports {gt_txn_out_40MAC_1[3]}]

# set_property PACKAGE_PIN L4 [get_ports {gt_rxp_in_40MAC_1[2]}]
# set_property PACKAGE_PIN L3 [get_ports {gt_rxn_in_40MAC_1[2]}]
# set_property PACKAGE_PIN L9 [get_ports {gt_txp_out_40MAC_1[2]}]
# set_property PACKAGE_PIN L8 [get_ports {gt_txn_out_40MAC_1[2]}]


# set_property PACKAGE_PIN M2 [get_ports {gt_rxp_in_40MAC_1[1]}]
# set_property PACKAGE_PIN M1 [get_ports {gt_rxn_in_40MAC_1[1]}]
# set_property PACKAGE_PIN M7 [get_ports {gt_txp_out_40MAC_1[1]}]
# set_property PACKAGE_PIN M6 [get_ports {gt_txn_out_40MAC_1[1]}]

# set_property PACKAGE_PIN N4 [get_ports {gt_rxp_in_40MAC_1[0]}]
# set_property PACKAGE_PIN N3 [get_ports {gt_rxn_in_40MAC_1[0]}]
# set_property PACKAGE_PIN N9 [get_ports {gt_txp_out_40MAC_1[0]}]
# set_property PACKAGE_PIN N8 [get_ports {gt_txn_out_40MAC_1[0]}]




################################################################

# create_clock -period 3.200 [get_ports gt_refclk_p]
create_clock -period 6.400 [get_ports gt_refclk_p]
##create_clock -period 6.400 [get_ports gt_ref_clk_p_40MAC_1]
##create_clock -period 6.400 [get_ports gt_ref_clk_p_10MAC_2]
##create_clock -period 6.400 [get_ports gt_ref_clk_p_40MAC_3]
set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks gt_refclk_p]  -group [get_clocks -include_generated_clocks sys_clk_p]


## set_false_path -from [get_pins {inst_vio_rstn/inst/PROBE_OUT_ALL_INST/G_PROBE_OUT[0].PROBE_OUT0_INST/Probe_out_reg[0]/C}] -to [get_pins inst_async_reset_sync_dereset1/rst_n_*_reg/CLR]
