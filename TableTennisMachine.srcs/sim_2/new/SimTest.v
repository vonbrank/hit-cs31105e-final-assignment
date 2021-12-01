
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/28 10:54:43
// Design Name: 
// Module Name: SimMain
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


module SimMain();

    parameter CLK_CYCLE = 4;

    reg CLK;
    reg switchHit;
    reg switchHit2;
    wire [7:0] LED0;
    wire [7:0] LED1;
    wire [7:0] LEDBit;


    initial begin 
        CLK = 'b0;
        switchHit = 'b0;
        switchHit2 = 'b0;
    end

    always #(CLK_CYCLE/2) CLK = ~CLK;

    // wire [2: 0] status;

    Test test(
        CLK,
        switchHit,
        switchHit2,
        LED0,
        LED1,
        LEDBit
    );

    initial begin 
        switchHit = 'b0;
        #200;

        switchHit = ~switchHit;

        #50 
        switchHit = ~switchHit;

        #50 
        switchHit = ~switchHit;

        #50 
        switchHit = ~switchHit;

        #50 
        switchHit = ~switchHit;

        #50 
        switchHit = ~switchHit;

        #50 
        switchHit = ~switchHit;

        #50 
        switchHit = ~switchHit;

        #50 
        switchHit = ~switchHit;
    end

endmodule
