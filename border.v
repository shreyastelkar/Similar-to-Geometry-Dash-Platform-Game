`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/20/2022 03:05:35 PM
// Design Name:
// Module Name: border
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

module border(
// input btnC,
// input btnD,
// input btnU,
// input btnL,
// input btnR,
// input [15:0] sw,
// input clkin,
// output [3:0] an,
// output dp,
// output [6:0] seg,
// output [15:0] led,
input clk,
input [9:0] x,
input [9:0] y,
output [3:0] vgaRed,
output [3:0] vgaBlue,
output [3:0] vgaGreen,
output Hsync,
output Vsync
);

wire [3:0] D_red;
wire [3:0] D_blue;
wire [3:0] D_green;
wire Hsyn;
wire Vsyn;
assign D_red = {4{(((((x >= 10'd0) & (x <= 10'd7)) | ((x >= 10'd632) & (x <=
10'd639))) & (y <= 10'd479 & y >= 10'd0)) | ((((y >= 10'd0) & (y <= 10'd7)) | ((y >=
10'd472) & (y <= 10'd479))) & (x >= 10'd0 & x <= 10'd639)))}};
assign D_blue = 4'b0000;
assign D_green = 4'b0000;
assign Hsyn = ~((x >= 10'd655) & (x <= 10'd750));
assign Vsyn = ~((y >= 10'd489) & (y <= 10'd490));
FDRE #(.INIT(1'b0)) QRed[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_red),
.Q(vgaRed));
FDRE #(.INIT(1'b0)) QBlue[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_blue),
.Q(vgaBlue));
FDRE #(.INIT(1'b0)) QGreen[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_green),
.Q(vgaGreen));
FDRE #(.INIT(1'b1)) QH (.C(clk), .CE(1'b1), .D(Hsyn), .Q(Hsync));
FDRE #(.INIT(1'b1)) QV (.C(clk), .CE(1'b1), .D(Vsyn), .Q(Vsync));
endmodule