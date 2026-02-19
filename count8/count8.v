module count8(
    input wire clk,
    input wire rst_n,
    output wire Q0,
    output wire Q1,
    output wire Q2
);
    reg [2:0] count;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 3'b000;
        else
            count <= count + 1;
    end
    
    assign Q0 = count[0];
    assign Q1 = count[1];
    assign Q2 = count[2];
endmodule
