// top_define.v
// 定义全局参数和地址映射

`ifndef TOP_DEFINE_H
`define TOP_DEFINE_H

// =========================================================
// CPU 寄存器地址映射 (根据代码中的 np_cpu_addr 推断)
// =========================================================

// NAT 映射计数器地址 (在 avail_ppool.v 中使用)
// 代码逻辑: case(np_cpu_addr_d1[8:0]) ... ADDR_NAT_MAP_CNT
`define ADDR_NAT_MAP_CNT           9'h001

// NAT 覆盖冷却时间配置地址 (在 nat_top.v 中使用)
// 代码逻辑: case(np_cpu_addr_d1[8:0]) ... ADDR_NAT_COVER_CD_TIME
`define ADDR_NAT_COVER_CD_TIME     9'h002

// Outbound 表 CPU 读写地址范围 (在 nat_top.v 中使用)
// 代码逻辑: np_cpu_addr[16:10] >= HEAD && < TAIL
// 这是一个地址窗口，CPU通过这个窗口向RAM写数据
`define NAT_OUTBOUND_HEAD_BASE_ADDR 7'h00
`define NAT_OUTBOUND_TAIL_BASE_ADDR 7'h40  // 覆盖一定范围即可

// =========================================================
// 调试与仿真宏
// =========================================================

// 如果没有定义 ASIC，通常默认为 FPGA 环境
// `define ASIC 

// 如果不需要 CPU 接口，可以打开这个宏
// `define NO_CPU_MODE

// 打开仿真打印
`define SIM

`endif
