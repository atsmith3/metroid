/*---------------------------------------------------------------------------
  --      aes_controller.sv                                                --
  --      Christine Chen                                                   --
  --      10/29/2013                                                       --
  --                                                                       --
  --      For use with ECE 298 Experiment 9                                --
  --      UIUC ECE Department                                              --
  ---------------------------------------------------------------------------*/
// AES controller module

module aes_controller(
				input			 		   clk,
				input					   reset_n,
				input	[127:0]			msg_en,
				input	[127:0]			key,
				output  [127:0]		msg_de,
				input					   io_ready,
				output					aes_ready);

enum logic [1:0] {WAIT, COMPUTE, READY} state, next_state;
logic [15:0] counter;
logic aes_complete; /* signal that lets AES know the decryption is done */
logic aes_begin; /* signal that initiates the encryption process */

AES aes0(.Clk(clk), .Plaintext(msg_en), .Cipherkey({key[127:96], key[95:64], key[63:32], key[31:0]}), .Run(aes_begin), .Ciphertext({msg_de[127:96], msg_de[95:64], msg_de[63:32], msg_de[31:0]}), .Ready(aes_complete));
			  
always_ff @ (posedge clk, negedge reset_n) begin
	if (reset_n == 1'b0) begin
		state <= WAIT;
		counter <= 16'd0;
	end else begin
		state <= next_state;
		if (state == COMPUTE)
			counter <= counter + 1'b1;
	end
end

always_comb begin
	next_state = state;
	case (state)
		WAIT: begin
			if (io_ready)
				next_state = COMPUTE;
		end
		
		COMPUTE: begin
			if (counter == 16'd65535)
				next_state = READY;
			if (aes_complete == 1)
			   next_state = READY;
			else
			   next_state = COMPUTE;
		end
		
		READY: begin
		    next_state = WAIT;
		end
	endcase
end

always_comb begin
   // Default values:
	aes_ready = 1'b0;
	aes_begin = 0;
	case (state)
		WAIT: begin
			aes_ready = 1'b0;
			aes_begin = 0;
		end
		
		COMPUTE: begin
			aes_ready = 1'b0;
			aes_begin = 1;
		end
		
		READY: begin
			aes_ready = 1'b1;
			aes_begin = 0;
		end
	endcase
end
endmodule