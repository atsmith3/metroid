//-------------------------------------------------------------------------
//      test_memory.vhd                                                  --
//      Stephen Kempf                                                    --
//      Summer 2005                                                      --
//                                                                       --
//      Revised 3-15-2006                                                --
//              3-22-2007                                                --
//              7-26-2013                                                --
//                                                                       --
//      For use with ECE 385 Experment 6                                 --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------

// This memory has similar behavior to the SRAM IC on the DE2 board.  This
// file should be used for simulations only.  In simulation, this memory is
// guaranteed to work at least as well as the actual memory (that is, the
// actual memory may require more careful treatment than this test memory).

// To use, you should create a seperate top-level entity for simulation
// that connects this memory module to your computer.  You can create this
// extra entity either in the same project (temporarily setting it to be the
// top module) or in a new one, and create a new vector waveform file for it.

module test_memory ( input 			Clk,
							input          Reset, 
                     inout  [15:0]  I_O,
                     input  [19:0]  A,
                     input          CE,
                                    UB,
                                    LB,
                                    OE,
                                    WE );
												
   parameter size = 256; // expand memory as needed (current is 64 words)
	 
   logic [15:0] mem_array [size-1:0];
   logic [15:0] mem_out;
   logic [15:0] I_O_wire;
	
	// For memory mapped IO:
	logic [5:0] outHEX, inSW;
	assign inSW =   6'hFF;
	assign outHEX = 6'hFF;
	
   assign mem_out = mem_array[A[7:0]];  //ATTENTION: Size here must correspond to size of
              // memory vector above.  Current size is 64, so the slice must be 6 bits.  If size were 1024,
              // slice would have to be 10 bits.  (There are three more places below where values must stay
              // consistent as well.)
	 
   always_comb
   begin
      I_O_wire = 16'bZZZZZZZZZZZZZZZZ;

      if (~CE && ~OE && WE) begin
         if (~UB)
            I_O_wire[15:8] = mem_out[15:8];
				
         if (~LB)
            I_O_wire[7:0] = mem_out[7:0];
		end
   end
  
   always_ff @ (posedge Clk or posedge Reset)
   begin
		if(Reset)   // Insert initial memory contents here
		begin
