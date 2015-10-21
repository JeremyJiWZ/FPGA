`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:56:39 08/30/2015 
// Design Name: 
// Module Name:    MIO_BUS 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MIO_BUS( input clk,
					 input rst,
					 input mem_w,
					 input counter0_out,
					 input counter1_out,
					 input counter2_out,
					 input [3:0]BTN,
					 input [7:0]SW, led_out,
					 input [31:0] Cpu_data2bus, ram_data_out, addr_bus, counter_out,
					 input ps2_ready,
					 input [7:0]ps2_data,
					 input vga_rdn,
					 input [9:0]vx, vy,
					 input [6:0]cram2bus,
					 output reg data_ram_we, GPIOf0000000_we, GPIOe0000000_we, counter_we, vram_we,
					 output reg [9:0]ram_addr,
					 output reg [31:0]Cpu_data4bus, ram_data_in, Peripheral_in,
					 output reg [14:0]vram_addr,
					 output reg [7:0]vram_data_in,
					 output reg ps2_rdn,
					 output reg cram_we,
					 output reg [6:0]data2cram,
					 output reg [12:0]addr2cram,
					 output reg graph_mode,
					 output reg cram_CV
    );
reg [7:0]led_in;
wire counter_over;
wire graph_mode_clk;
//status for tank and bullet
reg [31:0] tank1, tank2, bullet1, bullet2;
//++++++++initial VGA signal:++++++++++++++++
	initial begin
		tank1 = 32'hc0000000;
		tank2 = 32'h80067E3F;
		bullet1 = 32'h60006040;
		bullet2 = 32'h4006DE30;
		vram_addr = 0;
	   graph_mode = 0;
	end
//++++++++RAM & IO decode signals:
	always @* begin
		cram_CV = 0;
		data_ram_we = 0;
		counter_we = 0;
		GPIOf0000000_we = 0;
		GPIOe0000000_we = 0;
		ram_addr = 10'h000;
		ram_data_in = 32'h00000000;
		Peripheral_in = 32'h0;
		Cpu_data4bus = 32'h0;
		vram_we = 0;
		vram_data_in = 8'h00;
		ps2_rdn = 1;
		tank1=tank1;
		bullet1=bullet1;
		tank2=tank2;
		bullet2=bullet2;
		case(addr_bus[31:28])
			4'h0: begin//data_ram(0000-0ffc)
				data_ram_we = mem_w;
				ram_addr = addr_bus[11:2];
				ram_data_in = Cpu_data2bus;
				Cpu_data4bus = ram_data_out;
				end
			4'ha: begin
				graph_mode = Cpu_data2bus[0];
				end
			4'he: begin//7 segment leds(e0000000-efffffff)
				GPIOe0000000_we = mem_w;
				Peripheral_in = Cpu_data2bus;
				Cpu_data4bus = counter_out;
				end
			4'hf: begin//led(f0000000-fffffff0, 8 leds&counter, f0000004-fffffff4)
				if(addr_bus[2]) begin//f0000004
					counter_we = mem_w;
					Peripheral_in = Cpu_data2bus;
					Cpu_data4bus = counter_out;
					end
				else begin //f0000000
					GPIOf0000000_we = mem_w;
					Peripheral_in = Cpu_data2bus; //writer counter set & Initialization& led
					Cpu_data4bus = {counter0_out, counter1_out, counter2_out, 9'h000, led_out, BTN, SW};
					end
				end
			4'hc: begin //c0000000 for VGA
				case(addr_bus[3:0])
					4'h0:begin //tank1
						tank1 = Cpu_data2bus; 
						end
					4'h4:begin //tank2
						tank2 = Cpu_data2bus;
						end
					4'h8:begin //bullet1
						bullet1 = Cpu_data2bus;
						end
					4'hc:begin //bullet2
						bullet2 = Cpu_data2bus;
						end
					default: begin
						tank1 = tank1;
						tank2 = tank2;
						bullet1 = bullet1;
						bullet2 = bullet2;
						end
					endcase
				vram_data_in = Cpu_data2bus;
				end
			4'hd: begin //d0000000 for ps2
				Cpu_data4bus = {23'h0, ps2_ready, ps2_data};
				ps2_rdn = mem_w?1:0;
				data2cram = Cpu_data2bus;
				addr2cram = addr_bus[14:2];
				cram_we = mem_w;
				cram_CV = 1;
				end
		endcase
	end
	always @* begin
		if(vx>=tank1[9:0]&&
			vx<tank1[9:0]+64&&
			vy>=tank1[19:10]&&
			vy<tank1[19:10]+64)		begin //tank1
			case (tank1[31:30]) 
				2'b00: begin
					vram_addr = (vy-tank1[19:10])/4*16+(vx-tank1[9:0])/4; //UP
					end
				2'b01: begin
					vram_addr = 256+(vy-tank1[19:10])/4*16+(vx-tank1[9:0])/4; //DOWN
					end
				2'b10: begin
					vram_addr = 512+(vy-tank1[19:10])/4*16+(vx-tank1[9:0])/4; //LEFT
					end
				2'b11: begin
					vram_addr = 768+(vy-tank1[19:10])/4*16+(vx-tank1[9:0])/4; //RIGHT
					end
			endcase
		end
		else if (vx>=tank2[9:0]&&
					vx<tank2[9:0]+64&&
					vy>=tank2[19:10]&&
					vy<tank2[19:10]+64) begin //tank2
			case(tank2[31:30])
				2'b00: begin
					vram_addr = (vy-tank2[19:10])/4*16+(vx-tank2[9:0])/4; //UP
					end
				2'b01: begin
					vram_addr = 256+(vy-tank2[19:10])/4*16+(vx-tank2[9:0])/4; //DOWN
					end
				2'b10: begin
					vram_addr = 512+(vy-tank2[19:10])/4*16+(vx-tank2[9:0])/4; //LEFT
					end
				2'b11: begin
					vram_addr = 768+(vy-tank2[19:10])/4*16+(vx-tank2[9:0])/4; //RIGHT
					end
			endcase
		end
		else if (vx>=bullet1[9:0]&&
					vx<bullet1[9:0]+16&&
					vy>=bullet1[19:10]&&
					vy<bullet1[19:10]+16&&
					bullet1[31]) begin //bullet of tank1
			vram_addr = 1024+ (vy-bullet1[19:10])/4*4 + (vx-bullet1[9:0])/4;
			end
		else if (vx>=bullet2[9:0]&&
					vx<bullet2[9:0]+16&&
					vy>=bullet2[19:10]&&
					vy<bullet2[19:10]+16&&
					bullet2[31]) begin //bullet of tank2
			vram_addr = 1024+ (vy-bullet2[19:10])/4*4 + (vx-bullet2[9:0])/4;
			end
		else if(~vga_rdn)
			vram_addr = 1040+ vy/4*160 + vx/4;
	end
endmodule

