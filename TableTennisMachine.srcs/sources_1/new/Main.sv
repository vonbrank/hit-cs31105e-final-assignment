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
    output wire [7: 0] ballLocation,
    output wire [7:0] LED0, 
    output wire [7:0] LED1, 
    output wire [7:0] LEDBit
    );


    wire [2: 0] status;
    wire dividedCLK;
    wire [1: 0] speedOutA;
    wire [1: 0] speedOutB;
    wire getScoreA, getScoreB;
    ClockDivider clockDivider(CLK, dividedCLK);
    wire serviceSide;

    // wire hitOutA, hitOutB, speedOuta, speedOutB;

    Player player1(dividedCLK, 'b1, hitA, speedA, hitOutA, speedOutA);
    Player player2(dividedCLK, 'b1, hitB, speedB, hitOutB, speedOutB);

    GameController gameController(
        dividedCLK, 
        hitOutA, 
        speedOutA, 
        hitOutB, 
        speedOutB, 
        serviceSide,
        status, 
        ballLocation, 
        getScoreA, 
        getScoreB
        
    );

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

    reg [7:0][7:0] dataIn;

    reg [31:0] count;
    initial begin 
        count = 'd0;
        while(count < 8) begin
            dataIn[count] = 'd100;
            count ++;
        end
        count = 'd0;
    end

    DigitalTubeDriver digitalTubeDriver(dividedCLK, dataIn, LED0, LED1, LEDBit);

    
    wire endGame;
    wire [1:0] winner;
    wire [15: 0] scoreA;
    wire [15: 0] scoreB;

    ScoreBoard scoreBoard(
        dividedCLK, 
        getScoreA, 
        getScoreB, 
        serviceSide, 
        endGame, 
        winner, 
        scoreA, 
        scoreB
    );


    reg [7:0] i;
    reg [7:0] j;
    reg [31:0] countTemp;
    reg [31:0] countTemp2;

    always @(posedge dividedCLK) begin
        if('d1 == 'd1) begin
            i = 'd0;
            // count += 1;
            countTemp = scoreB;
            while(countTemp > 0 && i < 'd2) begin
                dataIn[i] = countTemp % 'd10;
                countTemp /= 'd10;
                i++;
            end

            j = 'd6;
            // count += 1;
            countTemp2 = scoreA;
            while(countTemp2 > 0 && j < 'd8) begin
                dataIn[j] = countTemp2 % 'd10;
                countTemp2 /= 'd10;
                j++;
            end
        end


    end


endmodule
