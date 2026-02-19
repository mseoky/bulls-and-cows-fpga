// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"
// CREATED		"Sat Nov 30 16:56:22 2024"

module fourbit_comparator(
	Reg1,
	Reg2,
	out
);


input wire	[3:0] Reg1;
input wire	[3:0] Reg2;
output wire	out;

wire	[3:0] f;
wire	[3:0] s;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;




assign	out = SYNTHESIZED_WIRE_0 & SYNTHESIZED_WIRE_1 & SYNTHESIZED_WIRE_2 & SYNTHESIZED_WIRE_3;

assign	SYNTHESIZED_WIRE_0 = f[3] ~^ s[3];

assign	SYNTHESIZED_WIRE_1 = f[2] ~^ s[2];

assign	SYNTHESIZED_WIRE_2 = f[1] ~^ s[1];

assign	SYNTHESIZED_WIRE_3 = f[0] ~^ s[0];

assign	f = Reg1;
assign	s = Reg2;

endmodule
