module RandomNumberGenerator(
    input wire clk,           // 클럭 신호
    input wire rst_n,         // 리셋 신호 (0일 때 리셋)
    input wire gen_enable,    // 난수 출력 활성화 신호
    output reg [15:0] rnd     // 출력 난수 (4자리, 각 자리수 0~9)
);

    reg [15:0] rnd_internal;  // 내부 난수
    reg [3:0] available_digits[0:9]; // 사용 가능한 숫자 집합
    reg [3:0] digit1, digit2, digit3, digit4; // 각 자리수

    integer i;

    // LFSR 초기값
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            rnd_internal <= 16'hACE1;
        else
            rnd_internal <= {rnd_internal[14:0], rnd_internal[15] ^ rnd_internal[13] ^ rnd_internal[12] ^ rnd_internal[10]};
    end

    // 4자리 난수 생성
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rnd <= 16'h0000;
            for (i = 0; i < 10; i = i + 1) begin
                available_digits[i] <= i; // 0~9 초기화
            end
        end else if (gen_enable) begin
            // 사용 가능한 숫자 집합 초기화
            for (i = 0; i < 10; i = i + 1) begin
                available_digits[i] <= i;
            end

            // 첫 번째 자리
            digit1 = available_digits[rnd_internal[3:0] % 10];
            available_digits[digit1] = available_digits[9]; // 선택한 숫자 제거

            // 두 번째 자리
            digit2 = available_digits[rnd_internal[7:4] % 9];
            available_digits[digit2] = available_digits[8]; // 선택한 숫자 제거

            // 세 번째 자리
            digit3 = available_digits[rnd_internal[11:8] % 8];
            available_digits[digit3] = available_digits[7]; // 선택한 숫자 제거

            // 네 번째 자리
            digit4 = available_digits[rnd_internal[15:12] % 7];

            // 최종 난수 결합
            rnd <= {digit4, digit3, digit2, digit1};
        end
    end

endmodule
