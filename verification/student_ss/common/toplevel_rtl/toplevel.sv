
module toplevel #(
    parameter                 APB_AW  = 32,
    parameter                 APB_DW  = 32
) (
    // Interface: APB
    input  logic [APB_AW-1:0] PADDR,
    input  logic              PENABLE,
    input  logic              PSEL,
    input  logic [APB_DW-1:0] PWDATA,
    input  logic              PWRITE,
    output logic [APB_DW-1:0] PRDATA,
    output logic              PREADY,
    output logic              PSLVERR,

    // Interface: Clock
    input  logic              clk_in,

    // Interface: IRQ
    output logic              irq,

    // Interface: Reset
    input  logic              reset_int,

    // Interface: ss_ctrl
    input logic              irq_en,
    input logic [7:0]        ss_ctrl,
    
    //Interface: GPIO pmod 0
    input  logic [3:0] pmod_0_gpi,
    output logic [3:0] pmod_0_gpo,
    output logic [3:0] pmod_0_gpio_oe,

    //Interface: GPIO pmod 1
    input  logic [3:0] pmod_1_gpi,
    output logic [3:0] pmod_1_gpo,
    output logic [3:0] pmod_1_gpio_oe
);

student_ss_1 student_ss_1(
    // Interface: APB
        .PADDR               (PADDR),
        .PENABLE             (PENABLE),
        .PSEL                (PSEL),
        .PWDATA              (PWDATA),
        .PWRITE              (PWRITE),
        .PRDATA              (PRDATA),
        .PREADY              (PREADY),
        .PSLVERR             (PSLVERR),
        // Interface: Clock
        .clk_in              (clk_in),
        // Interface: IRQ
        .irq_1               (irq),
        // Interface: Reset
        .reset_int           (reset_int),
        // Interface: pmod_gpio_0
        .pmod_0_gpi          (pmod_0_gpi),
        .pmod_0_gpio_oe      (pmod_0_gpio_oe),
        .pmod_0_gpo          (pmod_0_gpo),
        // Interface: pmod_gpio_1
        .pmod_1_gpi          (pmod_1_gpi),
        .pmod_1_gpio_oe      (pmod_1_gpio_oe),
        .pmod_1_gpo          (pmod_1_gpo),
        // Interface: ss_ctrl
        .irq_en_1            (irq_en),
        .ss_ctrl_1           (ss_ctrl)
    );

endmodule
