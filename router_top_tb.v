 module router_top_tb();

reg clk, resetn, read_enb_0, read_enb_1, read_enb_2, pkt_valid;
reg [7:0]datain;
wire [7:0]data_out_0, data_out_1, data_out_2;
wire vld_out_0, vld_out_1, vld_out_2, err, busy;
integer i;
reg [1:0] addr;

router_top DUT(.clk(clk),
			   .resetn(resetn),
			   .read_enb_0(read_enb_0),
			   .read_enb_1(read_enb_1),
			   .read_enb_2(read_enb_2),
			   .packet_valid(packet_valid),
			   .datain(datain),
			   .data_out_0(data_out_0),
			   .data_out_1(data_out_1),
			   .data_out_2(data_out_2),
			   .vldout_0(vld_out_0),
			   .vldout_1(vld_out_1),
			   .vldout_2(vld_out_2),
			   .err(err),
			   .busy(busy) );			   
			   
//clock generation

initial 
	begin
	clk = 1;
	forever 
	#5 clk=~clk;
	end
	
	
	task reset;
		begin
			resetn=1'b0;
			{read_enb_0, read_enb_1, read_enb_2, pkt_valid, datain}=0;
			#10;
			resetn=1'b1;
		end
	endtask
	
	task pktm_gen_14;	
			reg [7:0]header, payload_data, parity;
			reg [8:0]payload_len;
			
			begin
				@(negedge clk);
				wait(!busy)
				
				@(negedge clk);
				payload_len=6'd14;
				addr=2'b10;
				header={payload_len,addr};
				parity=0;
				datain=header;
				pkt_valid=1;
				parity=parity^header;
				
				@(negedge clk);
				wait(~busy)
							
				for(i=0;i<payload_len;i=i+1)
					begin
									
					@(negedge clk);
					wait(~busy)
					payload_data={$random}%256;
					datain=payload_data;
					parity=parity^payload_data;
					end
					@(negedge clk)
					wait(~busy)
					pkt_valid=0;
					datain=parity;				
					end
					$display("time = %t , input data = %d ",$time,datain);	
					$display("packet length 14 is successfully transmitted");
endtask 
task pktm_gen_15;	
			reg [7:0]header, payload_data, parity;
			reg [8:0]payload_len;
			
			begin
				@(negedge clk);
				wait(!busy)
				
				@(negedge clk);
				payload_len=6'd15;
				addr=2'b10;
				header={payload_len,addr};
				parity=0;
				datain=header;
				pkt_valid=1;
				parity=parity^header;
				
				@(negedge clk);
				wait(~busy)
							
				for(i=0;i<payload_len;i=i+1)
					begin
									
					@(negedge clk);
					wait(~busy)
					payload_data={$random}%256;
					datain=payload_data;
					parity=parity^payload_data;
					end
					@(negedge clk)
					wait(~busy)
					pkt_valid=0;
					datain=parity;				
					end					
					$display("time = %t , input data = %d ",$time,datain);
					$display("packet length 14 is successfully transmitted");
							
	endtask	
task pktm_gen_16;	
			reg [7:0]header, payload_data, parity;
			reg [8:0]payload_len;
			
			begin
				@(negedge clk);
				wait(!busy)
				
				@(negedge clk);
				payload_len=6'd16;
				addr=2'b10;
				header={payload_len,addr};
				parity=0;
				datain=header;
				pkt_valid=1;
				parity=parity^header;
				
				@(negedge clk);
				wait(~busy)
							
				for(i=0;i<payload_len;i=i+1)
					begin
									
					@(negedge clk);
					wait(~busy)
					payload_data={$random}%256;
					datain=payload_data;
					parity=parity^payload_data;
					end
					@(negedge clk)
					wait(~busy)
					pkt_valid=0;
					datain=parity;				
					end					
					$display("time = %t , input data = %d ",$time,datain);
					$display("packet length 14 is successfully transmitted");	
	endtask			
								
	
		initial
		begin
			reset;
			#10;
			pktm_gen_14;
			reset;
			#20;
			pktm_gen_15;
			reset;
			#20;
			pktm_gen_15;
			
			#2000;
			$finish;
		end
		
		
endmodule
