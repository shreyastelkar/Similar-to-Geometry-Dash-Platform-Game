`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/28/2022 05:14:03 PM
// Design Name:
// Module Name: bullet_state
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

module bullet_state(
input clk,
input btnC,
input collision,
input two_sec,
input flash_loss,
output dissapear,
output shift_plat,
output shift_bullet,
output stop_bullet,
output reset_timer
);
wire [3:0] D;
wire [3:0] Q;
FDRE #(.INIT(1'b1)) Q0_FF (.C(clk), .CE(1'b1), .D(D[0]), .Q(Q[0]));
FDRE #(.INIT(1'b0)) Qrest_FF[3:1] (.C({3{clk}}), .CE({3{1'b1}}), .D(D[3:1]),
.Q(Q[3:1]));
assign D[0] = (Q[0] & ~btnC);
assign D[1] = (Q[0] & btnC) | (Q[1] & ~collision & ~flash_loss) | (Q[2] & two_sec);
assign D[2] = (Q[1] & collision) | (Q[2] & ~two_sec & ~flash_loss);

assign D[3] = (Q[2] & flash_loss) | (Q[1] & flash_loss) | Q[3];
assign shift_plat = Q[1] | Q[2];
assign shift_bullet = Q[1] | Q[3];
assign stop_bullet = Q[2];
assign dissapear = Q[2] & two_sec;
assign reset_timer = Q[1] & collision;
endmodule