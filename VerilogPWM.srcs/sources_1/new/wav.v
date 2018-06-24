`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Justin Schwausch
// Class: ECE 3331
// Project: 100hz mini project
// Target: Basys 3 Board
// Last Modified: 6/22/2018
//
// This program creates a 100hz square wave output with a duty cycle dictated by the dip switches.
// To adjust the duty cycle, use SW0-SW9 on the Basys 3 board to input the binary equivelant of the
//  desired duty cycle.
//////////////////////////////////////////////////////////////////////////////////
module wav(out, clk, clk100, clk100k, sw);

    output out; //output pin
    input clk; //input 100 MHz base clock
    input clk100; //input 100 Hz sub clock
    input clk100k; //input 100 KHz sub clock
    input [9:0]sw; //input dip switches
    
    reg lineout = 1'b0; //internal registry for output wave
    reg count = 1'b0; //should it be counting
    reg clk1 = 1'b0; //used to create a one tick pulse for set
    reg set = 1'b0; //used to set rising edge of output wave
    reg[10:0] duty = 11'b0000000000; //stores current duty cycle
    reg[10:0] counter = 11'b0000000000; //counting register
    
    assign out = lineout; //assign output pin to lineout reg
    
    always @(posedge clk100k) //used to alter the duty cycle based off of counter
    begin
    
        if(lineout == 1'b1)
        begin
        counter <= counter + 1'b1; //increase counter
        end
        
        
        if(lineout == 1'b0) //when counter hits 0
        begin
            counter <= 10'b0000000000; //reset counter
        end 
        
    end
    
    always @(posedge clk)
    begin
    
    if(clk100 == 1'b1) //if 100 Hz clock is high
    clk1 <= 1'b1; //set clk1 to high
    
    if(clk100 == 1'b0) //if 100 Hz clock is low
    clk1 <= 1'b0; //set clk1 to low
    
    end
    
    always @(posedge clk) //sends pulse to begin counting and output
    begin
    
    if(clk100 == 1'b1 && clk1 == 1'b0) //if in one tick between 100 Hz going high and clk1 going high
    begin
    set <= 1'b1; //set set to high
    end
    
    if(clk100 == 1'b1 && clk1 == 1'b1) //once both clk100 and clk1 are high
    begin
    set <= 1'b0; //set set to low
    end
    
    end
  
    always @(posedge clk) //controls output
    begin
        
        if(set == 1'b1) //when set is high
        begin
        lineout <= 1'b1; //set output to high
        duty <= sw + sw; //load switch values into duty for counting
        count <= 1'b1; //start counting
        end
        
        else if(counter == duty) //if counting is done
        begin
        lineout <= 1'b0; //set output to low
        count <= 1'b0; //stop counting
        end
           
    end
        
endmodule