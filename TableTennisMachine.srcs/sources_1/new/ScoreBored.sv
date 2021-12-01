`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/30 16:02:20
// Design Name: 
// Module Name: Scoreboard
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


module ScoreBoard(
    input CLK, 
    input getScoreA, 
    input getScoreB, 
    output reg serviceSide, 
    output reg endGame, 
    output reg [1:0] winner, 
    output reg [15: 0] scoreA, 
    output reg [15: 0] scoreB
    );
    reg getScoreATrigger;
    reg getScoreBTrigger;
    initial begin
        serviceSide = 'b0;
        endGame = 'b0;
        getScoreATrigger = 'b0;
        getScoreBTrigger = 'b0;
        scoreA = 'b0;
        scoreB = 'b0;
    end
    always @(posedge CLK) 
    begin
        if(getScoreATrigger == 'b0 && getScoreA == 'b1)
            scoreA ++;
        if(getScoreBTrigger == 'b0 && getScoreB == 'b1)
            scoreB ++;

        getScoreATrigger = getScoreA;
        getScoreBTrigger = getScoreB;
        
        if(scoreA + scoreB > 'd5)
            serviceSide = 'b1;
        if(scoreA + scoreB == 'd11)
            endGame = 'b1;

        if(endGame == 1) begin
            if(scoreA < scoreB)
            winner = 'b10;
            else if(scoreA > scoreB)
            winner = 'b01;
            else
            winner = 'b00;
        end
    end

endmodule
