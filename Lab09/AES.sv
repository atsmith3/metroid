/*---------------------------------------------------------------------------
 --      AES.sv                                                           --
 --      Joe Meng                                                         --
 --      Fall 2013                                                        --
 --                                                                       --
 --      For use with ECE 298 Experiment 9                                --
 --      UIUC ECE Department                                              --
 ---------------------------------------------------------------------------*/

AES module interface with all ports, commented for Week 1
  module  AES ( input  [127:0]  Plaintext,
                Cipherkey,
                input          Clk, 
                               Reset,
                               Run,
                output [127:0] Ciphertext,
                output         Ready  );

   // Partial interface for Week 1
   // Splitting the signals into 32-bit ones for compatibility with ModelSim
   // module  AES ( input clk,
   // 		  input  [0:31]  Cipherkey_0, Cipherkey_1, Cipherkey_2, Cipherkey_3,
   //             output [0:31]  keyschedule_out_0, keyschedule_out_1, keyschedule_out_2, keyschedule_out_3 );

   logic [0:1407]              keyschedule;

   enum logic[6:0] {InvShiftRows_1, InvSubBytes_1, AddRoundKey_1,
                    InvShiftRows_3, InvSubBytes_2, AddRoundKey_2,
                    InvShiftRows_4, InvSubBytes_3, AddRoundKey_3,
                    InvShiftRows_5, InvSubBytes_4, AddRoundKey_4,
                    InvShiftRows_6, InvSubBytes_5, AddRoundKey_5,
                    InvShiftRows_7, InvSubBytes_6, AddRoundKey_6,
                    InvShiftRows_8, InvSubBytes_7, AddRoundKey_7,
                    InvShiftRows_9, InvSubBytes_8, AddRoundKey_8,
                    InvShiftRows_1, InvSubBytes_9, AddRoundKey_9,
                    InvShiftRows_0, InvSubBytes_0, AddRoundKey_0,
                    InvMixColumns, WAIT, RESET}
        state, next_state, prev_state;

   always @ (posedge clk, negedge reset_n) begin
      if(reset_n == 1'b0) begin
         state <= RESET;
      end
      else begin
         prev_state <= state;
         state <= next_state;
      end
   end
/* Notes:
   What to do with WAIT and RESET states.
   Where to set next and prev state
   Accurate module naming
*/
   always_comb
     case(state)
       InvShiftRows_0: begin
          InvShiftRows isf0();
       end
       InvShiftRows_1: begin
          InvShiftRows isf1();
       end
       InvShiftRows_2: begin
          InvShiftRows isf2();
       end
       InvShiftRows_3: begin
          InvShiftRows isf3();
       end
       InvShiftRows_4: begin
          InvShiftRows isf4();
       end
       InvShiftRows_5: begin
          InvShiftRows isf5();
       end
       InvShiftRows_6: begin
          InvShiftRows isf6();
       end
       InvShiftRows_7: begin
          InvShiftRows isf7();
       end
       InvShiftRows_8: begin
          InvShiftRows isf8();
       end
       InvShiftRows_9: begin
          InvShiftRows isf9();
       end

       InvSubBytes_0: begin
          InvSubBytes isb0();
       end
       InvSubBytes_1: begin
          InvSubBytes isb1();
       end
       InvSubBytes_2: begin
          InvSubBytes isb2();
       end
       InvSubBytes_3: begin
          InvSubBytes isb3();
       end
       InvSubBytes_4: begin
          InvSubBytes isb4();
       end
       InvSubBytes_5: begin
          InvSubBytes isb5();
       end
       InvSubBytes_6: begin
          InvSubBytes isb6();
       end
       InvSubBytes_7: begin
          InvSubBytes isb7();
       end
       InvSubBytes_8: begin
          InvSubBytes isb8();
       end
       InvSubBytes_9: begin
          InvSubBytes isb9();
       end

       AddRoundKey_0: begin
          AddRoundKey ark0();
       end
       AddRoundKey_1: begin
          AddRoundKey ark1();
       end
       AddRoundKey_2: begin
          AddRoundKey ark2();
       end
       AddRoundKey_3: begin
          AddRoundKey ark3();
       end
       AddRoundKey_4: begin
          AddRoundKey ark4();
       end
       AddRoundKey_5: begin
          AddRoundKey ark5();
       end
       AddRoundKey_6: begin
          AddRoundKey ark6();
       end
       AddRoundKey_7: begin
          AddRoundKey ark7();
       end
       AddRoundKey_8: begin
          AddRoundKey ark8();
       end
       AddRoundKey_9: begin
          AddRoundKey ark9();
       end

       InvMixColumns: begin
          InvMixColumns imc0();
       end

       

     endcase // case (state)
   

   always

   KeyExpansion keyexpansion_0(
                               .*, .Cipherkey({Cipherkey_0, Cipherkey_1, Cipherkey_2, Cipherkey_3}),
                               .KeySchedule(keyschedule));

   assign {keyschedule_out_0, keyschedule_out_1, keyschedule_out_2, keyschedule_out_3} = keyschedule[1280:1407];

endmodule
