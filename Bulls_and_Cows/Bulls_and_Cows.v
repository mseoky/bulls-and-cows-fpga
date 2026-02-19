module Bulls_and_Cows(
    input wire clk,
    input wire rst,
    input wire keypad_0,
    input wire keypad_1,
    input wire keypad_2,
    input wire keypad_3,
    input wire keypad_4,
    input wire keypad_5,
    input wire keypad_6,
    input wire keypad_7,
    input wire keypad_8,
    input wire keypad_9,
    input wire gen_enable,
    input wire submit, // 새로운 입력 추가
    output wire a,
    output wire b,
    output wire c,
    output wire d,
    output wire e,
    output wire f,
    output wire g,
    output wire com8,
    output wire com6,
    output wire com5,
    output wire com4,
    output wire com3,
    output wire com2,
    output wire com1,
    output wire piezo,
    output wire green_1,
    output wire green_2,
    output wire green_3,
    output wire green_4,
    output wire red_1,
    output wire red_2,
    output wire red_3,
    output wire red_4,
    output wire Motor_A,
    output wire Motor_B,
    output wire Motor_ANOT,
    output wire Motor_BNOT,
    output wire com7,
    output wire tlcd_d0,
    output wire tlcd_d1,
    output wire tlcd_d2,
    output wire tlcd_d3,
    output wire tlcd_d4,
    output wire tlcd_d5,
    output wire tlcd_d6,
    output wire tlcd_d7,
    output wire lcd_rs,
    output wire lcd_rw,
    output wire lcd_e
);

    // 내부 신호 선언
    wire [3:0] reg_line;
    wire SYNTHESIZED_WIRE_78;
    wire SYNTHESIZED_WIRE_1;
    wire SYNTHESIZED_WIRE_79;
    wire [3:0] SYNTHESIZED_WIRE_80;
    wire [3:0] SYNTHESIZED_WIRE_81;
    wire [15:0] SYNTHESIZED_WIRE_82;
    wire SYNTHESIZED_WIRE_83;
    wire [3:0] SYNTHESIZED_WIRE_84;
    wire [3:0] SYNTHESIZED_WIRE_85;
    wire SYNTHESIZED_WIRE_86;
    wire [3:0] SYNTHESIZED_WIRE_24;
    wire [3:0] SYNTHESIZED_WIRE_25;
    wire [3:0] SYNTHESIZED_WIRE_26;
    wire SYNTHESIZED_WIRE_87;
    wire SYNTHESIZED_WIRE_28;
    wire SYNTHESIZED_WIRE_29;
    wire SYNTHESIZED_WIRE_31;
    wire SYNTHESIZED_WIRE_33;
    wire SYNTHESIZED_WIRE_43;
    wire SYNTHESIZED_WIRE_44;
    wire SYNTHESIZED_WIRE_46;
    wire SYNTHESIZED_WIRE_48;
    wire SYNTHESIZED_WIRE_51;
    wire SYNTHESIZED_WIRE_52;
    wire SYNTHESIZED_WIRE_53;
    wire SYNTHESIZED_WIRE_54;
    wire SYNTHESIZED_WIRE_55;
    wire SYNTHESIZED_WIRE_88;
    wire SYNTHESIZED_WIRE_89;
    wire SYNTHESIZED_WIRE_61;
    wire SYNTHESIZED_WIRE_62;
    wire SYNTHESIZED_WIRE_64;
    wire SYNTHESIZED_WIRE_66;
    wire SYNTHESIZED_WIRE_76;
    wire [2:0] STRIKE;
    wire [2:0] BALL;

    // ASCII 문자용 와이어
    wire [7:0] ascii0;
    wire [7:0] ascii1;
    wire [7:0] ascii2;
    wire [7:0] ascii3;
    wire [7:0] ascii4;
    wire [7:0] ascii5;
    wire [7:0] ascii6;
    wire [7:0] ascii7;
    wire [7:0] ascii8;
    wire [7:0] ascii9;
    wire [7:0] ascii10;
    wire [7:0] ascii11;
    wire [7:0] ascii12;
    wire [7:0] ascii13;
    wire [7:0] ascii14;
    wire [7:0] ascii15;

    // 새로운 와이어와 레지스터 선언
    wire Q0, Q1, Q2;
    wire [2:0] count;
    reg [3:0] b_in;

    // lcd_data 버스 선언
    wire [7:0] lcd_data;

    // 3비트 카운터 인스턴스화
    count8 counter_inst(
        .clk(clk),
        .rst_n(SYNTHESIZED_WIRE_78),
        .Q0(Q0),
        .Q1(Q1),
        .Q2(Q2)
    );

    assign count = {Q2, Q1, Q0};

    // 멀티플렉싱 로직 조정
    always @(*) begin
        case (count)
            3'b000: b_in = SYNTHESIZED_WIRE_82[3:0];     // pwd_key 자릿수 1
            3'b001: b_in = SYNTHESIZED_WIRE_82[7:4];     // pwd_key 자릿수 2
            3'b010: b_in = SYNTHESIZED_WIRE_82[11:8];    // pwd_key 자릿수 3
            3'b011: b_in = SYNTHESIZED_WIRE_82[15:12];   // pwd_key 자릿수 4
            3'b100: b_in = SYNTHESIZED_WIRE_84;          // 키패드 입력 자릿수 1
            3'b101: b_in = SYNTHESIZED_WIRE_80;          // 키패드 입력 자릿수 2
            3'b110: b_in = SYNTHESIZED_WIRE_81;          // 키패드 입력 자릿수 3
            3'b111: b_in = SYNTHESIZED_WIRE_85;          // 키패드 입력 자릿수 4
            default: b_in = 4'b0000;
        endcase
    end

    // b2seg_bus 인스턴스 업데이트
    b2seg_bus b2v_inst17(
        .b_in(b_in),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g)
    );

    // com1부터 com8 신호 생성
    assign com1 = ~((~Q2) & (~Q1) & (~Q0));
    assign com2 = ~((~Q2) & (~Q1) & Q0);
    assign com3 = ~((~Q2) & Q1 & (~Q0));
    assign com4 = ~((~Q2) & Q1 & Q0);
    assign com5 = ~((Q2) & (~Q1) & (~Q0));
    assign com6 = ~((Q2) & (~Q1) & Q0);
    assign com7 = ~((Q2) & Q1 & (~Q0));
    assign com8 = ~((Q2) & Q1 & Q0);

    d2b b2v_inst(
        .d0(keypad_0),
        .d1(keypad_1),
        .d2(keypad_2),
        .d3(keypad_3),
        .d4(keypad_4),
        .d5(keypad_5),
        .d6(keypad_6),
        .d7(keypad_7),
        .d8(keypad_8),
        .d9(keypad_9),
        .b3(reg_line[3]),
        .b2(reg_line[2]),
        .b1(reg_line[1]),
        .b0(reg_line[0])
    );

    PNU_CLK_DIV b2v_inst1(
        .clk(clk),
        .rst_n(SYNTHESIZED_WIRE_78),
        .en(SYNTHESIZED_WIRE_1),
        .div_clk(SYNTHESIZED_WIRE_76)
    );
    defparam b2v_inst1.cnt_num = 10000;

    four_bit_reg_ce b2v_inst10(
        .ce(SYNTHESIZED_WIRE_79),
        .clk(clk),
        .rst_n(SYNTHESIZED_WIRE_78),
        .din(SYNTHESIZED_WIRE_80),
        .out(SYNTHESIZED_WIRE_81)
    );

    four_bit_reg_ce b2v_inst11(
        .ce(SYNTHESIZED_WIRE_79),
        .clk(clk),
        .rst_n(SYNTHESIZED_WIRE_78),
        .din(SYNTHESIZED_WIRE_81),
        .out(SYNTHESIZED_WIRE_85)
    );

    // digits_to_ascii 모듈 인스턴스화
    digits_to_ascii b2v_inst12(
        .strike_count(STRIKE),
        .ball_count(BALL),
        .ascii0(ascii0),
        .ascii1(ascii1),
        .ascii2(ascii2),
        .ascii3(ascii3),
        .ascii4(ascii4),
        .ascii5(ascii5),
        .ascii6(ascii6),
        .ascii7(ascii7),
        .ascii8(ascii8),
        .ascii9(ascii9),
        .ascii10(ascii10),
        .ascii11(ascii11),
        .ascii12(ascii12),
        .ascii13(ascii13),
        .ascii14(ascii14),
        .ascii15(ascii15)
    );

    // lcd_controller 모듈 인스턴스화
	lcd_controller b2v_inst13 (
		 .clk(clk),
		 .rst_n(SYNTHESIZED_WIRE_78),
		 .submit(submit), // submit 신호 연결
		 .ascii0(ascii0),
		 .ascii1(ascii1),
		 .ascii2(ascii2),
		 .ascii3(ascii3),
		 .ascii4(ascii4),
		 .ascii5(ascii5),
		 .ascii6(ascii6),
		 .ascii7(ascii7),
		 .ascii8(ascii8),
		 .ascii9(ascii9),
		 .ascii10(ascii10),
		 .ascii11(ascii11),
		 .ascii12(ascii12),
		 .ascii13(ascii13),
		 .ascii14(ascii14),
		 .ascii15(ascii15),
		 .lcd_rs(lcd_rs),
		 .lcd_rw(lcd_rw),
		 .lcd_e(lcd_e),
		 .lcd_data(lcd_data)
	);

    // lcd_data를 tlcd_d 출력에 매핑
    assign tlcd_d0 = lcd_data[0];
    assign tlcd_d1 = lcd_data[1];
    assign tlcd_d2 = lcd_data[2];
    assign tlcd_d3 = lcd_data[3];
    assign tlcd_d4 = lcd_data[4];
    assign tlcd_d5 = lcd_data[5];
    assign tlcd_d6 = lcd_data[6];
    assign tlcd_d7 = lcd_data[7];

    mx_4bit_2x1 b2v_inst14(
        .ce(SYNTHESIZED_WIRE_83),
        .s0(SYNTHESIZED_WIRE_84),
        .s1(SYNTHESIZED_WIRE_80),
        .m_out(SYNTHESIZED_WIRE_24)
    );

    mx_4bit_2x1 b2v_inst15(
        .ce(SYNTHESIZED_WIRE_83),
        .s0(SYNTHESIZED_WIRE_81),
        .s1(SYNTHESIZED_WIRE_85),
        .m_out(SYNTHESIZED_WIRE_25)
    );

    mx_4bit_2x1 b2v_inst16(
        .ce(SYNTHESIZED_WIRE_86),
        .s0(SYNTHESIZED_WIRE_24),
        .s1(SYNTHESIZED_WIRE_25),
        .m_out(SYNTHESIZED_WIRE_26)
    );

    assign SYNTHESIZED_WIRE_29 = keypad_0 | keypad_2 | keypad_1 | keypad_3 | keypad_5 | keypad_4 | keypad_6 | keypad_7;

    LED b2v_inst2(
        .Correct(SYNTHESIZED_WIRE_87),
        .Green1(green_1),
        .Green2(green_2),
        .Green3(green_3),
        .Green4(green_4),
        .Red1(red_1),
        .Red2(red_2),
        .Red3(red_3),
        .Red4(red_4)
    );

    assign SYNTHESIZED_WIRE_28 = keypad_9 | keypad_8;

    assign SYNTHESIZED_WIRE_55 = SYNTHESIZED_WIRE_28 | SYNTHESIZED_WIRE_29;

    assign SYNTHESIZED_WIRE_78 = ~rst;

    assign SYNTHESIZED_WIRE_88 = SYNTHESIZED_WIRE_87 ^ SYNTHESIZED_WIRE_31;

    assign SYNTHESIZED_WIRE_89 = SYNTHESIZED_WIRE_87 ^ SYNTHESIZED_WIRE_33;

    assign SYNTHESIZED_WIRE_43 = ~SYNTHESIZED_WIRE_83;

    assign SYNTHESIZED_WIRE_44 = ~SYNTHESIZED_WIRE_86;

    // Password 모듈 인스턴스 업데이트
    Password b2v_inst3(
        .clk(clk),
        .rst_n(SYNTHESIZED_WIRE_78),
        .gen_enable(gen_enable),
        .submit(submit),
        .Reg_1(SYNTHESIZED_WIRE_84),
        .Reg_2(SYNTHESIZED_WIRE_80),
        .Reg_3(SYNTHESIZED_WIRE_81),
        .Reg_4(SYNTHESIZED_WIRE_85),
        .correct(SYNTHESIZED_WIRE_87),
        .STRIKE(STRIKE),
        .BALL(BALL),
        .pwd_key(SYNTHESIZED_WIRE_82)
    );

    assign SYNTHESIZED_WIRE_46 = ~SYNTHESIZED_WIRE_86;

    assign SYNTHESIZED_WIRE_48 = ~SYNTHESIZED_WIRE_83;

    assign SYNTHESIZED_WIRE_51 = SYNTHESIZED_WIRE_43 & SYNTHESIZED_WIRE_44;

    assign SYNTHESIZED_WIRE_52 = SYNTHESIZED_WIRE_83 & SYNTHESIZED_WIRE_46;

    assign SYNTHESIZED_WIRE_53 = SYNTHESIZED_WIRE_86 & SYNTHESIZED_WIRE_48;

    assign SYNTHESIZED_WIRE_54 = SYNTHESIZED_WIRE_86 & SYNTHESIZED_WIRE_83;

    trigger b2v_inst4(
        .Din(SYNTHESIZED_WIRE_55),
        .CLK(clk),
        .rst_n(SYNTHESIZED_WIRE_78),
        .Dout(SYNTHESIZED_WIRE_79)
    );

    assign SYNTHESIZED_WIRE_61 = ~SYNTHESIZED_WIRE_88;

    assign SYNTHESIZED_WIRE_62 = ~SYNTHESIZED_WIRE_89;

    assign SYNTHESIZED_WIRE_64 = ~SYNTHESIZED_WIRE_89;

    assign SYNTHESIZED_WIRE_66 = ~SYNTHESIZED_WIRE_89;

    assign Motor_A = SYNTHESIZED_WIRE_61 & SYNTHESIZED_WIRE_62;

    assign Motor_B = SYNTHESIZED_WIRE_88 & SYNTHESIZED_WIRE_64;

    assign Motor_ANOT = SYNTHESIZED_WIRE_88 & SYNTHESIZED_WIRE_66;

    assign Motor_BNOT = SYNTHESIZED_WIRE_88 & SYNTHESIZED_WIRE_89;

    Piezo_module b2v_inst5(
        .clk(clk),
        .rst(SYNTHESIZED_WIRE_78),
        .Keypad0(keypad_0),
        .Keypad1(keypad_1),
        .Keypad2(keypad_2),
        .Keypad3(keypad_3),
        .Keypad4(keypad_4),
        .Keypad5(keypad_5),
        .Keypad6(keypad_6),
        .Keypad7(keypad_7),
        .Keypad8(keypad_8),
        .Keypad9(keypad_9),
        .Piezo(piezo)
    );

    count4 b2v_inst6(
        .clk(clk),
        .rst_n(SYNTHESIZED_WIRE_78),
        .Q0(SYNTHESIZED_WIRE_83),
        .Q1(SYNTHESIZED_WIRE_86)
    );

    four_bit_reg_ce b2v_inst7(
        .ce(SYNTHESIZED_WIRE_79),
        .clk(clk),
        .rst_n(SYNTHESIZED_WIRE_78),
        .din(reg_line),
        .out(SYNTHESIZED_WIRE_84)
    );

    four_bit_reg_ce b2v_inst8(
        .ce(SYNTHESIZED_WIRE_79),
        .clk(clk),
        .rst_n(SYNTHESIZED_WIRE_78),
        .din(SYNTHESIZED_WIRE_84),
        .out(SYNTHESIZED_WIRE_80)
    );

    count4 b2v_inst9(
        .clk(SYNTHESIZED_WIRE_76),
        .rst_n(SYNTHESIZED_WIRE_78),
        .Q0(SYNTHESIZED_WIRE_31),
        .Q1(SYNTHESIZED_WIRE_33)
    );

endmodule
