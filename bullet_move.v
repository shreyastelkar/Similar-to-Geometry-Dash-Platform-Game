`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/22/2022 10:55:38 AM
// Design Name:
// Module Name: bullet
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

module bullet(
input [9:0] x,
input [9:0] y,
input [9:0] left,
input [9:0] right,
input [9:0] top,
input [9:0] bottom,
input clk,
input stop_bullet,
input [9:0] flash_o,
input two,
output [3:0] vgaRed,
output [3:0] vgaBlue,
output [3:0] vgaGreen
);
wire [3:0] logic;
wire [3:0] D_red;
wire [3:0] D_blue;
wire [3:0] D_green;
// & two
// & flash_o[3]

assign logic = ({{4{stop_bullet & flash_o[4]}} & {4{((x >= left) & (x <= right))
& ((y >= top) & (y <= bottom))}}}) | ({~{4{stop_bullet}} & {4{((x >= left) & (x <=
right)) & ((y >= top) & (y <= bottom))}}});
assign D_red = logic & 4'hB;
assign D_blue = logic & 4'hB;
assign D_green = logic & 4'hC;
FDRE #(.INIT(1'b0)) QR[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_red), .Q(vgaRed));
FDRE #(.INIT(1'b0)) QB[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_blue),
.Q(vgaBlue));
FDRE #(.INIT(1'b0)) QG[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_green),
.Q(vgaGreen));
endmodule