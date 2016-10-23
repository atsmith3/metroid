/*---------------------------------------------------------------------------
  --      hello_world.c                                                    --
  --      Christine Chen                                                   --
  --      Fall 2013														   --
  --																	   --
  --      Updated Spring 2015 											   --
  --	  Yi Liang														   --
  --																	   --
  --      For use with ECE 385 Experiment 9                                --
  --      UIUC ECE Department                                              --
  ---------------------------------------------------------------------------*/


#include <stdio.h>
#include <stdlib.h>

#define to_hw_port (volatile char*) 0x00000050 // actual address here
#define to_hw_sig (volatile char*) 0x00000030 // actual address here
#define to_sw_port (char*) 0x00000040 // actual address here
#define to_sw_sig (char*) 0x00000020 // actual address here

char charToHex(char c)
{
	char hex = c;

	if (hex >= '0' && hex <= '9')
		hex -= '0';
	else if (hex >= 'A' && hex <='F')
	{
		hex -= 'A';
		hex += 10;
	}
	else if (hex >= 'a' && hex <='f')
	{
		hex -= 'a';
		hex += 10;
	}
	return hex;
}

char charsToHex(char c1, char c2)
{
	char hex1 = charToHex(c1);
	char hex2 = charToHex(c2);
	return (hex1 << 4) + hex2;
}

void SubBytes(char** wordSquare){
	int i,j;
	for(i = 0; i < 4; i++){
		for(j = 0; j < 4; j++){
			wordSquare[j][i]=SubByte(wordSquare[j][i]);
		}
	}
}

char SubByte(char word1){
	/* Get the coordinates for S-Box */
	unsigned int coord1 = word1 & 0xF0;
	coord1 = coord1 >> 4;
	unsigned int coord2 = word2 & 0x0F;

	return aes_sbox[coord1][coord2];
}

void ShiftRows(char** wordSquare){
	int i,j;
		for(j = 1; j < 4; j++){
			for(i = 0; i < j; i++){
				char temp = wordSqaure[j][0];
				wordSquare[j][0]=wordSquare[j][1];
				wordSquare[j][1]=wordSquare[j][2];
				wordSquare[j][2]=wordSquare[j][3];
				wordSquare[j][3]=temp;
			}
		}
}

char Xor(char word, int val){
	if(val==1)
		return word;
	else if(val==2){
		if(word&0x80){
			word=word<<1;
			return word^0x1b;
		}
		return word<<1;
	}
	else{
		char ogWord=word;
		if(word&0x80){
			word=word<<1;
			word^=0x1b;
		}
		else
			word=word<<1;

		return ogWord^word;
	}
}

void MixColumns(char** wordSquare){
	int i;
		for(i = 0; i < 4; i++){
				temp0= Xor(wordSquare[0][i],2);
				temp0^=Xor(wordSquare[1][i],3);
				temp0^=Xor(wordSquare[2][i],1);
				temp0^=Xor(wordSquare[3][i],1);

				temp1= Xor(wordSquare[0][i],1);
				temp1^=Xor(wordSquare[1][i],2);
				temp1^=Xor(wordSquare[2][i],3);
				temp1^=Xor(wordSquare[3][i],1);

				temp2= Xor(wordSquare[0][i],1);
				temp2^=Xor(wordSquare[1][i],1);
				temp2^=Xor(wordSquare[2][i],2);
				temp2^=Xor(wordSquare[3][i],3);

				temp3= Xor(wordSquare[0][i],3);
				temp3^=Xor(wordSquare[1][i],1);
				temp3^=Xor(wordSquare[2][i],1);
				temp3^=Xor(wordSquare[3][i],2);

				wordSquare[0][i]=temp0;
				wordSquare[1][i]=temp1;
				wordSquare[2][i]=temp2;
				wordSquare[3][i]=temp3;
		}
}

void AddRoundKey(char** wordSquare, char** roundKey){
	int i,j;
	for(i=0; i<3; i++){
		for(j=0; j<3; j++){
			wordSquare[j][i]^=roundKey[j][i];
		}
	}
}

void string2array(char** wordSq, char* plaintext)
{
	char a,b;
	int i,j;
	for(i = 0; i < 4; i++){
		for(j = 0; j < 4; j++)
		{
			a = plaintext[2(4i + j)];
			b = plaintext[2(4i + j) + 1];

			wordSq[i][j] = charsToHex(a,b);
		}
	}
}

void makeKeySched(char** keySq, char** keySchedule){
	int i, j;
	for(i=0; i<4; i++){
		for(j=0; j<4; j++){
			keySchedule[j][i]=keySq[j][i];
		}
	}

	for(i=4; i<44; i++){
		if(i%4==0){
			unsigned char temp[4] = { keySchedule[i-1][1], keySchedule[i-1][2], keySchedule[i-1][3], keySchedule[i-1][0]}; //RotWord
			for(j=0; j<4; j++){
				temp[j] = SubByte(temp[j]); //SubBytes
			}
			temp[0]^=Rcon[i/4-1]>>6;
			for(j=0; j<4; j++){
				keySchedule[j][i]=keySchedule[j][i-4]^temp[j];
			}
		}
		else{
			for(j=0; j<4; j++){
				keySchedule[j][i]=keySchedule[j][i-1]^keySchedule[j][i-4];
			}
		}
	}
}


