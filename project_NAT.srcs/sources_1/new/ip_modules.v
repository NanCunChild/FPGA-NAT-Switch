// ip_models.v
// 用于替代 Xilinx IP 核的通用 Verilog 模型 (纯 Verilog-2001 版本)
// 包含: 通用 FIFO 和 双口 RAM

// =========================================================
// 1. 通用 FIFO 模型 (First-Word Fall-Through 模式)
// =========================================================
module FIFO_generic_fwft #(
    parameter WIDTH = 10,
    parameter DEPTH = 1024
)(
    input  wire             clk,
    input  wire             rst, // 高电平复位
    input  wire [WIDTH-1:0] din,
    input  wire             wr_en,
    input  wire             rd_en,
    output wire [WIDTH-1:0] dout,
    output wire             full,
    output wire             empty,
    // 兼容接口，暂时悬空
    output wire             prog_full,
    output wire             wr_rst_busy,
    output wire             rd_rst_busy
);

    reg [WIDTH-1:0] mem [0:DEPTH-1];
    // 使用大一点的位宽防止溢出，简单模拟
    reg [31:0] w_ptr;
    reg [31:0] r_ptr;
    
    assign full  = ((w_ptr - r_ptr) >= DEPTH);
    assign empty = (w_ptr == r_ptr);
    // FWFT: 直接输出当前读指针的数据
    assign dout  = mem[r_ptr % DEPTH]; 

    assign wr_rst_busy = 1'b0;
    assign rd_rst_busy = 1'b0;
    assign prog_full   = ((w_ptr - r_ptr) >= (DEPTH-4));

    integer i;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            w_ptr <= 0;
            r_ptr <= 0;
        end else begin
            if (wr_en && !full) begin
                mem[w_ptr % DEPTH] <= din;
                w_ptr <= w_ptr + 1;
            end
            if (rd_en && !empty) begin
                r_ptr <= r_ptr + 1;
            end
        end
    end
endmodule

// =========================================================
// 2. 具体的 FIFO 封装 (展开所有端口)
// =========================================================

module FIFO_w10_d1024_fwft(
    input clk, input rst, input [9:0] din, input wr_en, input rd_en, 
    output [9:0] dout, output full, output empty, output prog_full, output wr_rst_busy, output rd_rst_busy
);
    FIFO_generic_fwft #(.WIDTH(10), .DEPTH(1024)) inst_w10 (
        .clk(clk), .rst(rst), .din(din), .wr_en(wr_en), .rd_en(rd_en),
        .dout(dout), .full(full), .empty(empty), .prog_full(prog_full), .wr_rst_busy(wr_rst_busy), .rd_rst_busy(rd_rst_busy)
    );
endmodule

module FIFO_w17_d128_fwft(
    input clk, input rst, input [16:0] din, input wr_en, input rd_en, 
    output [16:0] dout, output full, output empty, output prog_full, output wr_rst_busy, output rd_rst_busy
);
    FIFO_generic_fwft #(.WIDTH(17), .DEPTH(128)) inst_w17 (
        .clk(clk), .rst(rst), .din(din), .wr_en(wr_en), .rd_en(rd_en),
        .dout(dout), .full(full), .empty(empty), .prog_full(prog_full), .wr_rst_busy(wr_rst_busy), .rd_rst_busy(rd_rst_busy)
    );
endmodule

module FIFO_w48_d128_fwft(
    input clk, input rst, input [47:0] din, input wr_en, input rd_en, 
    output [47:0] dout, output full, output empty, output prog_full, output wr_rst_busy, output rd_rst_busy
);
    FIFO_generic_fwft #(.WIDTH(48), .DEPTH(128)) inst_w48 (
        .clk(clk), .rst(rst), .din(din), .wr_en(wr_en), .rd_en(rd_en),
        .dout(dout), .full(full), .empty(empty), .prog_full(prog_full), .wr_rst_busy(wr_rst_busy), .rd_rst_busy(rd_rst_busy)
    );
endmodule

module FIFO_w54_d128_fwft(
    input clk, input rst, input [53:0] din, input wr_en, input rd_en, 
    output [53:0] dout, output full, output empty, output prog_full, output wr_rst_busy, output rd_rst_busy
);
    FIFO_generic_fwft #(.WIDTH(54), .DEPTH(128)) inst_w54 (
        .clk(clk), .rst(rst), .din(din), .wr_en(wr_en), .rd_en(rd_en),
        .dout(dout), .full(full), .empty(empty), .prog_full(prog_full), .wr_rst_busy(wr_rst_busy), .rd_rst_busy(rd_rst_busy)
    );
endmodule

