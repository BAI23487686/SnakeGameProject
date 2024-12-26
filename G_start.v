module G_start(
    input             clk        ,   
    input             rstn       ,   
    input      [10:0] pixel_xpos ,
    input      [10:0] pixel_ypos ,
    output reg [15:0] pixel_start 
);
wire [127:0] data[4:0];
assign data[0] = 128'h0000003E4242402018040242427C0000;//S0
assign data[1] = 128'h00000000000000DC6242424242E70000;//n1
assign data[2] = 128'h0000000000000038440C34444C360000;//a2
assign data[3] = 128'h00000000C040404E4850704844EE0000;//k3
assign data[4] = 128'h000000000000003C42427E40423C0000;//e4
wire [127:0] data2[24:0];
assign data2[0] = 128'h000000FC4242427C4848444442E30000;//R0
assign data2[1] = 128'h000000303000007010101010107C0000;//i1
assign data2[2] = 128'h000000000000003E444438403C42423C;//g2
assign data2[3] = 128'h00000000C040405C6242424242E70000;//h3
assign data2[4] = 128'h000000000010107C10101010120C0000;//t4
assign data2[5] = 128'h00000000000000007E00000000000000;//-5
assign data2[6] = 128'h000000000000001C22404040221C0000;//c6
assign data2[7] = 128'h000000107010101010101010107C0000;//l7
assign data2[8] = 128'h000000303000007010101010107C0000;//i8
assign data2[9] = 128'h000000000000001C22404040221C0000;//c9
assign data2[10] = 128'h00000000C040404E4850704844EE0000;//k10
assign data2[11] = 128'h000000000010107C10101010120C0000;//t11
assign data2[12] = 128'h000000000000003C42424242423C0000;//o12
assign data2[13] = 128'h000000000000003C42427E40423C0000;//e13
assign data2[14] = 128'h00000000000000DC6242424242E70000;//n14
assign data2[15] = 128'h000000000010107C10101010120C0000;//t15
assign data2[16] = 128'h000000000000003C42427E40423C0000;//e16
assign data2[17] = 128'h00000000000000EE3220202020F80000;//r17
assign data2[18] = 128'h000000000010107C10101010120C0000;//t18
assign data2[19] = 128'h00000000C040405C6242424242E70000;//h19
assign data2[20] = 128'h000000000000003C42427E40423C0000;//e20
assign data2[21] = 128'h000000000000003E444438403C42423C;//g21
assign data2[22] = 128'h0000000000000038440C34444C360000;//a22
assign data2[23] = 128'h00000000000000FE4949494949ED0000;//m23
assign data2[24] = 128'h000000000000003C42427E40423C0000;//e24

wire [10:0] xpos;
wire [10:0] ypos;
assign xpos = pixel_xpos[10:3];
assign ypos = pixel_ypos[10:3];
wire [10:0] xpos2;
wire [10:0] ypos2;
assign xpos2 = pixel_xpos[10:1];
assign ypos2 = pixel_ypos[10:1];
parameter x1 = 24;
parameter y1 = 10;
parameter x2 = 50;
parameter y2 = 120;

