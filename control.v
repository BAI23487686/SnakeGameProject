module control(
    input             clk       ,   //VGA驱动时钟
    input             rstn      ,   //复位信号
    input             up        ,
    input             down      ,
    input             right     ,
    input             left      ,
    input      [10:0] pixel_xpos,
    input      [10:0] pixel_ypos,
    output reg [15:0] pixel_data 
);

reg  start;
wire die;
reg  die_state;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            start <= 0;
        end else if(right && !die_state)begin
            start <= 1;
        end else if(die)begin
            start <= 0;
        end else begin
            start <= start;
        end
    end
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            die_state <= 0;
        end else if(die)begin
            die_state <= 1;
        end else if(right)begin
            die_state <= 0;
        end else begin
            die_state <= die_state;
        end
    end
wire [15:0] pixel_start;
wire [15:0] pixel_game;
wire [15:0] pixel_win;
wire [15:0] pixel_fail;
wire [9:0]  second;
wire [10:0] length;
G_start G_start(
    .clk          (clk        ),  //input             clk        ,   //VGA驱动时钟
    .rstn         (rstn       ),  //input             rstn       ,   //复位信号
    .pixel_xpos   (pixel_xpos ),  //input      [10:0] pixel_xpos ,
    .pixel_ypos   (pixel_ypos ),  //input      [10:0] pixel_ypos ,
    .pixel_start  (pixel_start)   //output reg [15:0] pixel_start 
);
G_game G_game(
    .clk         (clk       ),  //input             clk       ,   //VGA驱动时钟
    .rstn        (rstn      ),  //input             rstn      ,   //复位信号
    .up          (up        ),  //input             up        ,
    .down        (down      ),  //input             down      ,
    .right       (right     ),  //input             right     ,
    .left        (left      ),  //input             left      ,
    .start       (start     ),  //input             start     ,
    .die_state   (die_state ),  //input             die_state ,
    .pixel_xpos  (pixel_xpos),  //input      [10:0] pixel_xpos,
    .pixel_ypos  (pixel_ypos),  //input      [10:0] pixel_ypos,
    .second      (second    ),  //output reg [9:0]  second    ,
    .length      (length    ),  //output reg [10:0] length    ,
    .die         (die       ),  //output reg        die       ,
    .pixel_game  (pixel_game)   //output reg [15:0] pixel_game 
);
G_fail G_fail(
    .clk         (clk       ),  //input             clk        ,   //VGA驱动时钟
    .rstn        (rstn      ),  //input             rstn       ,   //复位信号
    .pixel_xpos  (pixel_xpos),  //input      [10:0] pixel_xpos ,
    .pixel_ypos  (pixel_ypos),  //input      [10:0] pixel_ypos ,
    .second      (second    ),  //input      [9:0]  second     ,
    .length      (length    ),  //input      [10:0] length     ,
    .pixel_fail  (pixel_fail)   //output reg [15:0] pixel_fail   
);
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            pixel_data <= 0;
        end else if(die_state)begin
            pixel_data <= pixel_fail;
        end else if(!start)begin
            pixel_data <= pixel_start;
        end else begin
            pixel_data <= pixel_game;
        end
    end

endmodule
