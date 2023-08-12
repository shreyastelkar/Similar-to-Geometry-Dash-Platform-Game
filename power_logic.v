`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/22/2022 08:17:08 PM
// Design Name:
// Module Name: Power_logic
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

module Power_logic(
input frame,
input frame1,
input clk,
input power_inc,
input power_dec,
input at_max,
input player_down,
input [9:0] l_p,
input [9:0] r_p,
input falling,
input flash_loss,
output p_max,
output p_zero,
output [9:0] pow_height,
output player_zero,
output [9:0] player_top,
output [9:0] player_bottom,
output ground,
output keep_fall
);
wire [9:0] counter_inc;

wire [9:0] counter_dec;
wire [9:0] play_inc;
wire [9:0] play_dec;
wire [9:0] start_height;
wire [9:0] start_top;
wire [9:0] start_bottom;
wire [9:0] cur_height_up;
wire [9:0] cur_height_down;
wire [9:0] player_top_up;
wire [9:0] player_top_down;
wire [9:0] player_bottom_up;
wire [9:0] player_bottom_down;
wire [9:0] p_r;
wire [9:0] p_l;
wire floor_log;
wire [9:0] floor;
assign start_height = 10'd96;
assign start_top = 10'd332;
assign start_bottom = 10'd348;
assign p_r = 10'd126;
assign p_l = 10'd110;
assign player_zero = (~|(player_bottom ^ start_bottom));
assign p_max = (~|(cur_height_up ^ 10'd32));
assign p_zero = (~|(cur_height_down ^ 10'd96));
assign ground = (~|(player_bottom ^ 10'd471));
assign keep_fall = (~|(floor ^ 10'd471));
assign floor_log = ((p_r < r_p) & (p_r > l_p) & (p_l > l_p) & (p_l < r_p));
assign floor = {{10{player_zero}} & (({10{floor_log}} & 10'd471) |
(~{10{floor_log}} & start_bottom))};
pixel_adder inc (.Inc(frame & power_inc & ~at_max), .R(p_zero & ~power_inc),
.clk(clk), .Q(counter_inc));
pixel_adder dec (.Inc(frame & power_dec & ~at_max), .R(p_zero), .clk(clk),
.Q(counter_dec));
pixel_adder p_inc (.Inc(frame1 & power_dec & ~at_max), .R(((player_zero &

~keep_fall) | ground) & ~power_dec), .clk(clk), .Q(play_inc));
pixel_adder p_dec (.Inc(frame1 & (player_down | falling) & ~at_max),
.R(((player_zero & ~keep_fall) | ground) & ~player_down), .clk(clk), .Q(play_dec));
assign cur_height_up = {(start_height - counter_inc)};
assign cur_height_down = {(cur_height_up + counter_dec)};
assign player_top_up = {(start_top - play_inc)};
assign player_top_down = {(player_top_up + play_dec)};
assign player_bottom_up= {(start_bottom - play_inc)};
assign player_bottom_down = {(player_bottom_up + play_dec)};
assign player_top = {{10{power_dec}} & ~{10{player_down}} & player_top_up} |
{~{10{power_dec}} & ({10{player_down}} | {10{falling}}) & player_top_down} |
{~{10{power_dec}} & ~{10{player_down}} & ~{10{falling}} & ~{10{flash_loss}} &
start_top} | {{10{flash_loss}} & 10'd455};
assign player_bottom = {{10{power_dec}} & ~{10{player_down}} & player_bottom_up}
| {~{10{power_dec}} & ({10{player_down}} | {10{falling}}) & player_bottom_down} |
{~{10{power_dec}} & ~{10{player_down}} & ~{10{falling}} & ~{10{flash_loss}} &
start_bottom} | {{10{flash_loss}} & 10'd471};
assign pow_height = {{10{power_inc}} & ~{10{power_dec}} & cur_height_up} |
{{10{power_dec}} & ~{10{power_inc}} & cur_height_down} | {{10{at_max}} &
~{10{power_inc}} & ~{10{power_dec}} & 10'd32};
endmodule