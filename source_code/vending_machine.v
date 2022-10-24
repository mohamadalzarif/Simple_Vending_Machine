`timescale 1ns / 1ps

//Assumption for coins combinations are: user will enter 3*5 cents (no money remaining)
// user will enter 2*10 cents(5 cent remaining)
// user will enter 1*5 cents and 1* 10 cents (no money remaining)


//coin_in_en: enable, active high, 1, when user enters coin
//coin_val: when 0 user enters 5 cent, when 1 user enters 10 cent
//pencil_out: when 1 pencil will be out from the vending machine
//extra_money: when 1 pencil will return 5 cent for the user as remaining money

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
