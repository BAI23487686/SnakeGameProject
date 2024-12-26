`timescale 1ns / 1ps  

module top_tb;  

    // Parameters  
    parameter CLK_PERIOD = 10; // 时钟周期设置为10ns  

    // Inputs  
    reg clk;  
    reg rstn;  
    reg key_up;  
    reg key_down;  
    reg key_right;  
    reg key_left;  

    // Outputs  
    wire vga_hs;  
    wire vga_vs;  
    wire [15:0] vga_rgb;  

    // 实例化 top 模块  
    top uut (  
        .clk(clk),  
        .rstn(rstn),  
        .key_up(key_up),  
        .key_down(key_down),  
        .key_right(key_right),  
        .key_left(key_left),  
        .vga_hs(vga_hs),  
        .vga_vs(vga_vs),  
        .vga_rgb(vga_rgb)  
    );  

    // Generate clock  
    initial begin  
        clk = 0;  
        forever #(CLK_PERIOD / 2) clk = ~clk; // 时钟信号反转  
    end  

    // Initial block for stimulus  
    initial begin  
        // Initialize inputs  
        rstn = 0;          // 初始复位  
        key_up = 0;  
        key_down = 0;  
        key_right = 0;  
        key_left = 0;  

        // Apply reset  
        #20;               // 保持复位20ns  
        rstn = 1;         // 解除复位  
        #20;  

        // Simulate key presses  
        // 进行模拟按键操作  
        // 按下向右键开始游戏  
        key_right = 1;    // 按下右键  
        #10;  
        key_right = 0;    // 放开右键  
        #20;  

        // 可以根据需要继续模拟其他按键  
        // 按下向上键  
        key_up = 1;       // 按下上键  
        #10;  
        key_up = 0;       // 放开上键  
        #20;  

        // 按下向下键  
        key_down = 1;     // 按下下键  
        #10;  
        key_down = 0;     // 放开下键  
        #20;  
        
        // 按下向左键  
        key_left = 1;     // 按下左键  
        #10;  
        key_left = 0;     // 放开左键  
        #20;  

        // 检查输出  
        // 此处可添加针对输出的具体验证逻辑  
        // 例如检查vga_rgb的变化  
        
        // 结束仿真  
        #100;             // 等待100ns以查看输出变化  
        $finish;         // 结束仿真  
    end  

    // 可以在这里添加监视器或日志输出以查看信号变化  
    initial begin  
        $monitor("Time: %0t | rstn: %b | key_up: %b | key_down: %b | key_right: %b | key_left: %b | vga_hs: %b | vga_vs: %b | vga_rgb: %h",   
                 $time, rstn, key_up, key_down, key_right, key_left, vga_hs, vga_vs, vga_rgb);  
    end  
    
endmodule