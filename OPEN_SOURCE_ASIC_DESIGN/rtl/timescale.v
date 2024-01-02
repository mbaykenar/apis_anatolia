`timescale 1ns / 10ps

//`ifdef DEBUG
//  `define debug(debug_command) debug_command
//`else
//  `define debug(debug_command)
//`endif
//
//`ifdef FORMAL
//  `define FORMAL_KEEP (* keep *)
//  `define assert(assert_expr) assert(assert_expr)
//`else
//  `ifdef DEBUGNETS
//    `define FORMAL_KEEP (* keep *)
//  `else
//    `define FORMAL_KEEP
//  `endif
//  `define assert(assert_expr) empty_statement
//`endif

// uncomment this for register file in extra module
// `define PICORV32_REGS picorv32_regs

// this macro can be used to check if the verilog files in your
// design are read in the correct order.
//`define PICORV32_V
