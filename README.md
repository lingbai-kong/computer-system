# computer-system
同济大学CS《计算机系统实验》实验二TongJi University CS computer system experiment assignment 2
## 概述

本工程为2021年同济大学计算机系计算机系统实验实验2。本实验在已有CPU上增加Wishbone 总线，GPIO、UART、Flash控制器、SDRAM控制器。利用Ubuntu上建立交叉编译环境 对μC/OS-II操作系统进行改写、编译。将编译好的μC/OS-II操作系统与boost loader程序装配，将装配好的二进制汇编代码写入到SD卡中，插入FPGA开发板中，启动开发板，观察串口通信。

## 环境

### 软件环境

开发环境Vivado 2020.2

仿真环境ModelSim PE 10.4c

测试环境sscom5

编译环境VMware 16, Ubuntu, GNU 

### 硬件环境

NEXYS 4 DDR Atrix-7

SD卡，其中要拷贝loader程序和操作系统映像

## 开发流程

首先先将各个从机设备连接到WishBone上，暂时不引入CPU，用数码管发出主机信号，用数码管和LED灯显示WishBone响应，逐步调试。完成后再引入CPU。此时不需要立即移植操作系统，先根据《自己动手写CPU》一书让CPU执行UART测试程序和GPIO测试程序，然后再让CPU模拟操作系统的加载过程，以上测试均通过后代表移植操作系统所需的硬件环境已经搭建完成，此时再去移植操作系统，完成整个实验。

## 下板结果

1. 使用WinHex软件将操作系统的编译结果写入SD卡

2. 将SD卡插入FPAG开发板中

3. 用usb数据线连接FAGA开发板至电脑

4. 打开串口调试，设置波特率为9600bps、8位数据位、没有奇偶校验位、1位停止位

5. 将bit流下板，观察串口通信

通信结果如下图所示：

![串口结果](https://github.com/lingbai-kong/computer-system/blob/main/example.png)

## 结果分析

由上图可知，CPU启动后首先执行boostloader程序，将SD卡内的操作系统加载至SDRAM，开始加载时FPGA发送字符串“Loading OS into SDRAM…”。等待77秒后加载操作系统完成。此时FPGA发送字符串“Load OS into SDRAM DONE!!!”。之后操作系统开始初始化，等待20秒后操作系统初始化完成，开始执行应用程序进程，应用程序进程首先开始初始化UART和GPIO，分别发送字符串“UART initialize done !”和“GPIO initialize done ！”。然后开始执行程序的主要功能即发送中文字符串“上帝说要有光，于是就有了光\n上帝说要有天空，于是就有了天空\n上帝说要有陆地和海洋，于是就有了陆地和海洋\0”。发送完毕后操作系统进入等待状态。上述结果与期望结果相一致，说明实验成功。

## 备注

这个实验做的极其极其痛苦，可能是我把时序给写乱了，整个工程非常非常非常不稳定。哪怕是在一个无关模块上作出轻微的改动也有可能导致系统运行错误。这也是为什么CPU频率这么慢的原因。如果有读者成功debug请与我联系。

最后，终于把硬件课上完了。我再也不想学硬件辣555

如果本仓库有帮助到你，就送我一颗star吧🤗

如果有问题也可以在issue提出，方便其他人参考或一起讨论😋
