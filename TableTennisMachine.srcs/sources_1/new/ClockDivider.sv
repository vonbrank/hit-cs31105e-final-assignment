`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/28 09:22:20
// Design Name: 
// Module Name: ClockDivider
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


module ClockDivider(originCLK, dividedCLK);
    input originCLK;
    output dividedCLK;
    reg tempDivCLK;
    reg [31: 0] count;
    reg [31: 0] ratio = 'd2;
    // reg [31: 0] ratio = 'd100_000;
    initial begin
        tempDivCLK = 'b0;
        count = 'd0;
    end
    always @(posedge originCLK) begin
        count = count + 1;
        if(count == ratio)
            count = 'd0;
        
        if(count == 'd0) 
            tempDivCLK = 'b0;
        if(count == ratio / 2) 
            tempDivCLK = 'b1;

    end
    assign dividedCLK = tempDivCLK;
endmodule
