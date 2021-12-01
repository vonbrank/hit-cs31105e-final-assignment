`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/30 23:07:54
// Design Name: 
// Module Name: SingleTubeDecoder
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


module SingleTubeDecoder(dataIn, dataOut);
    input reg [7:0] dataIn;
    output reg [7:0] dataOut;

    always @(*) begin
        if(dataIn == 'd0) dataOut = 'b00111111;
        else if(dataIn == 'd1) dataOut = 'b00000110;
        else if(dataIn == 'd2) dataOut = 'b01011011;
        else if(dataIn == 'd3) dataOut = 'b01001111;
        else if(dataIn == 'd4) dataOut = 'b01100110;
        else if(dataIn == 'd5) dataOut = 'b00000000;
        else if(dataIn == 'd6) dataOut = 'b00000000;
        else if(dataIn == 'd7) dataOut = 'b00000000;
        else if(dataIn == 'd8) dataOut = 'b00000000;
        else if(dataIn == 'd9) dataOut = 'b00000000;
        else if(dataIn == 'd10) dataOut = 'b00000000;
        else if(dataIn == 'd11) dataOut = 'b00000000;
        else if(dataIn == 'd12) dataOut = 'b00000000;
        else if(dataIn == 'd13) dataOut = 'b00000000;
        else if(dataIn == 'd14) dataOut = 'b00000000;
        else if(dataIn == 'd15) dataOut = 'b00000000;
        else dataOut = 'b11111111;
    end

endmodule
