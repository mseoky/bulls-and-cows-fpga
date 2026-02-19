module digits_to_ascii(
    input wire [2:0] strike_count,  // 3-bit strike count
    input wire [2:0] ball_count,    // 3-bit ball count
    output reg [7:0] ascii0,
    output reg [7:0] ascii1,
    output reg [7:0] ascii2,
    output reg [7:0] ascii3,
    output reg [7:0] ascii4,
    output reg [7:0] ascii5,
    output reg [7:0] ascii6,
    output reg [7:0] ascii7,
    output reg [7:0] ascii8,
    output reg [7:0] ascii9,
    output reg [7:0] ascii10,
    output reg [7:0] ascii11,
    output reg [7:0] ascii12,
    output reg [7:0] ascii13,
    output reg [7:0] ascii14,
    output reg [7:0] ascii15
);

    always @(*) begin
        // 모든 출력을 공백 문자로 초기화
        ascii0 = 8'h20; // ' '
        ascii1 = 8'h20;
        ascii2 = 8'h20;
        ascii3 = 8'h20;
        ascii4 = 8'h20;
        ascii5 = 8'h20;
        ascii6 = 8'h20;
        ascii7 = 8'h20;
        ascii8 = 8'h20;
        ascii9 = 8'h20;
        ascii10 = 8'h20;
        ascii11 = 8'h20;
        ascii12 = 8'h20;
        ascii13 = 8'h20;
        ascii14 = 8'h20;
        ascii15 = 8'h20;

        // "STRIKE x"
        ascii0 = "S";
        ascii1 = "T";
        ascii2 = "R";
        ascii3 = "I";
        ascii4 = "K";
        ascii5 = "E";
        ascii6 = " ";
        ascii7 = 8'h30 + strike_count; // strike_count를 ASCII로 변환

        // "STRIKE x"와 "BALL y" 사이에 공백 추가
        ascii8 = " ";

        // "BALL y"
        ascii9 = "B";
        ascii10 = "A";
        ascii11 = "L";
        ascii12 = "L";
        ascii13 = " ";
        ascii14 = 8'h30 + ball_count; // ball_count를 ASCII로 변환
        // 남은 위치는 공백으로 유지
    end
endmodule
