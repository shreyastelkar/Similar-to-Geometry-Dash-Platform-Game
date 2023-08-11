`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/21/2022 10:55:42 AM
// Design Name:
// Module Name: top
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

module top(
input btnC,
// input btnD,
input btnU,
// input btnL,
input btnR,
input [15:0] sw,
input clkin,
output [3:0] an,
output dp,
output [6:0] seg,
// output [15:0] led,
output [3:0] vgaRed,
output [3:0] vgaBlue,
output [3:0] vgaGreen,
output Hsync,
output Vsync
);
wire clk;
wire digsel;
wire [9:0] x;
wire [9:0] y;

wire [3:0] vgaRed_border;
wire [3:0] vgaBlue_border;
wire [3:0] vgaGreen_border;
wire [3:0] vgaRed_bplat;
wire [3:0] vgaBlue_bplat;
wire [3:0] vgaGreen_bplat;
wire [3:0] vgaRed_tplat;
wire [3:0] vgaBlue_tplat;
wire [3:0] vgaGreen_tplat;
wire [3:0] vgaRed_blplat;
wire [3:0] vgaBlue_blplat;
wire [3:0] vgaGreen_blplat;
wire [3:0] vgaRed_cplat;
wire [3:0] vgaBlue_cplat;
wire [3:0] vgaGreen_cplat;
wire [9:0] right_hole;
wire frame;
wire frame1;
wire frame2;
wire frame3;
wire four_frames;
wire [9:0] c_right;
wire [9:0] c_left;
wire [9:0] cu_right;
wire [9:0] cu_left;
wire [9:0] cu_top;
wire [9:0] cu_bottom;
wire max;
wire power_zero;
wire player_zero;
wire power_inc;
wire power_dec;
wire [9:0] pow_height;
wire [3:0] vgaRed_pow;
wire [3:0] vgaBlue_pow;
wire [3:0] vgaGreen_pow;
wire [9:0] player_height;
wire [9:0] play_top;
wire [9:0] play_bottom;
wire player_down;
wire start_state;
wire at_max;

wire ground;
wire keep_fall;
wire falling;
wire flash_loss;
wire collision;
wire two_sec;
wire dissapear;
wire shift_plat;
wire shift_bullet;
wire stop_bullet;
wire reset_timer;
wire [9:0] flash_o;
wire [9:0] count_out;
wire [9:0] count_o;
wire [3:0] control;
wire [3:0] hex_in;
labVGA_clks not_so_slow (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(digsel));
pixel_adder px (.Inc(1'b1), .R((~|(x ^ 10'd799))), .clk(clk), .Q(x));
pixel_adder py (.Inc((~|(x ^ 10'd799))), .R((~|(x ^ 10'd799))&(~|(y ^
10'd524))), .clk(clk), .Q(y));

assign frame = ((~|(x ^ 10'd760)) & (~|(y ^ 10'd480)));
assign frame1 = ((~|(x ^ 10'd600)) & (~|(y ^ 10'd500)));
assign frame2 = ((~|(x ^ 10'd500)) & (~|(y ^ 10'd482)));
assign frame3 = ((~|(x ^ 10'd780)) & (~|(y ^ 10'd520)));
assign four_frames = (frame | frame1 | frame2 | frame3);
Shift_L shl (.frame(frame), .shift_plat(shift_plat), .clk(clk),
.cur_right(c_right), .cur_left(c_left));
top_plat tp (.x(x), .y(y), .in_right(c_right), .in_left(c_left), .clk(clk),
.vgaRed(vgaRed_tplat), .vgaBlue(vgaBlue_tplat), .vgaGreen(vgaGreen_tplat));
bottom_plat bp (.x(x), .y(y), .clk(clk), .vgaRed(vgaRed_bplat),
.vgaBlue(vgaBlue_bplat), .vgaGreen(vgaGreen_bplat));
border bor (.x(x), .y(y), .clk(clk), .vgaRed(vgaRed_border),
.vgaBlue(vgaBlue_border), .vgaGreen(vgaGreen_border), .Hsync(Hsync), .Vsync(Vsync));
bullet_move bm (.four_frame(four_frames), .frame(frame | frame1 | frame2),
.shift_bullet(shift_bullet), .clk(clk), .tp(play_top), .bp(play_bottom),
.lp(10'd110), .rp(10'd126), .cur_right(cu_right), .cur_left(cu_left),
.cur_top(cu_top), .cur_bottom(cu_bottom), .dissapear(dissapear),

.stop_bullet(stop_bullet), .reset_timer(reset_timer), .collision(collision),
.two_sec(two_sec)); //
bullet b (.x(x), .y(y), .right(cu_right), .left(cu_left), .top(cu_top),
.bottom(cu_bottom), .stop_bullet(stop_bullet), .clk(clk), .vgaRed(vgaRed_blplat),
.vgaBlue(vgaBlue_blplat), .vgaGreen(vgaGreen_blplat), .flash_o(flash_o),
.two(two_sec));
bullet_state bs (.clk(clk), .btnC(btnC), .collision(collision),
.two_sec(two_sec), .flash_loss(flash_loss), .dissapear(dissapear),
.shift_plat(shift_plat), .shift_bullet(shift_bullet), .stop_bullet(stop_bullet),
.reset_timer(reset_timer));
character char (.x(x), .y(y), .top(play_top), .bottom(play_bottom),
.frame(frame), .flash_loss(flash_loss), .falling(falling), .clk(clk),
.vgaRed(vgaRed_cplat), .vgaBlue(vgaBlue_cplat), .vgaGreen(vgaGreen_cplat),
.flash_o(flash_o));
Power_logic plog (.frame(frame), .frame1(frame | frame1), .clk(clk),
.power_inc(power_inc), .power_dec(power_dec), .p_max(max), .p_zero(power_zero),
.pow_height(pow_height), .player_zero(player_zero), .player_down(player_down),
.player_top(play_top), .player_bottom(play_bottom), .at_max(at_max),
.ground(ground), .keep_fall(keep_fall), .l_p(c_left), .r_p(c_right),
.falling(falling), .flash_loss(flash_loss));
Power_state pstate (.clk(clk), .sw15(sw[15]), .btnU(btnU), .max(max),
.power_zero(power_zero), .player_zero(player_zero), .power_inc(power_inc),
.power_dec(power_dec), .player_down(player_down), .start_state(start_state),
.at_max(at_max), .ground(ground), .keep_fall(keep_fall), .falling(falling),
.flash_loss(flash_loss));
Power_draw pdraw (.x(x), .y(y), .height(pow_height), .player_down(player_down),
.falling(falling), .start_state(start_state), .flash_loss(flash_loss), .clk(clk),
.vgaRed(vgaRed_pow), .vgaBlue(vgaBlue_pow), .vgaGreen(vgaGreen_pow));
assign vgaRed = {(vgaRed_tplat | vgaRed_bplat | vgaRed_border | vgaRed_blplat |
vgaRed_cplat | vgaRed_pow)};
assign vgaBlue = {(vgaBlue_tplat | vgaBlue_bplat | vgaBlue_border |
vgaBlue_blplat | vgaBlue_cplat | vgaBlue_pow)};
assign vgaGreen = {(vgaGreen_tplat | vgaGreen_bplat | vgaGreen_border |
vgaGreen_blplat | vgaGreen_cplat | vgaGreen_pow)};
pixel_adder count (.Inc(reset_timer), .R(1'b0), .clk(clk), .Q(count_out));
Ring_Counter ring (.advance(digsel), .clk(clk), .control(control));
Selector selector (.sel(control), .N({6'b0,count_o}), .H(hex_in));
hex7seg hex (.n(hex_in), .seg(seg));

//FDRE #(.INIT(1'b1)) Q0_FF (.C(clk), .CE(collision), .D(count_out), .Q(count_o));
assign an[3] = 1'b1;
assign an[2] = 1'b1;
assign an[1] = ~control[1];
assign an[0] = ~control[0];
assign dp = 1'b1;
endmodule