module cnt_strike_ball (
    input [15:0] random_num,    // 16-bit random number
    input [3:0] Reg_1,          // Input number digits
    input [3:0] Reg_2,
    input [3:0] Reg_3,
    input [3:0] Reg_4,
    output reg [2:0] STRIKE,    // Strike count (3 bits)
    output reg [2:0] BALL       // Ball count
);
    integer i, j;

    // Split the random number into digits
    reg [3:0] random_digits [0:3];
    reg [3:0] input_digits [0:3];

    reg [3:0] random_matched;
    reg [3:0] input_matched;

    always @(*) begin
        // Initialize counts
        STRIKE = 3'd0;
        BALL = 3'd0;
        random_matched = 4'b0000;
        input_matched = 4'b0000;

        // Extract random digits
        random_digits[0] = random_num[15:12];
        random_digits[1] = random_num[11:8];
        random_digits[2] = random_num[7:4];
        random_digits[3] = random_num[3:0];

        // Store input digits
        input_digits[0] = Reg_1;
        input_digits[1] = Reg_2;
        input_digits[2] = Reg_3;
        input_digits[3] = Reg_4;

        // Calculate STRIKEs
        for (i = 0; i < 4; i = i + 1) begin
            if (random_digits[i] == input_digits[i]) begin
                STRIKE = STRIKE + 1;
                random_matched[i] = 1'b1;
                input_matched[i] = 1'b1;
            end
        end

        // Calculate BALLs
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                if (i != j && random_digits[i] == input_digits[j] && 
                    !random_matched[i] && !input_matched[j]) begin
                    BALL = BALL + 1;
                    random_matched[i] = 1'b1;
                    input_matched[j] = 1'b1;
                end
            end
        end
    end
endmodule
