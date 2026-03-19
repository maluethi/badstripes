/*
 * Copyright (c) 2024 Uri Shaked
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module power_calc (
  input  signed [9:0]      x,
  input  [1:0]             sel,
  output reg signed [16:0] result
);
  wire signed [16:0] sq   = x * x;
  wire signed [16:0] cube = sq * x;
  wire signed [16:0] quad = sq * sq;

  always @(*) begin
    case (sel)
      2'd0: result = sq;
      2'd1: result = cube;
      2'd2: result = quad;
      default: result = {{7{x[9]}}, x};
    endcase
  end
endmodule

module tt_um_maluei_badstripes(
  input  wire [7:0] ui_in,
  output wire [7:0] uo_out,
  input  wire [7:0] uio_in,
  output wire [7:0] uio_out,
  output wire [7:0] uio_oe,
  input  wire       ena,
  input  wire       clk,
  input  wire       rst_n
);

  // VGA signals
  wire hsync;
  wire vsync;
  wire [1:0] R;
  wire [1:0] G;
  wire [1:0] B;
  wire video_active;
  wire [9:0] pix_x;
  wire [9:0] pix_y;

  // Configuration
  wire [1:0] cfg_power_sel      = {ui_in[1], ui_in[0]};  // power function select
  wire       cfg_osc_x          = ui_in[2];               // enable x oscillation
  wire       cfg_osc_y          = ui_in[3];               // enable y oscillation
  wire       cfg_centred_y_mode = ui_in[4];               // truncated vs full centred_y
  wire       cfg_osc_x_speed    = ui_in[5];               // x osc speed: 0=fast 1=slow
  wire       cfg_osc_y_speed    = ui_in[6];               // y osc speed: 0=fast 1=slow
  // ui_in[7] free

  // TinyVGA PMOD
  assign uo_out = {hsync, B[0], G[0], R[0], vsync, B[1], G[1], R[1]};

  // Unused outputs assigned to 0
  assign uio_out = 0;
  assign uio_oe  = 0;

  reg [10:0] counter;

  // NCO: coupled accumulator oscillator — no LUT, just two adders
  // Traces a circle in (nco_x, nco_y) space
  // x' = x - y>>k,  y' = y + x>>k
  // shift amount controls speed: 6=fast, 7=medium, 8=slow
  reg signed [17:0] nco_x;
  reg signed [17:0] nco_y;

  wire [4:0] shift_x = cfg_osc_x_speed ? 5'd8 : 5'd6;
  wire [4:0] shift_y = cfg_osc_y_speed ? 5'd8 : 5'd6;

  // Per-axis shifted values for independent speed control
  wire signed [17:0] nco_x_delta = nco_y >>> shift_y;  // how much x changes (driven by y speed)
  wire signed [17:0] nco_y_delta = nco_x >>> shift_x;  // how much y changes (driven by x speed)

  always @(posedge vsync, negedge rst_n) begin
    if (~rst_n) begin
      nco_x <= 18'sh01000;  // non-zero initial condition
      nco_y <= 18'sh00000;
    end else begin
      nco_x <= nco_x - nco_x_delta;
      nco_y <= nco_y + nco_y_delta;
    end
  end

  // Use upper bits as oscillation offset (±127 pixel range)
  wire signed [9:0] osc_x = cfg_osc_x ? nco_x[16:7] : 10'sd0;
  wire signed [9:0] osc_y = cfg_osc_y ? nco_y[16:7] : 10'sd0;

  hvsync_generator hvsync_gen(
    .clk(clk),
    .reset(~rst_n),
    .hsync(hsync),
    .vsync(vsync),
    .display_on(video_active),
    .hpos(pix_x),
    .vpos(pix_y)
  );

  // centred_x/y: pixel position relative to screen centre plus oscillation
  wire signed [9:0] centred_x = $signed({1'b0, pix_x}) + 10'sd180 + osc_x;

  wire signed [9:0] centred_y_full  = $signed({1'b0, pix_y}) + 10'sd240 + osc_y;
  wire signed [1:0] centred_y_trunc = $signed({1'b0, pix_y}) + 10'sd240 + osc_y;
  wire signed [9:0] centred_y = cfg_centred_y_mode
                               ? {{8{centred_y_trunc[1]}}, centred_y_trunc}
                               : centred_y_full;

  wire signed [9:0] sq_in;
  wire signed [16:0] sq_out;
  reg  signed [16:0] centred_x_sq;
  reg  signed [16:0] centred_y_sq;

  assign sq_in = pix_x == 640 ? (pix_y == 524 ? -240 : centred_y + 1)
                               : (pix_x == 799 ? -2   : centred_x + 1);

  power_calc power_inst (
    .x      (sq_in),
    .sel    (cfg_power_sel),
    .result (sq_out)
  );

  always_ff @(posedge clk) begin
    if (pix_x == 640) begin
      centred_y_sq <= sq_out;
    end else begin
      centred_x_sq <= sq_out;
    end
  end

  wire signed [18:0] centre_dist_sq = $signed({2'b0, centred_x_sq})
                                    + $signed({2'b0, centred_y_sq});
  wire [18:0] offset = centre_dist_sq + {counter, 8'b0};

  assign R = video_active ? offset[12:11] : 2'b00;
  assign G = video_active ? offset[14:13] : 2'b00;
  assign B = video_active ? offset[16:15] : 2'b00;

  // Counter increments every vsync (once per frame)
  always @(posedge vsync, negedge rst_n) begin
    if (~rst_n) begin
      counter <= 0;
    end else begin
      counter <= counter + 1;
    end
  end

  // Suppress unused signals warning
  wire _unused_ok = &{ena, ui_in[7], uio_in, pix_y};

endmodule
