`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/21/2022 10:45:40 AM
// Design Name:
// Module Name: bottom_plat
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

module bottom_plat(
input [9:0] x,
input [9:0] y,
input clk,
output [3:0] vgaRed,
output [3:0] vgaBlue,
output [3:0] vgaGreen
);
wire [3:0] logic;
wire [3:0] D_red;
wire [3:0] D_blue;
wire [3:0] D_green;
//and colors
assign logic = {4{((x >= 10'd8 & x <= 10'd631) & (y >= 10'd372 & y <= 10'd471))}};
assign D_red = logic & 4'h4;
assign D_blue = logic & 4'h3;
assign D_green = logic & 4'h4;
FDRE #(.INIT(1'b0)) QR[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_red), .Q(vgaRed));
FDRE #(.INIT(1'b0)) QB[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_blue),
.Q(vgaBlue));

FDRE #(.INIT(1'b0)) QG[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_green),
.Q(vgaGreen));
endmodule