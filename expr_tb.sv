`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2025 14:54:23
// Design Name: 
// Module Name: expr_tb
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


module unit_tb;

    parameter WIDTH = 16;

    logic clk;
    logic rst;
    logic valid_in;
    logic signed [WIDTH-1:0] a, b, c, d;
    logic valid_out;
    logic signed [2*WIDTH-1:0] Q;

    unit #(.WIDTH(WIDTH)) dut (
        .clk(clk),
        .rst(rst),
        .valid_in(valid_in),
        .a(a), .b(b), .c(c), .d(d),
        .valid_out(valid_out),
        .Q(Q)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    function automatic logic signed [WIDTH-1:0] rand_signed();
        int unsigned raw;
        raw = $urandom;
        return raw[WIDTH-1:0];
    endfunction

    initial begin
        rst = 1;
        valid_in = 0;
        a = 0; b = 0; c = 0; d = 0;

        #12;
        rst = 0;

        @(posedge clk);
        valid_in = 1;
        a = 10; b = 3; c = 1; d = 2;

        @(posedge clk);
        valid_in = 0;

        @(posedge clk);

        @(posedge clk);
        valid_in = 1;
        a = -5; b = 2; c = -1; d = 4;

        @(posedge clk);
        valid_in = 0;

        @(posedge clk);

        @(posedge clk);
        valid_in = 1;
        a = rand_signed();
        b = rand_signed();
        c = rand_signed();
        d = rand_signed();

        @(posedge clk);
        valid_in = 0;

        repeat (10) @(posedge clk);

        $finish;
    end

endmodule
