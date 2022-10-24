`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2022 11:09:32 PM
// Design Name: 
// Module Name: vending_machine
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


module vending_machine(input clk, reset, coin_in_en, coin_val, output reg pencil_out,output reg [2:0] extra_money

    );
    reg [2:0] state ,nextstate;
    wire [2:0] idle = 0;
    wire [2:0] five = 1;
    wire [2:0] ten = 2;
    wire [2:0] fifteen = 3;
    wire [2:0] twenty = 4;
    
    always@(posedge clk or posedge reset)
    begin
    if(reset) 
    state = idle;
    else 
    state=nextstate;
    end
    
    always@(*)
    begin
    case(state)
    
    
    idle: begin
    pencil_out = 0;
    extra_money = 0;
    if(coin_in_en)
    case(coin_val)
    0: nextstate = five;
    1: nextstate = ten;
    default: nextstate=idle;
    endcase
    else nextstate = idle;
    end
    
    five: begin
        pencil_out = 0;
        extra_money = 0;
        if(coin_in_en)
        case(coin_val)
        0: nextstate = ten;
        1: nextstate = fifteen;
        default: nextstate=five;
        endcase
        else nextstate = five;
        end
        
     ten: begin
            pencil_out = 0;
            extra_money = 0;
            if(coin_in_en)
            case(coin_val)
            0: nextstate = fifteen;
            1: nextstate = twenty;
            default: nextstate=ten;
            endcase
            else nextstate = ten;
            end
            
      fifteen: begin
                pencil_out = 1;
                extra_money = 0;
                nextstate = idle;
                end
   twenty: begin
                                pencil_out = 1;
                                extra_money = 5;
                                nextstate = idle;
                                end
    default: begin
    pencil_out=0;
    extra_money=0;
    nextstate=idle;
    
    end
    
    endcase
    end
    
    
endmodule