module FIFO_w22_d128_fwft(
    input clk, input rst, input [21:0] din, input wr_en, input rd_en, 
    output [21:0] dout, output full, output empty, output prog_full, output wr_rst_busy, output rd_rst_busy
);
    FIFO_generic_fwft #(.WIDTH(22), .DEPTH(128)) inst_w22 (
        .clk(clk), .rst(rst), .din(din), .wr_en(wr_en), .rd_en(rd_en),
        .dout(dout), .full(full), .empty(empty), .prog_full(prog_full), .wr_rst_busy(wr_rst_busy), .rd_rst_busy(rd_rst_busy)
    );
endmodule

// Manager.v 中还用到了一个 fifo_wxx_dxx_s
module fifo_wxx_dxx_s #(parameter PTR=5, WORDS=32, W_SIZE=1, A_FULL=31) (
    input clock, input rst_n, input fifo_wen, input [W_SIZE-1:0] fifo_wdata, input fifo_ren,
    output [W_SIZE-1:0] fifo_rdata, output fifo_empty_rd, output almost_full
);
    wire full;
    // 注意：这里 RST 信号取反，因为上面的通用模块是高电平复位，而 rst_n 是低电平
    FIFO_generic_fwft #(.WIDTH(W_SIZE), .DEPTH(WORDS)) inst_cov (
        .clk(clock), .rst(~rst_n), 
        .din(fifo_wdata), .wr_en(fifo_wen), 
        .dout(fifo_rdata), .rd_en(fifo_ren),
        .full(full), .empty(fifo_empty_rd), .prog_full(almost_full),
        .wr_rst_busy(), .rd_rst_busy()
    );
endmodule


// =========================================================
// 3. 通用真双口 RAM 模型 (True Dual Port RAM)
// =========================================================
module RAM_generic_tdp #(
    parameter WIDTH = 96,
    parameter DEPTH = 1024
)(
    input clka, input wea, input [9:0] addra, input [WIDTH-1:0] dina, output reg [WIDTH-1:0] douta,
    input clkb, input web, input [9:0] addrb, input [WIDTH-1:0] dinb, output reg [WIDTH-1:0] doutb
);
    reg [WIDTH-1:0] mem [0:DEPTH-1];

    // Port A
    always @(posedge clka) begin
        if (wea) mem[addra] <= dina;
        douta <= mem[addra];
    end

    // Port B
    always @(posedge clkb) begin
        if (web) mem[addrb] <= dinb;
        doutb <= mem[addrb];
    end
endmodule

// =========================================================
// 4. 具体的 RAM 封装 (展开所有端口)
// =========================================================

module ram_dp_d1024_w96(
    input [9:0] addra, input [9:0] addrb, input clka, input clkb, 
    input [95:0] dina, input [95:0] dinb, input wea, input web, 
    output [95:0] douta, output [95:0] doutb
);
    RAM_generic_tdp #(.WIDTH(96), .DEPTH(1024)) inst_ram96 (
        .clka(clka), .wea(wea), .addra(addra), .dina(dina), .douta(douta),
        .clkb(clkb), .web(web), .addrb(addrb), .dinb(dinb), .doutb(doutb)
    );
endmodule

module ram_dp_d1024_w16(
    input [9:0] addra, input [9:0] addrb, input clka, input clkb, 
    input [15:0] dina, input [15:0] dinb, input wea, input web, 
    output [15:0] douta, output [15:0] doutb
);
    RAM_generic_tdp #(.WIDTH(16), .DEPTH(1024)) inst_ram16 (
        .clka(clka), .wea(wea), .addra(addra), .dina(dina), .douta(douta),
        .clkb(clkb), .web(web), .addrb(addrb), .dinb(dinb), .doutb(doutb)
    );
endmodule

// 如果 nat_top.v 中使用的是 wrapper 名字，这里做一个别名映射
module ram_dp_d1024_w96_wrapper(
    input [9:0] addra, input [9:0] addrb, input clka, input clkb, 
    input [95:0] dina, input [95:0] dinb, input wea, input web, 
    output [95:0] douta, output [95:0] doutb, input [11:0] ram_dp_cfg_register
);
     ram_dp_d1024_w96 inst (
        .clka(clka), .wea(wea), .addra(addra), .dina(dina), .douta(douta),
        .clkb(clkb), .web(web), .addrb(addrb), .dinb(dinb), .doutb(doutb)
     );
endmodule

module ram_dp_d1024_w16_wrapper(
    input [9:0] addra, input [9:0] addrb, input clka, input clkb, 
    input [15:0] dina, input [15:0] dinb, input wea, input web, 
    output [15:0] douta, output [15:0] doutb, input [11:0] ram_dp_cfg_register
);
     ram_dp_d1024_w16 inst (
        .clka(clka), .wea(wea), .addra(addra), .dina(dina), .douta(douta),
        .clkb(clkb), .web(web), .addrb(addrb), .dinb(dinb), .doutb(doutb)
     );
endmodule
