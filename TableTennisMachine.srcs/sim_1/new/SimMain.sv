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

    parameter CLK_CYCLE = 4;

    reg CLK;

    reg hitA, hitB;
    // wire testOut;
    // wire [7: 0] ballLocation;
    wire EnA, EnB;

    initial begin 
        CLK = 'b0;
        hitA = 'b0;
        // speedA = 'b0;
        hitB = 'b0;
        // speedB = 'b0;
    end

    always #(CLK_CYCLE/2) CLK = ~CLK;

    wire [2: 0] status;

    Main main(CLK, hitA, hitB, status);

    initial begin 
        hitA = 'b0;
        #200;

        hitA = ~hitA;

        #50 
        hitA = ~hitA;

        #50 
        hitA = ~hitA;

        #50 
        hitA = ~hitA;

        #50 
        hitA = ~hitA;

        #50 
        hitA = ~hitA;

        #50 
        hitA = ~hitA;

        #50 
        hitA = ~hitA;

        #50 
        hitA = ~hitA;
    end

endmodule
