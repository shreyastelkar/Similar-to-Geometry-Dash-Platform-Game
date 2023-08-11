`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/21/2022 12:10:38 PM
// Design Name:
// Module Name: top_plat
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

module top_plat(
input [9:0] x,
input [9:0] y,
input [9:0] in_right,
input [9:0] in_left,
//input SHL,
input clk,
output [3:0] vgaRed,
output [3:0] vgaBlue,
output [3:0] vgaGreen
);
wire [3:0] logic;
wire [3:0] logic1;
wire [3:0] D_red;
wire [3:0] D_blue;
wire [3:0] D_green;
assign logic = (({4{(((x >= 10'd8 & x <= in_left) | (x >= in_right & x <=
10'd631)) & (y >= 10'd349 & y <= 10'd371))}}));
assign logic1 = 4'b0;//(~{4{SHL}} & ({4{(x >= 10'd8 & x <= 10'd631) & (y >=
10'd349 & y <= 10'd371)}}));

assign D_red = (logic | logic1) & 4'hA;
assign D_blue = (logic | logic1) & 4'h4;
assign D_green = (logic | logic1) & 4'h5;
FDRE #(.INIT(1'b0)) QR[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_red), .Q(vgaRed));
FDRE #(.INIT(1'b0)) QB[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_blue),
.Q(vgaBlue));
FDRE #(.INIT(1'b0)) QG[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_green),
.Q(vgaGreen));
endmodule