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
    input reset,
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

    reg EnA;
    reg EnB;
    initial begin
        EnA = 'b1;
        EnB = 'b1;
    end
    // wire hitOutA, hitOutB, speedOuta, speedOutB;

    Player player1(dividedCLK, EnA, hitA, speedA, hitOutA, speedOutA);
    Player player2(dividedCLK, EnB, hitB, speedB, hitOutB, speedOutB);

    GameController gameController(  //调用全局状态控制器
        dividedCLK, 
        hitOutA, 
        speedOutA, 
        hitOutB, 
        speedOutB, 
        serviceSide,
        reset,
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

    DigitalTubeDriver digitalTubeDriver(    //调用数码管驱动
        dividedCLK, 
        dataIn, 
        LED0, 
        LED1, 
        LEDBit
    );

    
    wire endGame;
    wire [1:0] winner;
    wire [15: 0] scoreA;
    wire [15: 0] scoreB;

    ScoreBoard scoreBoard(
        dividedCLK, 
        getScoreA, 
        getScoreB, 
        reset,
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
    reg resetTrigger;
    reg [31: 0] flowLightCount;
    reg endGameTrigger;
    initial begin
        resetTrigger = 'b0;
        flowLightCount = 'd0;
        endGameTrigger = 'd0;
    end

    always @(posedge dividedCLK) begin
        
        if(resetTrigger == 'b0 && reset == 'b1) begin
            EnA = 'b1;
            EnB = 'b1;
            dataIn[2] = 'd100;
            dataIn[3] = 'd100;
            dataIn[4] = 'd100;
            dataIn[5] = 'd100;
            endGameTrigger = 'd0;
        end
        resetTrigger = reset;

    
        i = 'd0;
        // count += 1;
        countTemp = scoreB;
        while(i < 'd2) begin
            dataIn[i] = countTemp % 'd10;
            countTemp /= 'd10;
            i++;
        end
        

        j = 'd6;
        // count += 1;
        countTemp2 = scoreA;
        while(j < 'd8) begin
            dataIn[j] = countTemp2 % 'd10;
            countTemp2 /= 'd10;
            j++;
        end
        
        if(endGame == 'b1) begin    //游戏结束时显示箭头指向赢的玩家
            if(endGameTrigger == 'b0) begin
                EnA = 'b0;
                EnB = 'b0;
            end

            if(winner == 'b10) begin
                case(flowLightCount)
                    'd100: dataIn[2] = 'd22;
                    'd200: dataIn[3] = 'd22;
                    'd300: dataIn[4] = 'd22;
                    'd400: dataIn[5] = 'd22;
                endcase
                flowLightCount++;
                if(flowLightCount == 'd500) begin
                    flowLightCount = 'd0;
                    dataIn[2] = 'd100;
                    dataIn[3] = 'd100;
                    dataIn[4] = 'd100;
                    dataIn[5] = 'd100;
                end 
            end
            else begin
                case(flowLightCount)
                    'd100: dataIn[5] = 'd21;
                    'd200: dataIn[4] = 'd21;
                    'd300: dataIn[3] = 'd21;
                    'd400: dataIn[2] = 'd21;
                endcase
                flowLightCount++;
                if(flowLightCount == 'd500) begin
                    flowLightCount = 'd0;
                    dataIn[2] = 'd100;
                    dataIn[3] = 'd100;
                    dataIn[4] = 'd100;
                    dataIn[5] = 'd100;
                end 
            end
        end

        endGameTrigger = endGame;

    end


endmodule
