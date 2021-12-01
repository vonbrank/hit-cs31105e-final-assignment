`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/30 22:57:49
// Design Name: 
// Module Name: DigitalTubeDriver
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


module DigitalTubeDriver(
    input CLK, 
    input reg [7:0][7:0] dataIn, 
    output reg [7:0] LED0, 
    output reg [7:0] LED1, 
    output reg [7:0] LEDBit
    );

    reg [3:0] count;


    wire [7:0] data0;

    initial begin
        count = 'b00;
    end

    // assign LED1 = LED0;

    always @(posedge CLK) begin

        case(dataIn[count])
            'd0: LED0 = 'b00111111;
            'd1: LED0 = 'b00000110;
            'd2: LED0 = 'b01011011;
            'd3: LED0 = 'b01001111;
            'd4: LED0 = 'b01100110;
            'd5: LED0 = 'b01101101;
            'd6: LED0 = 'b01111101;
            'd7: LED0 = 'b00000111;
            'd8: LED0 = 'b01111111;
            'd9: LED0 = 'b01101111;
            default: LED0 = 'b11111111;
        endcase

        case(count)
            'd0: begin
                LEDBit = 'b10000000;
                count = 'd1;
            end
            'd1: begin 
                LEDBit = 'b01000000;
                count = 'd2;
            end 
            'd2: begin 
                LEDBit = 'b00100000;
                count = 'd3;
            end 
            'd3: begin 
                LEDBit = 'b00010000;
                count = 'd4;
            end 
            'd4: begin 
                LEDBit = 'b00001000;
                count = 'd5;
            end 
            'd5: begin 
                LEDBit = 'b00000100;
                count = 'd6;
            end 
            'd6: begin 
                LEDBit = 'b00000010;
                count = 'd7;
            end 
            'd7: begin 
                LEDBit = 'b00000001;
                count = 'd0;
            end 
            default: count = 'd0;
        endcase

        LED1 = LED0;

    end

endmodule
