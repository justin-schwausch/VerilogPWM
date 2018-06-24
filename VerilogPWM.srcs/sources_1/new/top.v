`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Justin Schwausch
// Class: ECE 3331
// Project: 100hz mini project
// Target: Basys 3 Board
// Last Modified: 6/22/2018
//
// This program creates a 100hz square wave output with a duty cycle dictated by the dip switches.
// To adjust the duty cycle, use SW0-SW6 on the Basys 3 board to input the binary equivelant of the
//  desired duty cycle.
//
// This top module facilitates the clk_divider and wav modules.
//////////////////////////////////////////////////////////////////////////////////
module top(JB, LED, clk, sw);

    output[0:3] JB; //output pin
    output[0:4] LED; //output for LEDs
    input clk; //main clock
    input [9:0]sw; //dip switches
    
    wire clk100; //wires to move signals around
    wire clk100k;
    wire lineout;
    
    assign JB[0] = lineout; //assign variables to hardware outputs
    assign JB[1] = clk100;
    assign JB[2] = clk100k;
    assign JB[3] = clk;
    
    assign LED[0] = lineout; //assign variables to LEDs
    assign LED[1] = 1'b1; //high to compare brightness to output
    assign LED[2] = clk100;
    assign LED[3] = clk100k;
    assign LED[4] = clk;
      
    clk_divider Uclk_divider ( //uses module to create the sub clocks
    
    .clk    (clk), //input main clock
    .clk100 (clk100), //output 100 Hz clock
    .clk100k (clk100k) //output 100 KHz clock
     );
     
     wav Uwav(
     
     .out     (lineout), //output
     .clk     (clk), //main clock
     .clk100  (clk100), //100 Hz clock
     .clk100k (clk100k), //100 KHz clock
     .sw      (sw) //switch inputs
     );
    
endmodule