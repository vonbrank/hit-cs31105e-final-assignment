`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/28 09:44:47
// Design Name: 
// Module Name: Main
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


module Main(CLK, hitA, speedA, hitB, speedB, testOut);
    input CLK, hitA, speedA, hitB, speedB;
    output reg testOut;
    
    ClockDivider u1(CLK, dividedCLK);

    wire hitOutA, speedOutA;
    Player player1(dividedCLK, 'b1, hitA, speedA, hitOutA, speedOutA);

    initial begin 
        testOut = 'b1;
    end

    always @(posedge hitOutA) begin
        testOut = ~testOut;
    end

endmodule
