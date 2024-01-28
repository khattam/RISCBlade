`timescale 1ns / 1ps

module ProgramCounter_TEST;

    // Inputs
    reg clock;
    reg reset;
    reg [15:0] jump_addr;
    reg jump_en;

    // Output
    wire [15:0] pc;

    // Instantiate the Unit Under Test (UUT)
    ProgramCounter uut (
        .clock(clock), 
        .reset(reset), 
        .jump_addr(jump_addr), 
        .jump_en(jump_en), 
        .pc(pc)
    );

    // Clock generation
    always #5 clock = ~clock;

    initial begin
        // Initialize Inputs
        clock = 0;
        reset = 0;
        jump_addr = 0;
        jump_en = 0;

        // Display initial state of PC
        #1; // Wait a moment for initialization
        $display("Initial PC value: %d", pc);

        // Reset the PC
        #10;
        reset = 1;
        $display("Resetting PC...");
        #10;
        reset = 0;
        $display("After reset, PC value: %d", pc);

        // Wait for a few clock cycles
        #100;
        $display("After normal operation, PC value: %d", pc);

        // Jump to a specific address
        jump_addr = 16'h0010;
        jump_en = 1;
        $display("Jumping to address %h", jump_addr);
        #10;
        jump_en = 0;
        $display("After jump, PC value: %d", pc);

        // Wait for a few more clock cycles
        #100;
        $display("Final PC value: %d", pc);

        $finish;
    end

endmodule