mem_array[   0 ] <=    16'h0000;   
mem_array[   1 ] <=    16'h0001;
mem_array[   2 ] <=    16'h0002;                                       
mem_array[   3 ] <=    16'h0003;
mem_array[   4 ] <=    16'h0004;
mem_array[   5 ] <=    16'h0005;                                         
mem_array[   6 ] <=    16'h0006;
mem_array[   7 ] <=    16'h0007;
mem_array[   8 ] <=    16'h0008;
mem_array[   9 ] <=    16'h0009;
mem_array[  10 ] <=    16'h000a;                                             
mem_array[  11 ] <=    16'h000b;
mem_array[  12 ] <=    16'h000c;
mem_array[  13 ] <=    16'h000d;
mem_array[  14 ] <=    16'h000e;
mem_array[  15 ] <=    16'h000f;
mem_array[  16 ] <=    16'h0010;
mem_array[  17 ] <=    16'h0011;
mem_array[  18 ] <=    16'h0012;
mem_array[  19 ] <=    16'h0013;                       
mem_array[  20 ] <=    16'h0014;
mem_array[  21 ] <=    16'h0015;
mem_array[  22 ] <=    16'h0016;
mem_array[  23 ] <=    16'h0017;
mem_array[  24 ] <=    16'h0018;
mem_array[  25 ] <=    16'h0019;
mem_array[  26 ] <=    16'h001a;
mem_array[  27 ] <=    16'h001b;
mem_array[  28 ] <=    16'h001c;
mem_array[  29 ] <=    16'h001d;
mem_array[  30 ] <=    16'h001e;
mem_array[  31 ] <=    16'h001f;
mem_array[  32 ] <=    16'h0020;
mem_array[  33 ] <=    16'h0021;
mem_array[  34 ] <=    16'h0022;
mem_array[  35 ] <=    16'h0023;
mem_array[  36 ] <=    16'h0024;
mem_array[  37 ] <=    16'h0025;
mem_array[  38 ] <=    16'h0026;
mem_array[  39 ] <=    16'h0027;
mem_array[  40 ] <=    16'h0028;
mem_array[  41 ] <=    16'h0029;                     
mem_array[  42 ] <=    16'h002a;
mem_array[  43 ] <=    16'h002b;
mem_array[  44 ] <=    16'h002c;
mem_array[  45 ] <=    16'h002d;
mem_array[  46 ] <=    16'h002e;
mem_array[  47 ] <=    16'h002f;
mem_array[  48 ] <=    16'h0030;                     
mem_array[  49 ] <=    16'h0031;
mem_array[  50 ] <=    16'h0032;
mem_array[  51 ] <=    16'h0033;
mem_array[  52 ] <=    16'h0034;
mem_array[  53 ] <=    16'h0035;
mem_array[  54 ] <=    16'h0036;
mem_array[  55 ] <=    16'h0037;
mem_array[  56 ] <=    16'h0038;
mem_array[  57 ] <=    16'h0039;
mem_array[  58 ] <=    16'h003a;
mem_array[  59 ] <=    16'h003b;
mem_array[  60 ] <=    16'h000c;
mem_array[  61 ] <=    16'h003d;
mem_array[  62 ] <=    16'h003e;
mem_array[  63 ] <=    16'h003f;
mem_array[  64 ] <=    16'h0000;
mem_array[  65 ] <=    16'h0000;
mem_array[  66 ] <=    16'h0000;
mem_array[  67 ] <=    16'h0000;
mem_array[  68 ] <=    16'h0000;
mem_array[  69 ] <=    16'h0000;
mem_array[  70 ] <=    16'h0000;
mem_array[  71 ] <=    16'h0000;
mem_array[  72 ] <=    16'h0000;
mem_array[  73 ] <=    16'h0000;
mem_array[  74 ] <=    16'b0000;
mem_array[  75 ] <=    16'b0000;
mem_array[  76 ] <=    16'b0000;
mem_array[  77 ] <=    16'b0000;
mem_array[  78 ] <=    16'h0000;
mem_array[  79 ] <=    16'b0000;
mem_array[  80 ] <=    16'b0000;
mem_array[  81 ] <=    16'b0000;
mem_array[  82 ] <=    16'b0000;
mem_array[  83 ] <=    16'b0000;
mem_array[  84 ] <=    16'b0000;
mem_array[  85 ] <=    16'b0000;
mem_array[  86 ] <=    16'b0000;
mem_array[  87 ] <=    16'b0000;
mem_array[  88 ] <=    16'b0000;
mem_array[  89 ] <=    16'b0000;
mem_array[  90 ] <=    16'b0000;
mem_array[  91 ] <=    16'b0000;
mem_array[  92 ] <=    16'b0000;
mem_array[  93 ] <=    16'b0000;
mem_array[  94 ] <=    16'b0000;
mem_array[  95 ] <=    16'b0000;
mem_array[  96 ] <=    16'b0000;
mem_array[  97 ] <=    16'b0000;
mem_array[  98 ] <=    16'b0000;
mem_array[  99 ] <=    16'b0000;
mem_array[ 100 ] <=    16'b0000;
mem_array[ 101 ] <=    16'b0000;
mem_array[ 102 ] <=    16'b0000;
mem_array[ 103 ] <=    16'b0000;
mem_array[ 104 ] <=    16'b0000;
mem_array[ 105 ] <=    16'b0000;
mem_array[ 106 ] <=    16'b0000;
mem_array[ 107 ] <=    16'b0000;
mem_array[ 108 ] <=    16'b0000;
mem_array[ 109 ] <=    16'b0000;
mem_array[ 110 ] <=    16'b0000;
mem_array[ 111 ] <=    16'b0000;
mem_array[ 112 ] <=    16'b0000;
mem_array[ 113 ] <=    16'b0000;
mem_array[ 114 ] <=    16'b0000;
mem_array[ 115 ] <=    16'b0000;
mem_array[ 116 ] <=    16'b0000;
mem_array[ 117 ] <=    16'b0000;
mem_array[ 118 ] <=    16'b0000;
mem_array[ 119 ] <=    16'b0000;
mem_array[ 120 ] <=    16'b0000;
mem_array[ 121 ] <=    16'b0000;
mem_array[ 122 ] <=    16'b0000;
mem_array[ 123 ] <=    16'b0000;
mem_array[ 124 ] <=    16'b0000;
mem_array[ 125 ] <=    16'b0000;
mem_array[ 126 ] <=    16'b0000;
mem_array[ 127 ] <=    16'b0000;
mem_array[ 128 ] <=    16'b0000;
mem_array[ 129 ] <=    16'b0000;
mem_array[ 130 ] <=    16'b0000;
mem_array[ 131 ] <=    16'b0000;
mem_array[ 132 ] <=    16'b0000;
mem_array[ 133 ] <=    16'b0000;
mem_array[ 134 ] <=    16'b0000;
mem_array[ 135 ] <=    16'b0000;
mem_array[ 136 ] <=    16'b0000;
mem_array[ 137 ] <=    16'b0000;
mem_array[ 138 ] <=    16'b0000;
mem_array[ 139 ] <=    16'b0000;
mem_array[ 140 ] <=    16'b0000;
mem_array[ 141 ] <=    16'b0000;
mem_array[ 142 ] <=    16'b0000;
mem_array[ 143 ] <=    16'b0000;
mem_array[ 144 ] <=    16'b0000;
mem_array[ 145 ] <=    16'b0000;
mem_array[ 146 ] <=    16'b0000;
mem_array[ 147 ] <=    16'b0000;
mem_array[ 148 ] <=    16'b0000;
mem_array[ 149 ] <=    16'b0000;
mem_array[ 150 ] <=    16'b0000;
mem_array[ 151 ] <=    16'b0000;
mem_array[ 152 ] <=    16'b0000;
mem_array[ 153 ] <=    16'b0000;
mem_array[ 154 ] <=    16'b0000;
mem_array[ 155 ] <=    16'b0000;

			
			for (integer i = 156; i <= size - 1; i = i + 1)		// Assign the rest of the memory to 0
			begin
				mem_array[i] <= 16'h0;
			end
		end
		else if (~CE && ~WE && A[15:8]==8'b00000000)
		begin
          if(~UB)
			    mem_array[A[7:0]][15:8] <= I_O[15:8];   // A(15 downto X+1): X must
																	  // be the same as above
		    if(~LB)
			    mem_array[A[7:0]][7:0] <= I_O[7:0];     // A(X downto 0): X
		end                                            // must be the same as above

   end
	  
   assign I_O = I_O_wire;
	  
endmodule