`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/28 10:54:43
// Design Name: 
// Module Name: SimMain
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


module SimMain();

    parameter CLK_CYCLE = 10;

    reg CLK;
    initial begin 
        CLK = 'b0;
    end
    always #(CLK_CYCLE/2) CLK = ~CLK;

    reg hitA;
    // wire testOut;

    Main main(CLK, hitA, 'b0, 'b0, 'b0);

    initial begin 
        hitA = 'b0;

        #225
        hitA = ~hitA;

        #50
        hitA = ~hitA;

        # 125
        hitA = ~hitA;

        # 50
        hitA = ~hitA;
    end

endmodule
