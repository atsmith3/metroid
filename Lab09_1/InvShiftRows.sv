module InvShiftRows ( input        [127:0] in ,
                       output logic [127:0] out );

   //Temp variable to allow rotations
   logic [7:0] temp;

   //Individual bytes from wordSquare
   logic [7:0] a00, a01, a02, a03,
               a10, a11, a12, a13,
               a20, a21, a22, a23,
               a30, a31, a32, a33;

   assign {a00, a01, a02, a03, a10, a11, a12, a13, a20, a21, a22, a23, a30, a31, a32, a33} = in;

   /*TODO: Please check that this program actually works */
   //Store first variable in temp then rotate
   assign temp = a10;
   assign a10 = a11;
   assign a11 = a12;
   assign a12 = a13;
   assign a13 = a14;
   assign a14 = temp;

   assign temp = a20;
   assign a20 = a22;
   assign a22 = temp;
   assign a21 = temp;
   assign a21 = a23;
   assign a23 = temp;

   assign temp = a30;
   assign a30 = a33;
   assign a33 = a32;
   assign a32 = a31;
   assign a31 = temp;

   assign {a00, a01, a02, a03, a10, a11, a12, a13, a20, a21, a22, a23, a30, a31, a32, a33} = out;

endmodule // InvMixColumns

