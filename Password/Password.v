module Password(
    input wire clk,
    input wire gen_enable,
    input wire rst_n,
    input wire submit, // 새로운 입력 추가
    input wire [3:0] Reg_1,
    input wire [3:0] Reg_2,
    input wire [3:0] Reg_3,
    input wire [3:0] Reg_4,
    output reg correct, // reg 타입으로 변경
    output reg [2:0] STRIKE, // reg 타입으로 변경
    output reg [2:0] BALL, // reg 타입으로 변경
    output wire [15:0] pwd_key
);

    wire [3:0] First;
    wire [3:0] Second;
    wire [3:0] Three;
    wire [3:0] Four;
    wire [15:0] rnd;
    wire [2:0] current_STRIKE;
    wire [2:0] current_BALL;

    // 랜덤 넘버 생성기 인스턴스화
    RandomNumberGenerator rng_inst(
        .clk(clk),
        .rst_n(rst_n),
        .gen_enable(gen_enable),
        .rnd(rnd)
    );

    // pwd_key 출력에 랜덤 숫자 할당
    assign pwd_key = rnd;

    // 입력 숫자 매핑
    assign First = Reg_1;
    assign Second = Reg_2;
    assign Three = Reg_3;
    assign Four = Reg_4;

    // cnt_strike_ball 모듈 인스턴스화
    cnt_strike_ball game_inst(
        .random_num(rnd),
        .Reg_1(First),
        .Reg_2(Second),
        .Reg_3(Three),
        .Reg_4(Four),
        .STRIKE(current_STRIKE),
        .BALL(current_BALL)
    );

    // submit이 1일 때만 출력 업데이트
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            STRIKE <= 3'd0;
            BALL <= 3'd0;
            correct <= 1'b0;
        end else if (submit) begin
            STRIKE <= current_STRIKE;
            BALL <= current_BALL;
            correct <= (current_STRIKE == 3'd4);
        end
        // submit이 0이면 이전 값 유지
    end

endmodule
