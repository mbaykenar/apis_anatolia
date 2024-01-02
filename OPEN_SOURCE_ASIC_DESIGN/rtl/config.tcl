##################################################################
# GENERAL
##################################################################
set ::env(DESIGN_NAME) "picorv32"
set ::env(PDK) "sky130A"
set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/src/*.v]
set ::env(CLOCK_PERIOD) 100
set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_NET) "clk"
#set ::env(DESIGN_IS_CORE) 0
set ::env(LEC_ENABLE) 0

##################################################################
# LINTING
##################################################################
set ::env(RUN_LINTER) 1
set ::env(QUIT_ON_LINTER_WARNINGS) 0
set ::env(QUIT_ON_LINTER_ERRORS) 1

##################################################################
# SYNSTHESIS
##################################################################
set ::env(SYNTH_CLOCK_UNCERTAINTY) 0.25
set ::env(SYNTH_CLOCK_UNCERTAINTY) 0.15
# DELAY/AREA 0-4/0-3
#set ::env(SYNTH_STRATEGY) "DELAY 3"
set ::env(SYNTH_NO_FLAT) 0
set ::env(SYNTH_SHARE_RESOURCES) 1
# YOSYS/FA/RCA/CSA carry select adder
set ::env(SYNTH_ADDER_TYPE) "YOSYS"
set ::env(BASE_SDC_FILE) [glob $::env(DESIGN_DIR)/src/*.sdc]
set ::env(SYNTH_FLAT_TOP) 0
set ::env(SYNTH_USE_PG_PINS_DEFINES) "USE_POWER_PINS"
set ::env(QUIT_ON_TIMING_VIOLATIONS) 1
set ::env(QUIT_ON_SETUP_VIOLATIONS) 1
set ::env(QUIT_ON_HOLD_VIOLATIONS) 1

##################################################################
# FLOORPLAN
##################################################################
set ::env(RUN_TAP_DECAP_INSERTION) 1
set ::env(FP_CORE_UTIL) 45
set ::env(FP_ASPECT_RATIO) 1
#set ::env(FP_SIZING) "relative"
set ::env(FP_SIZING) "absolute"
set ::env(DIE_AREA) "0 0 600 600"
set ::env(VDD_NETS) "vccd1"
set ::env(GND_NETS) "vssd1"
set ::env(SYNTH_USE_PG_PINS_DEFINES) "USE_POWER_PINS"
set ::env(FP_PIN_ORDER_CFG) [glob $::env(DESIGN_DIR)/pin_order.cfg]
set ::env(FP_PDN_CORE_RING) 0
set ::env(FP_PDN_MULTILAYER) 0
set ::env(RT_MAX_LAYER) "met4"
set ::env(FP_PDN_SKIPTRIM) 0
set ::env(FP_PDN_ENABLE_RAILS) 1
#set ::env(FP_PDN_CORE_RING_VWIDTH) 3.1
#set ::env(FP_PDN_CORE_RING_HWIDTH) 3.1
#set ::env(FP_PDN_CORE_RING_VOFFSET) 12.45
#set ::env(FP_PDN_CORE_RING_HOFFSET) 12.45
#set ::env(FP_PDN_CORE_RING_VSPACING) 1.7
#set ::env(FP_PDN_CORE_RING_HSPACING) 1.7
#set ::env(FP_PDN_VWIDTH) 3.1
#set ::env(FP_PDN_HWIDTH) 3.1
#set ::env(FP_PDN_VSPACING) [expr::(5 * $FP_PDN_CORE_RING_VWIDTH)]
#set ::env(FP_PDN_HSPACING) [expr::(5 * $FP_PDN_CORE_RING_HWIDTH)]
#set ::env(FP_PDN_VPITCH) 180
#set ::env(FP_PDN_HPITCH) 180
#set ::env(FP_PDN_VOFFSET) 5
#set ::env(FP_PDN_HOFFSET) 5

##################################################################
# PLACEMENT
##################################################################
set ::env(PL_TARGET_DENSITY) 0.55 
set ::env(PL_BASIC_PLACEMENT) 0
set ::env(PL_RESIZER_BUFFER_INPUT_PORTS) 1
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(GLB_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(RUN_CTS) 1 
set ::env(RUN_FILL_INSERTION) 1 

##################################################################
# ROUTING
##################################################################
set ::env(ROUTING_CORES) 4  
set ::env(GRT_ALLOW_CONGESTION) 1  
set ::env(DRT_OPT_ITERS) 20  

##################################################################
# SIGNOFF
##################################################################
set ::env(RUN_CVC) 1   
set ::env(RUN_IRDROP_REPORT) 1
