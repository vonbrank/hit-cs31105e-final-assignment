`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/28 09:21:30
// Design Name: 
// Module Name: Player
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


module Player(CLK, EN, hit, speed, hitOut, speedOut);
    input CLK, EN, hit, speed;
    output reg hitOut;
    output reg [1: 0] speedOut;
    // assign speedOut = speed;

    // reg [31: 0] activeInterval = 'd0;
    reg [31: 0] activeInterval = 'd1000;    //一个下降沿到下一个上升沿直接最小时间间隔

    reg [31: 0] interval;
    reg hitTrigger;
 
    initial begin
        interval = 'd0;
        hitTrigger = 'b0;
        hitOut = 'b0;
        speedOut = 'b1;
    end


    always @(posedge CLK) begin
        if(EN == 'b1) begin
            if(hitTrigger =='b0 && hit == 'b1) begin
                if(interval >= activeInterval) begin
                    hitOut = hit;
                end
            end
            else if(hitTrigger == 'b1 && hit == 'b0) begin
                interval = 'd0;
                hitOut = hit;
            end
            hitTrigger = hit;
            interval += 1;

            if(speed == 'b0) begin
                speedOut = 'd00;
            end
            else begin
                speedOut = 'd01;
            end
        end

    end


endmodule
