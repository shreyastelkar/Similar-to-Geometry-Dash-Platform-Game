`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/22/2022 08:16:50 PM
// Design Name:
// Module Name: Power_draw
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

module Power_draw(
input [9:0] x,
input [9:0] y,
input [9:0] height,
input start_state,
input player_down,
input clk,
input falling,
input flash_loss,
output [3:0] vgaRed,
output [3:0] vgaBlue,
output [3:0] vgaGreen
);
wire [3:0] pow_logic;
wire [3:0] D_red;
wire [3:0] D_blue;
wire [3:0] D_green;

// & ~{4{player_down}} &
assign pow_logic = ({~{4{start_state}} & ~{4{player_down}} & ~{4{falling}} &

~{4{flash_loss}} & {4{((x >= 10'd32) & (x <= 10'd48)) & ((y >= height) & (y <=
10'd96))}}}) | {({4{start_state}} | {4{player_down}} | {4{falling}} |
{4{flash_loss}}) & 4'b0};
assign D_red = pow_logic & 4'h4;
assign D_blue = pow_logic & 4'h5;
assign D_green = pow_logic & 4'hF;
FDRE #(.INIT(1'b0)) QR[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_red), .Q(vgaRed));
FDRE #(.INIT(1'b0)) QB[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_blue),
.Q(vgaBlue));
FDRE #(.INIT(1'b0)) QG[3:0] (.C({4{clk}}), .CE({4{1'b1}}), .D(D_green),
.Q(vgaGreen));
endmodule