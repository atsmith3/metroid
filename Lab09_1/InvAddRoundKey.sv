module InvAddRoundKey ( input        [127:0] in , round_key,
                        output logic [127:0] out );

   //Individual bytes from wordSquare
   logic [7:0] a00, a01, a02, a03,
               a10, a11, a12, a13,
               a20, a21, a22, a23,
               a30, a31, a32, a33;

   logic [7:0] b00, b01, b02, b03,
               b10, b11, b12, b13,
               b20, b21, b22, b23,
               b30, b31, b32, b33;

   logic [7:0] c00, c01, c02, c03,
               c10, c11, c12, c13,
               c20, c21, c22, c23,
               c30, c31, c32, c33;

   assign {a00, a01, a02, a03, a10, a11, a12, a13, a20, a21, a22, a23, a30, a31, a32, a33} = in;
   assign {b00, b01, b02, b03, b10, b11, b12, b13, b20, b21, b22, b23, b30, b31, b32, b33} = round_key;

   /* TODO: Check that this function is correct */

   assign c00 = a00^b00;
   assign c01 = a01^b01;
   assign c02 = a02^b02;
   assign c03 = a02^b03;

   assign c10 = a10^b10;
   assign c11 = a11^b11;
   assign c12 = a12^b12;
   assign c13 = a12^b13;

   assign c20 = a20^b20;
   assign c21 = a21^b21;
   assign c22 = a22^b22;
   assign c23 = a22^b23;

   assign c30 = a30^b30;
   assign c31 = a31^b31;
   assign c32 = a32^b32;
   assign c33 = a32^b33;

   assign {c00, c01, c02, c03, c10, c11, c12, c13, c20, c21, c22, c23, c30, c31, c32, c33} = out;

endmodule // InvMixColumns
