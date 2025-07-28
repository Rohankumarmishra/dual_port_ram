// Dual Port RAM testbench
`include "dual_port_sync_ram.v"
`timescale 1ns/1ps

module dual_port_sync_ram_tb;
  reg [7:0] data_in_a, data_in_b; //input data
  reg [5:0] addr_a, addr_b; //Port A and Port B address
  reg wr_a, wr_b; //write enable for Port A and Port B
  reg clk; //clk
  wire [7:0] data_out_a, data_out_b; //output data at Port A and Port B
  
  dual_port_sync_ram dpr1(
    .data_in_a(data_in_a),
    .data_in_b(data_in_b),
    .addr_a(addr_a),
    .addr_b(addr_b),
    .wr_a(wr_a),
    .wr_b(wr_b),
    .clk(clk),
    .data_out_a(data_out_a),
    .data_out_b(data_out_b)
  );
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1, dual_port_sync_ram_tb);       
      
      clk=1'b1;
      forever #5 clk = ~clk;
    end
  
  initial
    begin
      data_in_a = 8'h33;
      addr_a = 6'h01;
      
      data_in_b = 8'h44;
      addr_b = 6'h02;
      
      wr_a = 1'b1;
      wr_b = 1'b1;
      
      #10;
      
      data_in_a = 8'h55;
      addr_a = 6'h03;
      
      addr_b = 6'h01;
      
      wr_b = 1'b0;
      
      #10;          
            
      addr_a = 6'h02;
      
      addr_b = 6'h03;
      
      wr_a = 1'b0;
      
      #10;
      
      addr_a = 6'h01;
      
      data_in_b = 8'h77;
      addr_b = 6'h02;
      
      wr_b = 1'b1;
      
      #10;
    end
  
  initial	
    #40 $stop;
  
endmodule