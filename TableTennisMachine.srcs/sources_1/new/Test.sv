`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/28 09:45:00
// Design Name: 
// Module Name: Test
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


module Test(
    input CLK, 
    input switchHit,
    input switchHit2,
    output wire [7:0] LED0, 
    output wire [7:0] LED1, 
    output wire [7:0] LEDBit
    );
    reg [7:0][7:0] dataIn;
    wire dividedCLK;

    reg [31:0] count;
    initial begin 
        count = 'd0;
        while(count < 8) begin
            dataIn[count] = 'd0;
            count ++;
        end
        count = 'd0;
    end

    ClockDivider clockDivider(CLK, dividedCLK);
    DigitalTubeDriver digitalTubeDriver(dividedCLK, dataIn, LED0, LED1, LEDBit);


    reg getScoreA;
    reg getScoreB;
    wire serviceSide;
    wire endGame;
    wire [1:0] winner;
    wire [15: 0] scoreA;
    wire [15: 0] scoreB;

    ScoreBoard scoreBoard(dividedCLK, switchHit, switchHit2, serviceSide, endGame, winner, scoreA, scoreB);


    reg switchHitTrigger;
    reg switchHit2Trigger;
    initial begin
        switchHitTrigger = 'd0;
        switchHit2Trigger = 'd0;
    end
    reg [7:0] i;
    reg [7:0] j;
    reg [31:0] countTemp;
    reg [31:0] countTemp2;

    always @(posedge dividedCLK) begin
        if('d1 == 'd1) begin
            i = 'd0;
            // count += 1;
            countTemp = scoreA;
            while(countTemp > 0 && i < 'd8) begin
                dataIn[i] = countTemp % 'd10;
                countTemp /= 'd10;
                i++;
            end

            j = 'd6;
            // count += 1;
            countTemp2 = scoreB;
            while(countTemp2 > 0 && j < 'd8) begin
                dataIn[j] = countTemp2 % 'd10;
                countTemp2 /= 'd10;
                j++;
            end
        end

        switchHitTrigger = switchHit;
    end

endmodule
