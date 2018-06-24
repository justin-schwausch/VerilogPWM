`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Name: Justin Schwausch
// Class: ECE 3331
// Project: Clock dividers
// Target: Basys 3 Board
// Last Modified: 6/10/2018
//
// This program takes in the 100mhz main clock of the Basys 3 board and divides it into sub clocks.
// The frequency of the sub clocks can be changed by adjusting their divisors.
// This module can be modified to add more sub clocks as needed.
//
// The formula for the divider is: (The Base Clock) / (The Desired Frequency) = (The Divider)
//
// The current configuration outputs one 100hz clock, and 10khz clock.
//////////////////////////////////////////////////////////////////////////////////


module clk_divider(

    input clk, //take in main clock
    output clk100, //100 Hz clock
    output clk100k //102,300 Hz clock

    );
    
    
    reg[19:0] counter1 = 0; //register to hold counter for first sub clock
    reg[19:0] divisor1 = 1000000; //divisor for first sub clock
    reg[18:0] half1 = 500000;
    assign clk100 = (counter1 < half1) ?1'b0:1'b1;//set the output to 0 or 1 depending on the value of counter
        
    reg[9:0] counter2 = 0; //register and divisor for second sub clock
    reg[9:0] divisor2 = 1000;
    reg[8:0] half2 = 500;  
    assign clk100k = (counter2 < half2) ?1'b0:1'b1;

    
    
    always @(posedge clk) //code for first sub clock
    begin
   
    counter1 <= counter1 + 1; //increase the counter
    if(counter1 >= divisor1) //check if counter is at divisor yet
    counter1 <= 0; //reset counter
    end
    
    always @(posedge clk) //code for second sub clock is almost identical to firt sub clock, only different variable names
    begin
    
    counter2 <= counter2 + 1;
    if(counter2 >= divisor2)
    counter2 <= 0;
    end
        
endmodule