parameter color_back   = 16'hFFFF;
parameter color_words1 = 16'h0ff0;
parameter color_words2 = 16'h5555;
always@(posedge clk or negedge rstn)
    begin
        if(!rstn)begin
            pixel_start <= color_back;
        end else if(xpos>=x1 && xpos<x1+8 && ypos>=y1 && ypos<y1+16)begin//S
            pixel_start <= (data[0][(16+y1-ypos)*8 - ((xpos-x1)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+8 && xpos<x1+16 && ypos>=y1 && ypos<y1+16)begin//n
            pixel_start <= (data[1][(16+y1-ypos)*8 - ((xpos-x1-8)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+16 && xpos<x1+24 && ypos>=y1 && ypos<y1+16)begin//a
            pixel_start <= (data[2][(16+y1-ypos)*8 - ((xpos-x1-16)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+24 && xpos<x1+32 && ypos>=y1 && ypos<y1+16)begin//k
            pixel_start <= (data[3][(16+y1-ypos)*8 - ((xpos-x1-24)%8)-1]) ? color_words1 : color_back;
        end else if(xpos>=x1+32 && xpos<x1+40 && ypos>=y1 && ypos<y1+16)begin//e
            pixel_start <= (data[4][(16+y1-ypos)*8 - ((xpos-x1-32)%8)-1]) ? color_words1 : color_back;

        end else if(xpos2>=x2 && xpos2<x2+8 && ypos2>=y2 && ypos2<y2+16)begin//R
            pixel_start <= (data2[0][(16+y2-ypos2)*8 - ((xpos2-x2)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+8 && xpos2<x2+16 && ypos2>=y2 && ypos2<y2+16)begin//i
            pixel_start <= (data2[1][(16+y2-ypos2)*8 - ((xpos2-x2-8)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+16 && xpos2<x2+24 && ypos2>=y2 && ypos2<y2+16)begin//g
            pixel_start <= (data2[2][(16+y2-ypos2)*8 - ((xpos2-x2-16)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+24 && xpos2<x2+32 && ypos2>=y2 && ypos2<y2+16)begin//h
            pixel_start <= (data2[3][(16+y2-ypos2)*8 - ((xpos2-x2-24)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+32 && xpos2<x2+40 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[4][(16+y2-ypos2)*8 - ((xpos2-x2-32)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+40 && xpos2<x2+48 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[5][(16+y2-ypos2)*8 - ((xpos2-x2-40)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+48 && xpos2<x2+56 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[6][(16+y2-ypos2)*8 - ((xpos2-x2-48)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+56 && xpos2<x2+64 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[7][(16+y2-ypos2)*8 - ((xpos2-x2-56)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+64 && xpos2<x2+72 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[8][(16+y2-ypos2)*8 - ((xpos2-x2-64)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+72 && xpos2<x2+80 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[9][(16+y2-ypos2)*8 - ((xpos2-x2-72)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+80 && xpos2<x2+88 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[10][(16+y2-ypos2)*8 - ((xpos2-x2-80)%8)-1]) ? color_words2 : color_back;

        end else if(xpos2>=x2+96 && xpos2<x2+104 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[11][(16+y2-ypos2)*8 - ((xpos2-x2-96)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+104 && xpos2<x2+112 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[12][(16+y2-ypos2)*8 - ((xpos2-x2-104)%8)-1]) ? color_words2 : color_back;

        end else if(xpos2>=x2+120 && xpos2<x2+128 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[13][(16+y2-ypos2)*8 - ((xpos2-x2-120)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+128 && xpos2<x2+136 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[14][(16+y2-ypos2)*8 - ((xpos2-x2-128)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+136 && xpos2<x2+144 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[15][(16+y2-ypos2)*8 - ((xpos2-x2-136)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+144 && xpos2<x2+152 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[16][(16+y2-ypos2)*8 - ((xpos2-x2-144)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+152 && xpos2<x2+160 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[17][(16+y2-ypos2)*8 - ((xpos2-x2-152)%8)-1]) ? color_words2 : color_back;

        end else if(xpos2>=x2+168 && xpos2<x2+176 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[18][(16+y2-ypos2)*8 - ((xpos2-x2-168)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+176 && xpos2<x2+184 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[19][(16+y2-ypos2)*8 - ((xpos2-x2-176)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+184 && xpos2<x2+192 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[20][(16+y2-ypos2)*8 - ((xpos2-x2-184)%8)-1]) ? color_words2 : color_back;

        end else if(xpos2>=x2+200 && xpos2<x2+208 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[21][(16+y2-ypos2)*8 - ((xpos2-x2-200)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+208 && xpos2<x2+216 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[22][(16+y2-ypos2)*8 - ((xpos2-x2-208)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+216 && xpos2<x2+224 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[23][(16+y2-ypos2)*8 - ((xpos2-x2-216)%8)-1]) ? color_words2 : color_back;
        end else if(xpos2>=x2+224 && xpos2<x2+232 && ypos2>=y2 && ypos2<y2+16)begin//t
            pixel_start <= (data2[24][(16+y2-ypos2)*8 - ((xpos2-x2-224)%8)-1]) ? color_words2 : color_back;


        end else begin
            pixel_start <= color_back;
        end
    end
endmodule 

