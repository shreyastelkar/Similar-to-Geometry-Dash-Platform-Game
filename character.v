`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/22/2022 07:01:47 PM
// Design Name:
// Module Name: character
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

module character(
input [9:0] x,
input [9:0] y,
input [9:0] top,
input [9:0] bottom,
input flash_loss,
input falling,
input frame,
input clk,
output [3:0] vgaRed,
output [3:0] vgaBlue,
output [3:0] vgaGreen,
output [9:0] flash_o
);
wire [3:0] logic;
wire [3:0] D_red;
wire [3:0] D_blue;
wire [3:0] D_green;
pixel_adder char_flash (.Inc(frame), .clk(clk), .Q(flash_o));
assign logic = ({4{flash_o[4] & flash_loss}} | {4{flash_o[4] & falling}}) &

{4{((x >= 10'd110) & (x <= 10'd126)) & ((y >= top) & (y <= bottom))}} |
((~{4{flash_loss}} & ~{4{falling}}) & {4{((x >= 10'd110) & (x <= 10'd126)) & ((y >=
top) & (y <= bottom))}}) ;
assign D_red = logic & 4'hC;
assign D_blue = logic & 4'h9;
assign D_green = logic & 4'h6;
FDRE #(.INIT(1'b0)) QR[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_red), .Q(vgaRed));
FDRE #(.INIT(1'b0)) QB[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_blue),
.Q(vgaBlue));
FDRE #(.INIT(1'b0)) QG[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_green),
.Q(vgaGreen));
endmodule