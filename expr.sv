`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2025 14:54:02
// Design Name: 
// Module Name: expr
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


module unit #(
    parameter WIDTH = 16
)(
    input logic clk,
    input logic rst,
    input logic valid_in,
    input logic signed [WIDTH-1:0] a,
    input logic signed [WIDTH-1:0] b,
    input logic signed [WIDTH-1:0] c,
    input logic signed [WIDTH-1:0] d,
    output logic valid_out,
    output logic signed [2*WIDTH-1:0] Q
);

    logic signed [WIDTH-1:0] a_ff, b_ff, c_ff, d_ff;
    logic signed [WIDTH-1:0] diff, sum1;
    logic signed [2*WIDTH-1:0] mult, sum2, sub;

    logic signed [WIDTH-1:0] diff_ff, sum1_ff;
    logic signed [2*WIDTH-1:0] mult_ff, sum2_ff, sub_ff;

    logic valid_stage1, valid_stage2, valid_stage3;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            a_ff <= 0;
            b_ff <= 0;
            c_ff <= 0;
            d_ff <= 0;
        end else if (valid_in) begin
            a_ff <= a;
            b_ff <= b;
            c_ff <= c;
            d_ff <= d;
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            valid_stage1 <= 0;
        else
            valid_stage1 <= valid_in;
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            valid_stage2 <= 0;
        else
            valid_stage2 <= valid_stage1;
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            valid_stage3 <= 0;
        else
            valid_stage3 <= valid_stage2;
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            valid_out <= 0;
        else
            valid_out <= valid_stage3;
    end

    always_ff @(posedge clk) begin
        if (valid_stage1) begin
            diff_ff <= a_ff - b_ff;
            sum1_ff <= 1 + 3 * c_ff;
        end
    end

    always_ff @(posedge clk) begin
        if (valid_stage2) begin
            mult_ff <= diff_ff * sum1_ff;
            sum2_ff <= 4 * d_ff;
        end    
    end

    always_ff @(posedge clk) begin
        if (valid_stage3) begin
            sub_ff <= mult_ff - sum2_ff;
        end    
    end

    always_ff @(posedge clk) begin
        if (valid_out) begin
            Q <= sub_ff >>> 1;
        end    
    end

endmodule