// Function hex2char:
void hex2char(unsigned char hexVal, unsigned char* buffer, int index) {
	unsigned char higher, lower;
    higher = (hexVal & 0xF0) >> 4;
    lower = (hexVal & 0x0F);

    if (higher >= 0 && higher <= 9)
		higher += '0';
	else if (higher >= 10 && higher <= 15)
	{
		higher += 'a';
		higher -= 10;
	}

    // Set the higher char as the first character:
	buffer[index] = higher;

    if (lower >= 0 && lower <= 9)
		lower += '0';
	else if (lower >= 10 && lower <= 15)
	{
		lower += 'a';
		lower -= 10;
	}

	// Set the lower char as the second character:
	buffer[index + 1] = lower;
}

// Function square to string:
void square2string(unsigned char** array, unsigned char* buffer) {
    int i, j;
	for(i = 0; i < 4; i++){
		for(j = 0; j < 4; j++){
			// Call uppon macro function that converts hex to chars:
			// Read down columns:
			hex2char(array[j][i], buffer, 2(4i + j));
		}
	}
	buffer[32] = '\0'
}


int main()
{
	int i;
	unsigned char plaintext[33]; //should be 1 more character to account for string terminator
	unsigned char key[33];

	unsigned char wordSq[4][4];
	unsigned char keySq[4][4];
	unsigned char keySchedTemp[4][4];
    unsigned char keySchedule[4][44];

    unsigned char cypher[33];

    int i,j,k;

	// Start with pressing reset
	*to_hw_sig = 0;
	*to_hw_port = 0;
	printf("Press reset!\n");
	while (*to_sw_sig != 3);

	while (1)
	{
		*to_hw_sig = 0;
		printf("\n");

		printf("\nEnter plain text:\n");
		scanf ("%s", plaintext);
		printf ("\n");
		printf("\nEnter key:\n");
		scanf ("%s", key);
		printf ("\n");


		// Convert the plaintext and key into 4x4 arrays:
		string2array(keySq, key);
		string2array(wordSq, plaintext);

		// Make key schedule:
		makeKeySched(keySq, keySchedule);

		//Key Expansion and AES encryption using week 1's AES algorithm.
	    // 1: Add round key:
		AddRoundKey(wordSq, keySq);

		// 2: Looping construct:
		for(i = 0; i < 9; i++){
			// 2.1: SubBytes
			SubBytes(wordSq);
			// 2.2: ShiftRows
			ShiftRows(wordSq);
			// 2.3: Mix Columns
			MixColumns(wordSq);
			// 2.4: Add ROundkey with keySchedule
			for(j=0; j<4; j++){
				for(k=0; k<4; k++){
					keySchedTemp[j][k]=keySchedule[j][k+4*(i+1)];
				}
			}
			AddRoundKey(wordSq,keySchedTemp);
		}

		// 3.1: SubBytes
		SubBytes(wordSq);
		// 3.2: ShiftRows
		ShiftRows(wordSq);
		// 3.3: Add KeySchedule
		for(j=0; j<4; j++){
			for(k=0; k<4; k++){
				keySchedTemp[j][k]=keySchedule[j][k+40];
			}
		}
		AddRoundKey(wordSq,keySchedTemp);

		// Convert back to a plaintext:
		square2string(wordSq, cypher);

		// TODO: display the encrypted message.
		printf("\nEncrypted message is\n");
		printf("%s \n", cypher);

		// Transmit encrypted message to hardware side for decryption.
		printf("\nTransmitting message...\n");

		for (i = 0; i < 16; i++)
		{
			*to_hw_sig = 1;
			*to_hw_port = encryptedMsg[i]; // encryptedMsg is your encrypted message
			// Consider to use charToHex() if your encrypted message is a string.
			while (*to_sw_sig != 1);
			*to_hw_sig = 2;
			while (*to_sw_sig != 0);
		}
		*to_hw_sig = 0;

		// Transmit encrypted message to hardware side for decryption.
		printf("\nTransmitting key...\n");

		//TODO: Transmit key

		printf("\n\n");

		while (*to_sw_sig != 2);
		printf("\nRetrieving message...\n");
		for (i = 0; i < 16; ++i)
		{
			*to_hw_sig = 1;
			while (*to_sw_sig != 1);
			str[i] = *to_sw_port;
			*to_hw_sig = 2;
			while (*to_sw_sig != 0);
		}

		printf("\n\n");

		printf("Decoded message:\n");

		// TODO: print decoded message
	}

	return 0;
}
