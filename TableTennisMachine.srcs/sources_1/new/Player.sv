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
    output reg hitOut, speedOut;

    // assign speedOut = speed;

    reg [31: 0] activeInterval = 'd3000;
    // reg [31: 0] activeInterval = 'd3000;

    reg [31: 0] interval;
 
    initial begin
        interval = 'd0;
    end


    always @(posedge CLK) begin
        if(hit) interval = 'd0;
        else interval += 1;
    end
    
    always @(hit) begin
        if(EN) begin
            if(hit) begin 
                if(interval >= activeInterval)  hitOut = hit;
            end 
            else hitOut = hit;
            speedOut = speed;
        end
        else begin 
            hitOut = 'b0;
            speedOut = 'b0;
        end

    end

endmodule
