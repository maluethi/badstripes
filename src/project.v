/*
 * Copyright (c) 2024 M.Lueth
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module power_calc (
  input  signed [9:0]      x,
  input  [1:0]             sel,
  output reg signed [16:0] result
);
  always @(*) begin
    case (sel)
      2'd0: result = x * x;
      2'd1: result = x * x * x;
      2'd2: result = x * x * x * x;
      default: result = x;
    endcase
  end
endmodule


module sincos_lut (
  input  [7:0]        angle,
  output signed [7:0] sin_out,
  output signed [7:0] cos_out
);
  function signed [7:0] sin_lut(input [7:0] i);
    case (i)
      8'd0: sin_lut=8'sd0; 8'd1: sin_lut=8'sd3; 8'd2: sin_lut=8'sd6; 8'd3: sin_lut=8'sd9;
      8'd4: sin_lut=8'sd12; 8'd5: sin_lut=8'sd16; 8'd6: sin_lut=8'sd19; 8'd7: sin_lut=8'sd22;
      8'd8: sin_lut=8'sd25; 8'd9: sin_lut=8'sd28; 8'd10: sin_lut=8'sd31; 8'd11: sin_lut=8'sd34;
      8'd12: sin_lut=8'sd37; 8'd13: sin_lut=8'sd40; 8'd14: sin_lut=8'sd43; 8'd15: sin_lut=8'sd46;
      8'd16: sin_lut=8'sd49; 8'd17: sin_lut=8'sd51; 8'd18: sin_lut=8'sd54; 8'd19: sin_lut=8'sd57;
      8'd20: sin_lut=8'sd60; 8'd21: sin_lut=8'sd63; 8'd22: sin_lut=8'sd65; 8'd23: sin_lut=8'sd68;
      8'd24: sin_lut=8'sd71; 8'd25: sin_lut=8'sd73; 8'd26: sin_lut=8'sd76; 8'd27: sin_lut=8'sd78;
      8'd28: sin_lut=8'sd81; 8'd29: sin_lut=8'sd83; 8'd30: sin_lut=8'sd85; 8'd31: sin_lut=8'sd88;
      8'd32: sin_lut=8'sd90; 8'd33: sin_lut=8'sd92; 8'd34: sin_lut=8'sd94; 8'd35: sin_lut=8'sd96;
      8'd36: sin_lut=8'sd98; 8'd37: sin_lut=8'sd100; 8'd38: sin_lut=8'sd102; 8'd39: sin_lut=8'sd104;
      8'd40: sin_lut=8'sd106; 8'd41: sin_lut=8'sd107; 8'd42: sin_lut=8'sd109; 8'd43: sin_lut=8'sd111;
      8'd44: sin_lut=8'sd112; 8'd45: sin_lut=8'sd113; 8'd46: sin_lut=8'sd115; 8'd47: sin_lut=8'sd116;
      8'd48: sin_lut=8'sd117; 8'd49: sin_lut=8'sd118; 8'd50: sin_lut=8'sd120; 8'd51: sin_lut=8'sd121;
      8'd52: sin_lut=8'sd122; 8'd53: sin_lut=8'sd122; 8'd54: sin_lut=8'sd123; 8'd55: sin_lut=8'sd124;
      8'd56: sin_lut=8'sd125; 8'd57: sin_lut=8'sd125; 8'd58: sin_lut=8'sd126; 8'd59: sin_lut=8'sd126;
      8'd60: sin_lut=8'sd126; 8'd61: sin_lut=8'sd127; 8'd62: sin_lut=8'sd127; 8'd63: sin_lut=8'sd127;
      8'd64: sin_lut=8'sd127; 8'd65: sin_lut=8'sd127; 8'd66: sin_lut=8'sd127; 8'd67: sin_lut=8'sd126;
      8'd68: sin_lut=8'sd126; 8'd69: sin_lut=8'sd126; 8'd70: sin_lut=8'sd125; 8'd71: sin_lut=8'sd125;
      8'd72: sin_lut=8'sd124; 8'd73: sin_lut=8'sd123; 8'd74: sin_lut=8'sd122; 8'd75: sin_lut=8'sd122;
      8'd76: sin_lut=8'sd121; 8'd77: sin_lut=8'sd120; 8'd78: sin_lut=8'sd118; 8'd79: sin_lut=8'sd117;
      8'd80: sin_lut=8'sd116; 8'd81: sin_lut=8'sd115; 8'd82: sin_lut=8'sd113; 8'd83: sin_lut=8'sd112;
      8'd84: sin_lut=8'sd111; 8'd85: sin_lut=8'sd109; 8'd86: sin_lut=8'sd107; 8'd87: sin_lut=8'sd106;
      8'd88: sin_lut=8'sd104; 8'd89: sin_lut=8'sd102; 8'd90: sin_lut=8'sd100; 8'd91: sin_lut=8'sd98;
      8'd92: sin_lut=8'sd96; 8'd93: sin_lut=8'sd94; 8'd94: sin_lut=8'sd92; 8'd95: sin_lut=8'sd90;
      8'd96: sin_lut=8'sd88; 8'd97: sin_lut=8'sd85; 8'd98: sin_lut=8'sd83; 8'd99: sin_lut=8'sd81;
      8'd100: sin_lut=8'sd78; 8'd101: sin_lut=8'sd76; 8'd102: sin_lut=8'sd73; 8'd103: sin_lut=8'sd71;
      8'd104: sin_lut=8'sd68; 8'd105: sin_lut=8'sd65; 8'd106: sin_lut=8'sd63; 8'd107: sin_lut=8'sd60;
      8'd108: sin_lut=8'sd57; 8'd109: sin_lut=8'sd54; 8'd110: sin_lut=8'sd51; 8'd111: sin_lut=8'sd49;
      8'd112: sin_lut=8'sd46; 8'd113: sin_lut=8'sd43; 8'd114: sin_lut=8'sd40; 8'd115: sin_lut=8'sd37;
      8'd116: sin_lut=8'sd34; 8'd117: sin_lut=8'sd31; 8'd118: sin_lut=8'sd28; 8'd119: sin_lut=8'sd25;
      8'd120: sin_lut=8'sd22; 8'd121: sin_lut=8'sd19; 8'd122: sin_lut=8'sd16; 8'd123: sin_lut=8'sd12;
      8'd124: sin_lut=8'sd9; 8'd125: sin_lut=8'sd6; 8'd126: sin_lut=8'sd3; 8'd127: sin_lut=8'sd0;
      8'd128: sin_lut=-8'sd1; 8'd129: sin_lut=-8'sd4; 8'd130: sin_lut=-8'sd7; 8'd131: sin_lut=-8'sd10;
      8'd132: sin_lut=-8'sd13; 8'd133: sin_lut=-8'sd16; 8'd134: sin_lut=-8'sd19; 8'd135: sin_lut=-8'sd22;
      8'd136: sin_lut=-8'sd25; 8'd137: sin_lut=-8'sd28; 8'd138: sin_lut=-8'sd31; 8'd139: sin_lut=-8'sd34;
      8'd140: sin_lut=-8'sd37; 8'd141: sin_lut=-8'sd40; 8'd142: sin_lut=-8'sd43; 8'd143: sin_lut=-8'sd46;
      8'd144: sin_lut=-8'sd49; 8'd145: sin_lut=-8'sd51; 8'd146: sin_lut=-8'sd54; 8'd147: sin_lut=-8'sd57;
      8'd148: sin_lut=-8'sd60; 8'd149: sin_lut=-8'sd63; 8'd150: sin_lut=-8'sd65; 8'd151: sin_lut=-8'sd68;
      8'd152: sin_lut=-8'sd71; 8'd153: sin_lut=-8'sd73; 8'd154: sin_lut=-8'sd76; 8'd155: sin_lut=-8'sd78;
      8'd156: sin_lut=-8'sd81; 8'd157: sin_lut=-8'sd83; 8'd158: sin_lut=-8'sd85; 8'd159: sin_lut=-8'sd88;
      8'd160: sin_lut=-8'sd90; 8'd161: sin_lut=-8'sd92; 8'd162: sin_lut=-8'sd94; 8'd163: sin_lut=-8'sd96;
      8'd164: sin_lut=-8'sd98; 8'd165: sin_lut=-8'sd100; 8'd166: sin_lut=-8'sd102; 8'd167: sin_lut=-8'sd104;
      8'd168: sin_lut=-8'sd106; 8'd169: sin_lut=-8'sd107; 8'd170: sin_lut=-8'sd109; 8'd171: sin_lut=-8'sd111;
      8'd172: sin_lut=-8'sd112; 8'd173: sin_lut=-8'sd113; 8'd174: sin_lut=-8'sd115; 8'd175: sin_lut=-8'sd116;
      8'd176: sin_lut=-8'sd117; 8'd177: sin_lut=-8'sd118; 8'd178: sin_lut=-8'sd120; 8'd179: sin_lut=-8'sd121;
      8'd180: sin_lut=-8'sd122; 8'd181: sin_lut=-8'sd122; 8'd182: sin_lut=-8'sd123; 8'd183: sin_lut=-8'sd124;
      8'd184: sin_lut=-8'sd125; 8'd185: sin_lut=-8'sd125; 8'd186: sin_lut=-8'sd126; 8'd187: sin_lut=-8'sd126;
      8'd188: sin_lut=-8'sd126; 8'd189: sin_lut=-8'sd127; 8'd190: sin_lut=-8'sd127; 8'd191: sin_lut=-8'sd127;
      8'd192: sin_lut=-8'sd127; 8'd193: sin_lut=-8'sd127; 8'd194: sin_lut=-8'sd127; 8'd195: sin_lut=-8'sd126;
      8'd196: sin_lut=-8'sd126; 8'd197: sin_lut=-8'sd126; 8'd198: sin_lut=-8'sd125; 8'd199: sin_lut=-8'sd125;
      8'd200: sin_lut=-8'sd124; 8'd201: sin_lut=-8'sd123; 8'd202: sin_lut=-8'sd122; 8'd203: sin_lut=-8'sd122;
      8'd204: sin_lut=-8'sd121; 8'd205: sin_lut=-8'sd120; 8'd206: sin_lut=-8'sd118; 8'd207: sin_lut=-8'sd117;
      8'd208: sin_lut=-8'sd116; 8'd209: sin_lut=-8'sd115; 8'd210: sin_lut=-8'sd113; 8'd211: sin_lut=-8'sd112;
      8'd212: sin_lut=-8'sd111; 8'd213: sin_lut=-8'sd109; 8'd214: sin_lut=-8'sd107; 8'd215: sin_lut=-8'sd106;
      8'd216: sin_lut=-8'sd104; 8'd217: sin_lut=-8'sd102; 8'd218: sin_lut=-8'sd100; 8'd219: sin_lut=-8'sd98;
      8'd220: sin_lut=-8'sd96; 8'd221: sin_lut=-8'sd94; 8'd222: sin_lut=-8'sd92; 8'd223: sin_lut=-8'sd90;
      8'd224: sin_lut=-8'sd88; 8'd225: sin_lut=-8'sd85; 8'd226: sin_lut=-8'sd83; 8'd227: sin_lut=-8'sd81;
      8'd228: sin_lut=-8'sd78; 8'd229: sin_lut=-8'sd76; 8'd230: sin_lut=-8'sd73; 8'd231: sin_lut=-8'sd71;
      8'd232: sin_lut=-8'sd68; 8'd233: sin_lut=-8'sd65; 8'd234: sin_lut=-8'sd63; 8'd235: sin_lut=-8'sd60;
      8'd236: sin_lut=-8'sd57; 8'd237: sin_lut=-8'sd54; 8'd238: sin_lut=-8'sd51; 8'd239: sin_lut=-8'sd49;
      8'd240: sin_lut=-8'sd46; 8'd241: sin_lut=-8'sd43; 8'd242: sin_lut=-8'sd40; 8'd243: sin_lut=-8'sd37;
      8'd244: sin_lut=-8'sd34; 8'd245: sin_lut=-8'sd31; 8'd246: sin_lut=-8'sd28; 8'd247: sin_lut=-8'sd25;
      8'd248: sin_lut=-8'sd22; 8'd249: sin_lut=-8'sd19; 8'd250: sin_lut=-8'sd16; 8'd251: sin_lut=-8'sd12;
      8'd252: sin_lut=-8'sd9; 8'd253: sin_lut=-8'sd6; 8'd254: sin_lut=-8'sd3; 8'd255: sin_lut=-8'sd1;
      default: sin_lut = 8'sd0;
    endcase
  endfunction

  assign sin_out = sin_lut(angle);
  assign cos_out = sin_lut(angle + 8'd64);

endmodule


module tt_um_liamolucko_vga(
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

  // Sin/cos oscillators with independent speed control
  wire signed [7:0] sin_val;
  wire signed [7:0] cos_val;

  sincos_lut sincos_inst_x (
    .angle   (cfg_osc_x_speed ? counter[8:1] : counter[7:0]),
    .sin_out (sin_val),
    .cos_out ()
  );

  sincos_lut sincos_inst_y (
    .angle   (cfg_osc_y_speed ? counter[9:2] : counter[8:1]),
    .sin_out (cos_val),
    .cos_out ()
  );

  hvsync_generator hvsync_gen(
    .clk(clk),
    .reset(~rst_n),
    .hsync(hsync),
    .vsync(vsync),
    .display_on(video_active),
    .hpos(pix_x),
    .vpos(pix_y)
  );

  // Oscillating offsets — sign-extend 8-bit sin/cos to 10-bit, gated by cfg
  wire signed [9:0] osc_x = cfg_osc_x ? {{2{sin_val[7]}}, sin_val} : 10'sd0;
  wire signed [9:0] osc_y = cfg_osc_y ? {{2{cos_val[7]}}, cos_val} : 10'sd0;

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

  wire signed [18:0] centre_dist_sq = $signed({2'b0, centred_x_sq}) + $signed({2'b0, centred_y_sq});
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
