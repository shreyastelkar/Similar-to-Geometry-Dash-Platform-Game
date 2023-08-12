`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/22/2022 07:56:04 PM
// Design Name:
// Module Name: Power_state
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

module Power_state(
input clk,
input sw15,
input btnU,
input max,
input power_zero,
input player_zero,
input ground,
input keep_fall,
input btnC,
output start_state,
output power_inc,
output power_dec,
output player_down,
output at_max,
output falling,
output flash_loss
);
//make max assert y is at the max
wire [6:0] D;
wire [6:0] Q;

FDRE #(.INIT(1'b1)) Q0_FF (.C(clk), .CE(1'b1), .D(D[0]), .Q(Q[0]));
FDRE #(.INIT(1'b0)) Qrest_FF[6:1] (.C({6{clk}}), .CE({6{1'b1}}), .D(D[6:1]),
.Q(Q[6:1]));
assign D[0] = (Q[0] & ~btnU & (~keep_fall | (keep_fall & sw15))) | (Q[4] &
player_zero & ~keep_fall) | (Q[4] & player_zero & keep_fall & sw15);
assign D[1] = (Q[0] & btnU) | (Q[1] & btnU & ~max & (~keep_fall | keep_fall &
sw15));
assign D[2] = (Q[1] & ((~btnU & ~max & ~keep_fall) | (keep_fall & sw15))) |
(Q[2] & ~power_zero) | (Q[3] & ~btnU & max);
assign D[3] = (Q[1] & max & btnU) | (Q[3] & ((btnU & max & ~keep_fall) |
(keep_fall & sw15)));
assign D[4] = (Q[2] & power_zero) | (Q[4] & ~player_zero);
assign D[5] = (Q[4] & player_zero & keep_fall & ~sw15) | (Q[5] & ~ground) |
(Q[0] & keep_fall & player_zero & ~sw15) | (Q[1] & keep_fall & player_zero & ~sw15)
| (Q[3] & keep_fall & player_zero & ~sw15);
assign D[6] = (Q[5] & ground) | Q[6];
// | Q[6]
assign start_state = Q[0];
assign power_inc = Q[1];
assign power_dec = Q[2];
assign at_max = Q[3];
assign falling = Q[5];
assign player_down = Q[4];
assign flash_loss = Q[6];
endmodule