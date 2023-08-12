`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/22/2022 12:15:11 PM
// Design Name:
// Module Name: bullet_move
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

module bullet_move(
input four_frame,
input frame,
input clk,
input [9:0] tp,
input [9:0] bp,
input [9:0] lp,
input [9:0] rp,
input dissapear,
input stop_bullet,
input shift_bullet,
input reset_timer,
output [9:0] cur_right,
output [9:0] cur_left,
output [9:0] cur_top,
output [9:0] cur_bottom,
output collision,
output two_sec
);
wire [7:0] lsfr_temp;
wire [7:0] lsfr;

wire [9:0] start_left;
wire [9:0] start_right;
wire [9:0] start_top;
wire [9:0] start_bottom;
wire [9:0] counter_out;
wire y_case1;
wire x_case2;
wire x_case3;
wire case1;
wire case2;
wire case3;
wire l_zero;
wire [9:0] time_out;
//collision cases
//case1
assign y_case1 = ~|(rp ^ cur_left);
assign case1 = (y_case1 & (((tp < cur_top) & (tp < cur_bottom) & (bp > cur_top)
& (bp > cur_bottom)) | ((tp > cur_top) & (tp < cur_bottom) & (bp > cur_top) & (bp >
cur_bottom)) | ((tp < cur_top) & (tp < cur_bottom) & (bp > cur_top) & (bp <
cur_bottom))));
//case2
assign x_case2 = ~|(bp ^ cur_top);
assign case2 = x_case2 & (((lp < cur_left) & (lp < cur_right) & (rp > cur_left)
& (rp > cur_right)) | ((lp < cur_left) & (lp < cur_right) & (rp > cur_left) & (rp <
cur_right)) | ((lp > cur_left) & (lp < cur_right) & (rp > cur_left) & (rp >
cur_right)));
//case3
assign x_case3 = ~|(tp ^ cur_bottom);
assign case3 = x_case3 & (((lp < cur_left) & (lp < cur_right) & (rp > cur_left)
& (rp > cur_right)) | ((lp > cur_left) & (lp < cur_right) & (rp > cur_left) & (rp >
cur_right)) | ((lp < cur_left) & (lp < cur_right) & (rp > cur_left) & (rp <
cur_right)));
assign collision = (case1 | case2 | case3);
//flash
pixel_adder flash (.Inc(frame), .R(reset_timer), .clk(clk), .Q(time_out));
assign two_sec = ~time_out[0] & ~time_out[1] & time_out[2] & ~time_out[3] &
time_out[4] & time_out[5] & ~time_out[6] & time_out[7] & ~time_out[8] & ~time_out[9];
//bullet_move
// & shift_bullet
pixel_adder bc (.Inc(four_frame & shift_bullet & ~stop_bullet), .R(cur_right <=

10'd8 | dissapear), .clk(clk), .Q(counter_out));
LFSR rand_w (.clk(clk), .Q_rand(lsfr_temp));
assign start_left = 10'd640;
assign start_right = {start_left + 10'd8};
assign start_top = {lsfr[5:0] + 10'd192};
assign start_bottom = {start_top + 10'd8};
assign cur_left = (({10{cur_right > 10'd15}}) & (start_left - counter_out)) |
(({10{cur_right <= 10'd15}}) & 10'd7);
assign cur_right = start_right - counter_out;
assign cur_top = start_top;
assign cur_bottom = start_bottom;
FDRE #(.INIT(1'b1)) Qlfsr[7:0] (.C({8{clk}}), .CE({8{cur_right <=
10'd8}}),.D(lsfr_temp), .Q(lsfr));
endmodule