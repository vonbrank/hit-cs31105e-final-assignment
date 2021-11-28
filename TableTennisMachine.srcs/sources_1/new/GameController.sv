`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/28 09:18:48
// Design Name: 
// Module Name: GameController
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


module GameController(CLK, playerOneHit, playerOneSpeed, playerTwoHit, playerTwoSpeed, serviceSide, reset,
                      EnA, EnB, getScoreA, getScoreB, ballocation );
    input CLK, playerOneHit, playerOneSpeed, playerTwoHit, playerTwoSpeed, serviceSide, reset;
    output EnA, EnB, getScoreA, getScoreB; 
    output [7:0] ballocation;
endmodule
