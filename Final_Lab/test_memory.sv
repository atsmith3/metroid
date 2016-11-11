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
/*	  
   always_ff @ (posedge Clk or posedge Reset)
   begin
		if(Reset)   // Insert initial memory contents here
		begin
mem_array[   0 ] <=    
mem_array[   1 ] <=   
mem_array[   2 ] <=                                                          
mem_array[   3 ] <=    
mem_array[   4 ] <=   
mem_array[   5 ] <=                                                     
mem_array[   6 ] <=    
mem_array[   7 ] <=    
mem_array[   8 ] <=    
mem_array[   9 ] <=    
mem_array[  10 ] <=                                                          
mem_array[  11 ] <=    
mem_array[  12 ] <=    
mem_array[  13 ] <=    
mem_array[  14 ] <=    
mem_array[  15 ] <=    
mem_array[  16 ] <=    
mem_array[  17 ] <=    
mem_array[  18 ] <=    
mem_array[  19 ] <=                                    
mem_array[  20 ] <=    
mem_array[  21 ] <=    
mem_array[  22 ] <=   
mem_array[  23 ] <=    
mem_array[  24 ] <=    
mem_array[  25 ] <=    
mem_array[  26 ] <=   
mem_array[  27 ] <=    
mem_array[  28 ] <=    
mem_array[  29 ] <=    
mem_array[  30 ] <=    
mem_array[  31 ] <=    
mem_array[  32 ] <=    
mem_array[  33 ] <=    
mem_array[  34 ] <=    
mem_array[  35 ] <=    
mem_array[  36 ] <=    
mem_array[  37 ] <=    
mem_array[  38 ] <=    
mem_array[  39 ] <=    
mem_array[  40 ] <=    
mem_array[  41 ] <=                                  
mem_array[  42 ] <=    
mem_array[  43 ] <=    
mem_array[  44 ] <=    
mem_array[  45 ] <=    
mem_array[  46 ] <=    
mem_array[  47 ] <=    
mem_array[  48 ] <=                                  
mem_array[  49 ] <=    
mem_array[  50 ] <=    
mem_array[  51 ] <=    
mem_array[  52 ] <=    
mem_array[  53 ] <=    
mem_array[  54 ] <=    
mem_array[  55 ] <=    
mem_array[  56 ] <=    
mem_array[  57 ] <=    
mem_array[  58 ] <=    
mem_array[  59 ] <=    
mem_array[  60 ] <=    
mem_array[  61 ] <=    
mem_array[  62 ] <=    
mem_array[  63 ] <=    
mem_array[  64 ] <=    
mem_array[  65 ] <=    
mem_array[  66 ] <=    
mem_array[  67 ] <=    
mem_array[  68 ] <=    
mem_array[  69 ] <=    
mem_array[  70 ] <=    
mem_array[  71 ] <=    
mem_array[  72 ] <=    
mem_array[  73 ] <=    
mem_array[  74 ] <=    
mem_array[  75 ] <=    
mem_array[  76 ] <=    
mem_array[  77 ] <=    
mem_array[  78 ] <=    
mem_array[  79 ] <=    
mem_array[  80 ] <=       
mem_array[  81 ] <=         
mem_array[  82 ] <=      
mem_array[  83 ] <=    
mem_array[  84 ] <=    
mem_array[  85 ] <=    
mem_array[  86 ] <=    
mem_array[  87 ] <=    
mem_array[  88 ] <=    
mem_array[  89 ] <=    
mem_array[  90 ] <=    
mem_array[  91 ] <=    
mem_array[  92 ] <=    
mem_array[  93 ] <=    
mem_array[  94 ] <=    
mem_array[  95 ] <=    
mem_array[  96 ] <=    
mem_array[  97 ] <=    
mem_array[  98 ] <=    
mem_array[  99 ] <=    
mem_array[ 100 ] <=    
mem_array[ 101 ] <=    
mem_array[ 102 ] <=    
mem_array[ 103 ] <=    
mem_array[ 104 ] <=    
mem_array[ 105 ] <=    
mem_array[ 106 ] <=    
mem_array[ 107 ] <=    
mem_array[ 108 ] <=    
mem_array[ 109 ] <=    
mem_array[ 110 ] <=    
mem_array[ 111 ] <=    
mem_array[ 112 ] <=    
mem_array[ 113 ] <=    
mem_array[ 114 ] <=    
mem_array[ 115 ] <=    
mem_array[ 116 ] <=    
mem_array[ 117 ] <=    
mem_array[ 118 ] <=    
mem_array[ 119 ] <=    
mem_array[ 120 ] <=    
mem_array[ 121 ] <=    
mem_array[ 122 ] <=    
mem_array[ 123 ] <=    
mem_array[ 124 ] <=    
mem_array[ 125 ] <=    
mem_array[ 126 ] <=    
mem_array[ 127 ] <=    
mem_array[ 128 ] <=    
mem_array[ 129 ] <=    
mem_array[ 130 ] <=    
mem_array[ 131 ] <=    
mem_array[ 132 ] <=    
mem_array[ 133 ] <=    
mem_array[ 134 ] <=    
mem_array[ 135 ] <=    
mem_array[ 136 ] <=    
mem_array[ 137 ] <=    
mem_array[ 138 ] <=    
mem_array[ 139 ] <=    
mem_array[ 140 ] <=    
mem_array[ 141 ] <=    
mem_array[ 142 ] <=    
mem_array[ 143 ] <=    
mem_array[ 144 ] <=    
mem_array[ 145 ] <=    
mem_array[ 146 ] <=   
mem_array[ 147 ] <=    
mem_array[ 148 ] <=    
mem_array[ 149 ] <=    
mem_array[ 150 ] <=    
mem_array[ 151 ] <=    
mem_array[ 152 ] <=    
mem_array[ 153 ] <=    
mem_array[ 154 ] <=    
mem_array[ 155 ] <=    
*/
			
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