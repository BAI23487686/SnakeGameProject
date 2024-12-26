module G_fail(
    input             clk        ,   //VGA驱动时钟
    input             rstn       ,   //复位信号
    input      [10:0] pixel_xpos ,
    input      [10:0] pixel_ypos ,
    input      [9:0]  second     ,
    input      [10:0] length     ,
    output reg [15:0] pixel_fail   
);
wire [127:0] data1[10:0];
assign data1[0] = 128'h000000EE444428281010101010380000;//Y0
assign data1[1] = 128'h000000000000003C42424242423C0000;//o1
assign data1[2] = 128'h00000000000000C642424242463B0000;//u2
assign data1[3] = 128'h00602020400000000000000000000000;//'3
assign data1[4] = 128'h00000000000000EE3220202020F80000;//r4
assign data1[5] = 128'h000000000000003C42427E40423C0000;//e5
assign data1[6] = 128'h000000000602023E42424242463B0000;//d6
assign data1[7] = 128'h000000000000003C42427E40423C0000;//e7
assign data1[8] = 128'h0000000000000038440C34444C360000;//a8
assign data1[9] = 128'h000000000602023E42424242463B0000;//d9
assign data1[10] = 128'h00000010101010101010000010100000;//!10
wire [127:0] data2[10:0];
assign data2[0] = 128'h000000FE921010101010101010380000;//T0
assign data2[1] = 128'h000000303000007010101010107C0000;//i1
assign data2[2] = 128'h00000000000000FE4949494949ED0000;//m2
assign data2[3] = 128'h000000000000003C42427E40423C0000;//e3
assign data2[4] = 128'h00000000000018180000000018180000;//:4
assign data2[5] = 128'h0000003E4242402018040242427C0000;//S5
assign data2[6] = 128'h000000000000001C22404040221C0000;//c6
assign data2[7] = 128'h000000000000003C42424242423C0000;//o7
assign data2[8] = 128'h00000000000000EE3220202020F80000;//r8
assign data2[9] = 128'h000000000000003C42427E40423C0000;//e9
assign data2[10] = 128'h00000000000018180000000018180000;//:10

wire [127:0] digital[9:0];
assign digital[0] = 128'h00000018244242424242424224180000;//0
assign digital[1] = 128'h000000083808080808080808083E0000;//1
assign digital[2] = 128'h0000003C4242420204081020427E0000;//2
assign digital[3] = 128'h0000003C4242020418040242423C0000;//3
assign digital[4] = 128'h000000040C0C142424447F04041F0000;//4
assign digital[5] = 128'h0000007E404040784402024244380000;//5
assign digital[6] = 128'h000000182440405C62424242221C0000;//6
assign digital[7] = 128'h0000007E420404080810101010100000;//7
assign digital[8] = 128'h0000003C4242422418244242423C0000;//8
assign digital[9] = 128'h0000003844424242463A020224180000;//9

reg [3:0] data_1;
reg [3:0] data_2;
reg [3:0] data_3;
reg [3:0] data_4;
reg [3:0] data_5;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            data_1 <= 0;
            data_2 <= 0;
            data_3 <= 0;
            data_4 <= 0;
            data_5 <= 0;
        end else begin
            data_1 <= second/100%10;
            data_2 <= second/10%10;
            data_3 <= second%10;
            data_4 <= length/10;
            data_5 <= length%10;
        end
    end
wire [10:0] xpos;
wire [10:0] ypos;
assign xpos = pixel_xpos[10:2];
assign ypos = pixel_ypos[10:2];
wire [10:0] xpos2;
wire [10:0] ypos2;
assign xpos2 = pixel_xpos[10:2];
assign ypos2 = pixel_ypos[10:2];
parameter x1 = 40;
parameter y1 = 15;
parameter x2 = 56;
parameter y2 = 32;

