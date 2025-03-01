module viterbi_test_tb;
	wire [7:0]decode_out;
	wire [15:0] next;
	reg clk;
	reg rst_n;
	reg [1:0] data_in;

	reg[15:0] read_data[0:9];
	reg[15:0] data_sim;

	integer i;

	viterbi_test v_test(
			.clk        (clk), 
			.rst_n      (rst_n), 
			.data_in    (data_in),
			.next       (next), 
			.decode_out (decode_out)
			);

	initial begin
	$monitor ("%t data_in = %b, next = %b, decode_out = %b",$time, data_in, 
			next,decode_out);
	end

	/*initial
	begin
    		rst_n = 1;
    		#5 rst_n = 0;
    		#10 rst_n = 1;
  	end*/

	initial
	begin
		clk = 0;
		forever clk = #10 ~clk;
	end

	initial
	begin
		$readmemb("E:/Term20211/TKHTS2/input_16bit.txt",read_data);
		for (i=0; i<10; i=i+1)
		begin
			data_sim = read_data[i];
			$display("Starting to decode sequence %b",data_sim);
			#0 rst_n = 1'b0; data_in = data_sim[15:14];
			#5 rst_n = 1'b1; //data_in = 2'b01;
	
	//data_in = 2'b01;  @(posedge clk)
			data_in = data_sim[13:12];  @(posedge clk)
			data_in = data_sim[11:10];  @(posedge clk)
			data_in = data_sim[9:8];  @(posedge clk)
			data_in = data_sim[7:6];  @(posedge clk)
			data_in = data_sim[5:4];  @(posedge clk)
			data_in = data_sim[3:2];  @(posedge clk)
			data_in = data_sim[1:0];  //@(posedge clk)
			#5;
		end
	#5 $stop;
	end
endmodule
