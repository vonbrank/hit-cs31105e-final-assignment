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


module DigitalTubeDriver(   //数码管驱动
    input CLK, 
    input reg [7:0][7:0] dataIn,    //输入数据
    output reg [7:0] LED0,  //输出的LED0，管理前4位显示
    output reg [7:0] LED1,  //输出的LED1，管理后4位显示
    output reg [7:0] LEDBit //LEDBIT，管理每个亮或不亮
    );

    reg [3:0] count;


    wire [7:0] data0;

    initial begin
        LEDBit = 'b00000001;
        count = 'd0;
    end

    // assign LED1 = LED0;

    always @(posedge CLK) begin

        case(dataIn[count]) //检查每种数字或符号对应亮哪些边
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
            'd21: LED0 = 'b01110000;
            'd22: LED0 = 'b01000110;
            default: LED0 = 'b00000000;
        endcase

        if(count == 'd7) begin
            count = 'd0;
            LEDBit = 'b00000001;
        end
        else if(count == 'd0) begin
            LEDBit = 'b10000000;
            count = 'd1;
        end
        else begin
            count++;
            LEDBit = LEDBit >> 1;
        end
        LED1 = LED0;

    end

endmodule
