# MIPS_SingleCycle_CPU54



## 项目背景

本项目是计算机组成原理实践课的课程设计，要求完成54条指令的单周期MIPS CPU，并且要求前仿真输出结果和MARS汇编器的结果完全一致，后仿真波形图正常，下板结果正确。



## 使用技术

### 前仿真

深入理解单周期CPU的工作原理，然后绘制54条指令的数据通路图，列出对应的输入输出表、指令信号表。基于此，使用Verilog编写CPU代码。写完后，使用Vivado运行前仿真，将输出的结果和MARS汇编器的输出结果比对，调试程序直到54条指令的所有测试汇编程序在MARS汇编器下和我的程序下的输出完全一致为止。



### 后仿真

Synthesis之后使用ModelSim来完成后仿真，具体的注意事项见pdf文件。
![post1](https://user-images.githubusercontent.com/37100888/125269252-19c74f00-e33b-11eb-8b83-1b80221ace44.png)



### 下板

依次运行Synthesis、Implementation、Generate Bitstream来进行后仿真和下板，结果如下：
![下板2](https://user-images.githubusercontent.com/37100888/125269312-251a7a80-e33b-11eb-9d97-67de9a17b302.jpg)





## 编译运行环境

程序可以使用Vivado 2016和Modelsim来编译运行；在调试过程中还用到了MARS汇编器。

