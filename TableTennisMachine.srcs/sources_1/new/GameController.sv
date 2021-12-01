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


module GameController(
    input CLK, 
    input reg hitA, 
    input [1: 0] speedA, 
    input reg hitB, 
    input [1: 0] speedB, 
    input reg serviceSide,
    output reg [2: 0] status, 
    output reg [7: 0] ballLocation, 
    output reg getScoreA, 
    output reg getScoreB
    );

    reg hitATrigger;
    reg hitBTrigger;
    reg [2: 0] speed;
    reg [15: 0] accurateBallLocation;
    // reg serviceSide;


    initial begin
        hitATrigger = 'b0;
        hitBTrigger = 'b0;
        status = 'b010;
        accurateBallLocation = 'd2000;
        speed = 'd2;
        // serviceSide = 'b0;

        getScoreA = 'b0;
        getScoreB = 'b0;
    end



    always @(posedge CLK) begin 

        if(status == 'b010 || status == 'b001) begin
            status = serviceSide == 'b0 ? 'b010 : 'b001;
            getScoreA = 'b0;
            getScoreB = 'b0;
        end

        if(status == 'b010) begin //A发球

            accurateBallLocation = 'd2000;

            if(hitATrigger == 'b0 && hitA == 'b1) begin
                status = 'b101;
                if(speedA == 'd00) speed = 'd2;
                else speed = 'd4;
            end 
            hitATrigger = hitA;



        end
        else if(status == 'b001) begin //B发球

            accurateBallLocation = 'd10000;

            if(hitBTrigger == 'b0 && hitB == 'b1) begin
                status = 'b110;
                if(speedB == 'd00) speed = 'd2;
                else speed = 'd4;
            end 
            hitBTrigger = hitB;


        end
        else if(status == 'b110) begin //A接球
            if(hitATrigger == 'b0 && hitA == 'b1) begin
                if(accurateBallLocation >= 'd1000 && accurateBallLocation <= 'd3000) begin
                    status = 'b101;
                    if(speedA == 'd00) speed = 'd2;
                    else speed = 'd4;
                end 
            end 
            hitATrigger = hitA;

            if(accurateBallLocation < 'd500) begin
                getScoreB = 'b1;
                status = serviceSide == 'b0 ? 'b010 : 'b001;
            end 

            accurateBallLocation -= speed * 'd2;

        end
        else if(status == 'b101) begin //B接球
            if(hitBTrigger == 'b0 && hitB == 'b1) begin
                if(accurateBallLocation >= 'd9000 && accurateBallLocation <= 'd11000) begin
                    status = 'b110;
                    if(speedB == 'd00) speed = 'd2;
                    else speed = 'd4;
                end 
            end 
            hitBTrigger = hitB;

            if(accurateBallLocation >'d11500) begin 
                getScoreA = 'b1;
                status = serviceSide == 'b0 ? 'b010 : 'b001;
            end 

            accurateBallLocation += speed * 'd2;

        end

        

        if(accurateBallLocation >= 'd2000 && accurateBallLocation < 'd3000) ballLocation = 'b10000000;
        if(accurateBallLocation >= 'd3000 && accurateBallLocation < 'd4000) ballLocation = 'b01000000;
        if(accurateBallLocation >= 'd4000 && accurateBallLocation < 'd5000) ballLocation = 'b00100000;
        if(accurateBallLocation >= 'd5000 && accurateBallLocation < 'd6000) ballLocation = 'b00010000;
        if(accurateBallLocation >= 'd6000 && accurateBallLocation < 'd7000) ballLocation = 'b00001000;
        if(accurateBallLocation >= 'd7000 && accurateBallLocation < 'd8000) ballLocation = 'b00000100;
        if(accurateBallLocation >= 'd8000 && accurateBallLocation < 'd9000) ballLocation = 'b00000010;
        if(accurateBallLocation >= 'd9000 && accurateBallLocation <= 'd10000) ballLocation = 'b00000001;

    end


endmodule
