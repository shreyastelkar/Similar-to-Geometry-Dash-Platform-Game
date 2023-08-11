`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/20/2022 03:05:03 PM
// Design Name:
// Module Name: pixel_adder
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module pixel_adder(
input Inc,
input R,
input clk,
output [9:0] Q
);
wire [9:0] D;
assign D[9] = Q[9] ^ (Q[8] & Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] &
Q[0] & Inc);
assign D[8] = Q[8] ^ (Q[7] & Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & Inc);
assign D[7] = Q[7] ^ (Q[6] & Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & Inc);
assign D[6] = Q[6] ^ (Q[5] & Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & Inc);
assign D[5] = Q[5] ^ (Q[4] & Q[3] & Q[2] & Q[1] & Q[0] & Inc);
assign D[4] = Q[4] ^ (Q[3] & Q[2] & Q[1] & Q[0] & Inc);
assign D[3] = Q[3] ^ (Q[2] & Q[1] & Q[0] & Inc);
assign D[2] = Q[2] ^ (Q[1] & Q[0] & Inc);
assign D[1] = Q[1] ^ (Q[0] & Inc);
assign D[0] = Q[0] ^ Inc;
//Flip Flops
FDRE #(.INIT(1'b0)) Q0_FF (.C(clk), .CE(1'b1), .R(R), .D(D[0]), .Q(Q[0]));

FDRE #(.INIT(1'b0)) Q1_FF (.C(clk), .CE(1'b1), .R(R), .D(D[1]), .Q(Q[1]));
FDRE #(.INIT(1'b0)) Q2_FF (.C(clk), .CE(1'b1), .R(R), .D(D[2]), .Q(Q[2]));
FDRE #(.INIT(1'b0)) Q3_FF (.C(clk), .CE(1'b1), .R(R), .D(D[3]), .Q(Q[3]));
FDRE #(.INIT(1'b0)) Q4_FF (.C(clk), .CE(1'b1), .R(R), .D(D[4]), .Q(Q[4]));
FDRE #(.INIT(1'b0)) Q5_FF (.C(clk), .CE(1'b1), .R(R), .D(D[5]), .Q(Q[5]));
FDRE #(.INIT(1'b0)) Q6_FF (.C(clk), .CE(1'b1), .R(R), .D(D[6]), .Q(Q[6]));
FDRE #(.INIT(1'b0)) Q7_FF (.C(clk), .CE(1'b1), .R(R), .D(D[7]), .Q(Q[7]));
FDRE #(.INIT(1'b0)) Q8_FF (.C(clk), .CE(1'b1), .R(R), .D(D[8]), .Q(Q[8]));
FDRE #(.INIT(1'b0)) Q9_FF (.C(clk), .CE(1'b1), .R(R), .D(D[9]), .Q(Q[9]));
endmodule