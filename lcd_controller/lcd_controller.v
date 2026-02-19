module lcd_controller(
    input wire clk,
    input wire rst_n,
    input wire submit, // submit 신호 추가
    input wire [7:0] ascii0,
    input wire [7:0] ascii1,
    input wire [7:0] ascii2,
    input wire [7:0] ascii3,
    input wire [7:0] ascii4,
    input wire [7:0] ascii5,
    input wire [7:0] ascii6,
    input wire [7:0] ascii7,
    input wire [7:0] ascii8,
    input wire [7:0] ascii9,
    input wire [7:0] ascii10,
    input wire [7:0] ascii11,
    input wire [7:0] ascii12,
    input wire [7:0] ascii13,
    input wire [7:0] ascii14,
    input wire [7:0] ascii15,
    output reg lcd_rs,
    output reg lcd_rw,
    output reg lcd_e,
    output reg [7:0] lcd_data
);

    // LCD 초기화 명령어
    reg [7:0] init_commands [0:2];
    integer i;
    reg [3:0] state; // 상태 머신
    reg [4:0] char_index; // 메시지 인덱스

    // 지연 카운터
    reg [15:0] delay_counter;
    parameter DELAY = 50000; // 클럭 주파수에 맞게 조정

    // 이전 submit 값을 저장하는 레지스터
    reg prev_submit;

    // LCD 명령어 초기화
    initial begin
        init_commands[0] = 8'h38; // Function set
        init_commands[1] = 8'h0C; // Display ON
        init_commands[2] = 8'h06; // Entry Mode Set
    end

    // ASCII 문자를 저장하는 배열
    reg [7:0] message [0:15];

    // 입력을 메시지 배열에 할당
    always @(*) begin
        message[0] = ascii0;
        message[1] = ascii1;
        message[2] = ascii2;
        message[3] = ascii3;
        message[4] = ascii4;
        message[5] = ascii5;
        message[6] = ascii6;
        message[7] = ascii7;
        message[8] = ascii8;
        message[9] = ascii9;
        message[10] = ascii10;
        message[11] = ascii11;
        message[12] = ascii12;
        message[13] = ascii13;
        message[14] = ascii14;
        message[15] = ascii15;
    end

    // 상태 머신
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= 0;
            char_index <= 0;
            i <= 0;
            delay_counter <= 0;
            lcd_e <= 0;
            prev_submit <= 0;
        end else begin
            prev_submit <= submit; // 이전 submit 값 저장
            case (state)
                0: begin
                    // 초기화 명령어 전송
                    if (i < 3) begin
                        if (delay_counter == 0) begin
                            lcd_rs <= 0;
                            lcd_rw <= 0;
                            lcd_data <= init_commands[i];
                            lcd_e <= 1;
                            delay_counter <= DELAY;
                            state <= 1;
                        end else begin
                            delay_counter <= delay_counter - 1;
                            lcd_e <= 0;
                        end
                    end else begin
                        state <= 2; // submit 대기 상태로 이동
                    end
                end
                1: begin
                    if (delay_counter == 0) begin
                        lcd_e <= 0;
                        i <= i + 1;
                        state <= 0;
                    end else begin
                        delay_counter <= delay_counter - 1;
                    end
                end
                2: begin
                    // submit 신호의 상승 에지 대기
                    if (submit && !prev_submit) begin
                        // submit의 상승 에지 감지
                        state <= 3; // 클리어 디스플레이 상태로 이동
                    end
                end
                3: begin
                    // 클리어 디스플레이 명령어 전송
                    if (delay_counter == 0) begin
                        lcd_rs <= 0;
                        lcd_rw <= 0;
                        lcd_data <= 8'h01; // Clear Display
                        lcd_e <= 1;
                        delay_counter <= DELAY * 2; // 클리어 후 지연
                        state <= 4;
                    end else begin
                        delay_counter <= delay_counter - 1;
                        lcd_e <= 0;
                    end
                end
                4: begin
                    if (delay_counter == 0) begin
                        lcd_e <= 0;
                        char_index <= 0;
                        state <= 5;
                    end else begin
                        delay_counter <= delay_counter - 1;
                    end
                end
                5: begin
                    // 메시지 표시
                    if (char_index < 16) begin
                        if (delay_counter == 0) begin
                            lcd_rs <= 1;
                            lcd_rw <= 0;
                            lcd_data <= message[char_index];
                            lcd_e <= 1;
                            delay_counter <= DELAY;
                            state <= 6;
                        end else begin
                            delay_counter <= delay_counter - 1;
                            lcd_e <= 0;
                        end
                    end else begin
                        state <= 2; // submit 대기 상태로 이동
                    end
                end
                6: begin
                    if (delay_counter == 0) begin
                        lcd_e <= 0;
                        char_index <= char_index + 1;
                        state <= 5;
                    end else begin
                        delay_counter <= delay_counter - 1;
                    end
                end
                default: state <= 2; // 기본적으로 submit 대기 상태
            endcase
        end
    end
endmodule