parameter color_back   = 16'hFFFF;
parameter color_words1 = 16'h1234;
parameter color_words2 = 16'h5678;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            pixel_fail <= color_back;
        end else if(xpos>=x1 && xpos<x1+8 && ypos>=y1 && ypos<y1+16)begin
            pixel_fail <= (data1[0][(16+y1-ypos)*8 - ((xpos-x1)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+8 && xpos<x1+16 && ypos>=y1 && ypos<y1+16)begin
            pixel_fail <= (data1[1][(16+y1-ypos)*8 - ((xpos-x1-8)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+16 && xpos<x1+24 && ypos>=y1 && ypos<y1+16)begin
            pixel_fail <= (data1[2][(16+y1-ypos)*8 - ((xpos-x1-16)%8)-1]) ? color_words1 : color_back; 
        end else if(xpos>=x1+24 && xpos<x1+32 && ypos>=y1 && ypos<y1+16)begin
            pixel_fail <= (data1[3][(16+y1-ypos)*8 - ((xpos-x1-24)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+32 && xpos<x1+40 && ypos>=y1 && ypos<y1+16)begin
            pixel_fail <= (data1[4][(16+y1-ypos)*8 - ((xpos-x1-32)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+40 && xpos<x1+48 && ypos>=y1 && ypos<y1+16)begin
            pixel_fail <= (data1[5][(16+y1-ypos)*8 - ((xpos-x1-40)%8)-1]) ? color_words1 : color_back;
            
        end else if(xpos>=x1+56 && xpos<x1+64 && ypos>=y1 && ypos<y1+16)begin
            pixel_fail <= (data1[6][(16+y1-ypos)*8 - ((xpos-x1-56)%8)-1]) ? color_words1 : color_back; 
        end else if(xpos>=x1+64 && xpos<x1+72 && ypos>=y1 && ypos<y1+16)begin
            pixel_fail <= (data1[7][(16+y1-ypos)*8 - ((xpos-x1-64)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+72 && xpos<x1+80 && ypos>=y1 && ypos<y1+16)begin
            pixel_fail <= (data1[8][(16+y1-ypos)*8 - ((xpos-x1-72)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+80 && xpos<x1+88 && ypos>=y1 && ypos<y1+16)begin
            pixel_fail <= (data1[9][(16+y1-ypos)*8 - ((xpos-x1-80)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+88 && xpos<x1+96 && ypos>=y1 && ypos<y1+16)begin
            pixel_fail <= (data1[10][(16+y1-ypos)*8 - ((xpos-x1-88)%8)-1]) ? color_words1 : color_back;

        end else if(xpos>=x2 && xpos<x2+8 && ypos>=y2 && ypos<y2+16)begin
            pixel_fail <= (data2[0][(16+y2-ypos)*8 - ((xpos-x2)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+8 && xpos<x2+16 && ypos>=y2 && ypos<y2+16)begin
            pixel_fail <= (data2[1][(16+y2-ypos)*8 - ((xpos-x2-8)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+16 && xpos<x2+24 && ypos>=y2 && ypos<y2+16)begin
            pixel_fail <= (data2[2][(16+y2-ypos)*8 - ((xpos-x2-16)%8)-1]) ? color_words2 : color_back; 
        end else if(xpos>=x2+24 && xpos<x2+32 && ypos>=y2 && ypos<y2+16)begin
            pixel_fail <= (data2[3][(16+y2-ypos)*8 - ((xpos-x2-24)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+32 && xpos<x2+40 && ypos>=y2 && ypos<y2+16)begin
            pixel_fail <= (data2[4][(16+y2-ypos)*8 - ((xpos-x2-32)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+40 && xpos<x2+48 && ypos>=y2 && ypos<y2+16)begin
            pixel_fail <= (digital[data_1][(16+y2-ypos)*8 - ((xpos-x2-40)%8)-1]) ? color_words2 : color_back; 
        end else if(xpos>=x2+48 && xpos<x2+56 && ypos>=y2 && ypos<y2+16)begin
            pixel_fail <= (digital[data_2][(16+y2-ypos)*8 - ((xpos-x2-48)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+56 && xpos<x2+64 && ypos>=y2 && ypos<y2+16)begin
            pixel_fail <= (digital[data_3][(16+y2-ypos)*8 - ((xpos-x2-56)%8)-1]) ? color_words2 : color_back;
            
        end else if(xpos>=x2 && xpos<x2+8 && ypos>=y2+16 && ypos<y2+32)begin
            pixel_fail <= (data2[5][(16+y2+16-ypos)*8 - ((xpos-x2)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+8 && xpos<x2+16 && ypos>=y2+16 && ypos<y2+32)begin
            pixel_fail <= (data2[6][(16+y2+16-ypos)*8 - ((xpos-x2-8)%8)-1]) ? color_words2 : color_back; 
        end else if(xpos>=x2+16 && xpos<x2+24 && ypos>=y2+16 && ypos<y2+32)begin
            pixel_fail <= (data2[7][(16+y2+16-ypos)*8 - ((xpos-x2-16)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+24 && xpos<x2+32 && ypos>=y2+16 && ypos<y2+32)begin
            pixel_fail <= (data2[8][(16+y2+16-ypos)*8 - ((xpos-x2-24)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+32 && xpos<x2+40 && ypos>=y2+16 && ypos<y2+32)begin
            pixel_fail <= (data2[9][(16+y2+16-ypos)*8 - ((xpos-x2-32)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+40 && xpos<x2+48 && ypos>=y2+16 && ypos<y2+32)begin
            pixel_fail <= (data2[10][(16+y2+16-ypos)*8 - ((xpos-x2-40)%8)-1]) ? color_words2 : color_back;
        end else if(xpos>=x2+48 && xpos<x2+56 && ypos>=y2+16 && ypos<y2+32)begin
            pixel_fail <= (digital[data_4][(16+y2+16-ypos)*8 - ((xpos-x2-48)%8)-1]) ? color_words2 : color_back; 
        end else if(xpos>=x2+56 && xpos<x2+64 && ypos>=y2+16 && ypos<y2+32)begin
            pixel_fail <= (digital[data_5][(16+y2+16-ypos)*8 - ((xpos-x2-56)%8)-1]) ? color_words2 : color_back;

        end else begin
            pixel_fail <= color_back;
        end
    end
endmodule 

