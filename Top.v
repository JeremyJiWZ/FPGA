`timescale 1ns / 1ps
module Top(
    input [3:0]BTN,
	 input [7:0]SW,
	 input clk_50mhz,
	 input PS2_Data,
	 input PS2_clk,
	 output [3:0]AN,
	 output [7:0]SEGMENT,
	 output [7:0]LED,
	 output [2:0]Red, Green,
	 output [1:0]Blue,
	 output vsync,
	 output hsync
    );

wire clk;
wire rst;
wire [3:0]button_out;
wire [3:0]button_pulse;
wire [7:0]SW_OK;
//U9

wire [31:0]clkdiv;
wire Clk_CPU;
//U8

wire [31:0]Disp_num;
wire [3:0]pointing;
wire [3:0]blinking;
//U6

wire [31:0]inst_out;
wire [31:0]Data_in;
wire mem_w;
wire [31:0]PC_out;
wire [31:0]Addr_out;
wire [31:0]Data_out;
//U1

wire [7:0]led_out;
wire [31:0]counter_out;
wire GPIOf0000000_we;
wire GPIOe0000000_we;
wire counter_we;
wire [31:0]Peripheral_in;
wire cram_we;
wire [12:0]addr2cram;
wire [6:0]data2cram;
wire graph_mode; //hign for graph mode; low for text mode
wire cram_CV;
//U4

wire [31:0]douta;
wire [31:0]dina;
wire [9:0]addra;
wire wea;
wire clka;
//U3

wire [7:0]vram_data_in;
wire [14:0]vram_addr;
wire vram_we;
wire [7:0]vga4vram;
//U2

wire Clk_CPUa;
wire [31:0]point_in;
wire [31:0]blink_in;
//U5

wire [1:0]counter_set;
//U7

wire counter0_OUT;
wire counter1_OUT;
wire counter2_OUT;
//U10
wire N0;

wire ps2_clrn = ~rst;
wire ps2_rdn;
wire ps2_ready;
wire [7:0]ps2_data_in;
wire overflow;
//U11

wire vga_clk;
wire vga_clrn = ~rst;
wire [7:0]d_in;
wire [8:0]vy;
wire [9:0]vx;
wire vga_rdn;
//U12

assign clk=clk_50mhz;
assign clka=~clk;
assign Clk_CPUa=~Clk_CPU;
assign point_in=32'hffffffff;
assign blink_in=32'h00000000;


Muliti_CPU U1(.clk(Clk_CPU),
              .reset(rst),
				  .inst_out(inst_out[31:0]),
				  .INT(counter0_OUT),
				  .Data_in(Data_in[31:0]),
				  .MIO_ready(1'b1),
				  .mem_w(mem_w),
				  .PC_out(PC_out[31:0]),
				  .state(),
				  .Addr_out(Addr_out[31:0]),
				  .Data_out(Data_out[31:0]),
				  .CPU_MIO());
				  
VRAM U2(.addra(vram_addr),
         .wea(vram_we),
			.dina(vram_data_in[7:0]),
			.clka(clka),
			.douta(vga4vram[7:0]));				  

RAM_B U3(.addra(addra[9:0]),
         .wea(wea),
			.dina(dina[31:0]),
			.clka(clka),
			.douta(douta[31:0]));

MIO_BUS U4(.clk(clk),
           .rst(rst),
			  .mem_w(mem_w),
			  .counter0_out(counter0_OUT),
			  .counter1_out(counter1_OUT),
			  .counter2_out(counter2_OUT),
			  .BTN(button_out[3:0]),
			  .SW(SW_OK[7:0]),
			  .addr_bus(Addr_out[31:0]),
			  .Cpu_data2bus(Data_out[31:0]),
			  .ram_data_out(douta[31:0]),
			  .led_out(LED[7:0]),
			  .counter_out(counter_out[31:0]),
			  .GPIOf0000000_we(GPIOf0000000_we),
			  .GPIOe0000000_we(GPIOe0000000_we),
			  .counter_we(counter_we),
			  .Cpu_data4bus(Data_in[31:0]),
			  .Peripheral_in(Peripheral_in[31:0]),
			  .ram_data_in(dina[31:0]),
			  .ram_addr(addra[9:0]),
			  .data_ram_we(wea),
			  .ps2_ready(ps2_ready),
			  .ps2_data(ps2_data_in[7:0]),
			  .ps2_rdn(ps2_rdn),
			  .vx(vx),
			  .vy(vy),
			  .vga_rdn(vga_rdn),
			  .vram_we(vram_we),
			  .vram_addr(vram_addr),
			  .vram_data_in(vram_data_in),
			  .cram2bus(ascii[6:0]),
			  .cram_we(cram_we),
			  .addr2cram(addr2cram),
			  .data2cram(data2cram),
			  .graph_mode(graph_mode),
			  .cram_CV(cram_CV));
			  
seven_seg_Dev_IO U5(.clk(Clk_CPUa),
                    .rst(rst),
						  .GPIOe0000000_we(GPIOe0000000_we),
						  .Test(SW_OK[7:5]),
						  .point_in(point_in[31:0]),
						  .blink_in(blink_in[31:0]),
						  .disp_cpudata(Peripheral_in[31:0]),
						  .Test_data1({0,0,PC_out[31:2]}),
						  .Test_data2(counter_out[31:0]),
						  .Test_data3(inst_out[31:0]),
						  .Test_data4(Addr_out[31:0]),
						  .Test_data5(Data_out[31:0]),
						  .Test_data6(Data_in[31:0]),
						  .Test_data7(PC_out[31:0]),
						  .Disp_num(Disp_num[31:0]),
						  .blink_out(blinking[3:0]),
						  .point_out(pointing[3:0]));
						  
seven_seg_dev U6(.flash_clk(clkdiv[26]),
                 .disp_num(Disp_num[31:0]),
                 .SW(SW_OK[1:0]),
					  .Scanning(clkdiv[19:18]),
					  .pointing(pointing[3:0]),
					  .blinking(blinking[3:0]),
					  .AN(AN[3:0]),
					  .SEGMENT(SEGMENT[7:0]));
					  
led_Dev_IO U7(.clk(Clk_CPUa),
              .rst(rst),
				  .GPIOf0000000_we(GPIOf0000000_we),
				  .Peripheral_in(Peripheral_in[31:0]),
				  .counter_set(counter_set[1:0]),
				  .led_out(LED[7:0]),
				  .GPIOf0());
				  
clk_div U8(.clk(clk),
           .rst(rst),
			  .SW2(SW_OK[2]),
			  .clkdiv(clkdiv[31:0]),
			  .Clk_CPU(Clk_CPU));
			  
Anti_jitter U9(.clk(clk),
               .button(BTN[3:0]),
					.SW(SW[7:0]),
					.button_out(button_out[3:0]),
					.rst(rst),
					.button_pulse(button_pulse[3:0]),
					.SW_OK(SW_OK[7:0]));
					
Counter_x U10(.clk(Clk_CPUa),
              .rst(rst),
				  .clk0(clkdiv[7]),
				  .clk1(clkdiv[10]),
				  .clk2(clkdiv[10]),
				  .counter_we(counter_we),
				  .counter_val(Peripheral_in[31:0]),
				  .counter_ch(counter_set[1:0]),
				  .counter0_OUT(counter0_OUT),
				  .counter1_OUT(counter1_OUT),
				  .counter2_OUT(counter2_OUT),
				  .counter_out(counter_out[31:0]));
				  
ps2_keyboard U11 (.clk(Clk_CPU), 
						.clrn(ps2_clrn), 
						.ps2_clk(PS2_clk), 
						.ps2_data(PS2_Data), 
						.rdn(ps2_rdn), 
						.data(ps2_data_in), 
						.ready(ps2_ready), 
						.overflow(overflow));
						
clk_25mhz M1(clk_50mhz, clk_25mhz);
vgac U12 (.vga_clk(clk_25mhz),
			 .clrn(vga_clrn),
			 .d_in(d_in),
			 .row_addr(vy),
			 .col_addr(vx),
			 .rdn(vga_rdn),
			 .r(Red[2:0]),
			 .g(Green[2:0]),
			 .b(Blue[1:0]),
			 .hs(hsync),
			 .vs(vsync));
//***********************TEXT MODE************************************//
	 assign d_in[7:0]= graph_mode? vga4vram: vga_color;
	 wire font_dot;
	 wire [7:0]vga_color = font_dot? 8'hff: 8'h00;
    wire   [5:0] char_row = vy[8:3];                 // char row
    wire   [2:0] font_row = vy[2:0];                 // font row
    wire   [6:0] char_col = vx[9:3];                 // char col
    wire   [2:0] font_col = vx[2:0];                 // font col
    // char ram, 640/8 = 80 = 64 + 16; 480/8 = 60;
    wire  [12:0] vga_cram_addr = (char_row<<6) + (char_row<<4) + char_col;
    wire  [12:0] char_ram_addr = cram_we? addr2cram: vga_cram_addr;
    reg    [6:0] char_ram [0:4799];                        // 80 * 60 = 4800
    wire   [6:0] ascii = char_ram[char_ram_addr];
    always @(posedge Clk_CPU) begin
        if (cram_we) begin
            char_ram[char_ram_addr] <= data2cram[6:0];
        end
    end
    // font_table 128 x 8 x 8 x 1
    wire [12:0] ft_a = {ascii,font_row,font_col};          // ascii,row,col
    font_table ft (ft_a,font_dot);
		
endmodule
