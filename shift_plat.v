`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/22/2022 08:26:09 AM
// Design Name:
// Module Name: Shift_L
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

module Shift_L(
input frame,
input clk,
input shift_plat,
output [9:0] cur_right,
output [9:0] cur_left
);
wire [7:0] lsfr_temp;
wire [7:0] lsfr;
wire [9:0] start_left;
wire [9:0] start_right;
wire [9:0] counter_out;
pixel_adder lc (.Inc(frame & shift_plat), .R((cur_right <= 10'd8)), .clk(clk),
.Q(counter_out));
LFSR rand_width (.clk(clk), .Q_rand(lsfr_temp));
assign start_left = 10'd631;
assign start_right = {start_left + {2'b0, 8'd40} + {5'b0, lsfr[4:0]}};
assign cur_left = (({10{cur_right > ({2'b0, 8'd40} + {5'b0, lsfr[4:0]})}}) &

(start_left - counter_out)) | ({10{cur_right <= ({2'b0, 8'd40} + {5'b0,
lsfr[4:0]})}} & 10'd7);
assign cur_right = start_right - counter_out;
//
FDRE #(.INIT(1'b1)) Qlfsr[7:0] (.C({8{clk}}), .CE(({8{cur_right <= 10'd8}})),
.D(lsfr_temp), .Q(lsfr));
endmodule