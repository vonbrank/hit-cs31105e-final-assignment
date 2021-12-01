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


module Main(
    input CLK, 
    input hitA, 
    input speedA, 
    input hitB, 
    input speedB, 
    output reg [3: 0] statusOut, 
    output wire [7: 0] ballLocation
    );


    wire [2: 0] status;
    wire dividedCLK;
    wire [1: 0] speedOutA;
    wire [1: 0] speedOutB;
    wire getScoreA, getScoreB;
    ClockDivider clockDivider(CLK, dividedCLK);

    // wire hitOutA, hitOutB, speedOuta, speedOutB;

    Player player1(dividedCLK, 'b1, hitA, speedA, hitOutA, speedOutA);
    Player player2(dividedCLK, 'b1, hitB, speedB, hitOutB, speedOutB);

    GameController gameController(dividedCLK, hitOutA, speedOutA, hitOutB, speedOutB, status, ballLocation, getScoreA, getScoreB);

    always @(posedge dividedCLK) begin
        if(status == 'b010) begin
            statusOut = 'b1000;
        end
        else if(status == 'b001) begin
            statusOut = 'b0001;
        end
        else if(status == 'b110) begin
            statusOut = 'b0100;
        end
        else if(status == 'b101) begin
            statusOut = 'b0010;
        end
    end

endmodule
