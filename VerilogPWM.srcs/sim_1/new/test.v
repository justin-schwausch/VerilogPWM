`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Justin Schwausch
// Class: ECE 3331
// Project: 100 Hz project
// Target: Basys 3 Board
// Last Modified: 6/10/2018
//
// This is the test code for the 100 Hz project.
//////////////////////////////////////////////////////////////////////////////////



module test(JB, LED); 
  
  output[3:0] JB;
  
  output[4:0] LED;
 
  reg clk;
  reg[9:0] sw = 10'b0000000000;
    
  top U0 ( 
  .JB    (JB),
  .LED   (LED),
  .clk   (clk),
  .sw    (sw)
  ); 
    
  initial 
  begin 
    clk = 0; //start clk at 0
  
  sw <= 10'b1111101000;
  
  #100000000
   
  sw = sw + 5'b10000; //keep changing the switches to iterate through input combinations
  
  end
    
  always 
    #5 clk = !clk; //simulate 100 MHz main clock
    
endmodule 
