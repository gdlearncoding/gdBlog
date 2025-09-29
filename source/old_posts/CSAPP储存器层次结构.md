---
title: 储存器层次结构
time: 2023/02/28
category: CSAPP
description: CSAPP,还差一点点学完这一章
---

# 存储技术

> 如果你的程序需要的数据是存储在 CPU 寄存器中的，那么在指令的执行期间，在 0个周期内就能访问到它们。如果存储在高速缓存中，需要 4〜75 个周期。如果存储在主存中，需要上百个周期。而如果存储在磁盘上，需要大约几千万个周期！

### RAM 随机访问寄存器

SRAM(静态)vs. DRAM(动态)

![image-20230222211223586](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230222211223586.png)

#### SRAM(静态)

将每个位存储在一个==双稳态==存储器单元,如同倒钟摆

<img src="https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230222210937421.png" alt="image-20230222210937421" style="zoom: 50%;" />

原则上，钟摆也能在垂直的位置无限期地保持平衡，但是这个状态是亚稳态的(metastable)最细微的扰动也能使它倒下，而且一旦倒下就永远不会再恢复到垂直的位置

由于 SRAM 存储器单元的双稳态特性，只要有电，它就会永远地保持它的值。即使有干扰（例如电子噪音)来扰乱电压，当干扰消除时，电路就会恢复到稳定值

#### DRAM

DRAM 存储器单元对干扰非常敏感。当电容的电压被扰乱之后，它就永远不会恢复了。暴露在光线下会导致电容电压改变。

#### 传统的DRAM

结构:

<img src="https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230222211637172.png" alt="image-20230222211637172" style="zoom:50%;" />

![image-20230222212157353](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230222212157353.png)

读取方式:

<img src="https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230222212455476.png" alt="image-20230222212455476" style="zoom:50%;" />

设计成二维阵列降低了芯片上地址引脚数目,但增加了访问时间

#### 内存模块

将DRAM封装,每个超单元存储主存的一个字节,在内存控制器控制下聚合成主存

<img src="https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230222213115548.png" alt="image-20230222213115548" style="zoom:50%;" />

### 磁盘存储

#### 构造

<img src="https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230222215215706.png" alt="image-20230222215215706" style="zoom: 50%;" />

磁盘驱动器(磁盘)-> 盘片-> 盘面表面-> 磁道-> 扇区和间隙

#### 容量

<img src="https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230222215723641.png" alt="image-20230222215723641" style="zoom:50%;" />

<img src="https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230222215737995.png" alt="image-20230222215737995" style="zoom:50%;" />

这里的1GB=10^9^字节，1TB=10^12^字节

#### 磁盘操作

寻道

<img src="https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230222215925323.png" alt="image-20230222215925323" style="zoom:50%;" />

访问时间=寻道时间+ 旋转时间+传送时间

<img src="https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230222221606499.png" alt="image-20230222221606499" style="zoom:50%;" />

逻辑上在磁盘控制器下分成一个B 个扇区大小的逻辑块的序列,维护着逻辑块号和实际（物理）磁盘扇区之间的映射关系,具体读写操作:

<img src="https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230222221744826.png" alt="image-20230222221744826" style="zoom: 67%;" />

### 固态硬盘SSD

<img src="https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230223125754310.png" alt="image-20230223125754310" style="zoom:50%;" />

- 读 SSD 比写要快

- 数据是以页为单位读写的

- 闪存编程原理的限制，只能将1改为0，不能将0改为1.所以只有在一页所属的块整个被擦除之后，才能写这一页。写入的本质就是将某系1变成0.

- 磨损坏一个block就不能用了，所以使用平均磨损算法尽量延长寿命


### 比较

| 种类     | 读写速度 | 能耗 | 结实 | 价格 |
| -------- | -------- | ---- | ---- | ---- |
| SSD      | 快       | 低   | 高   | 高   |
| 旋转磁盘 | 慢       | 高   | 低   | 低   |

### 存储技术趋势

<img src="https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230223131412659.png" alt="image-20230223131412659" style="zoom:50%;" />

## 局部性

局部性原理：倾向于引用邻近于其他最近引用过的数据项的数据项，或者最近引用过的数据项本身。

对于取指令来说，循环有好的时间和空间局部性。循环体越小，循环迭代次数越多，局部性越好

### 时间局部性（下一刻时间的同一个位置）

被引用过一次的内存位置很可能在不远的将来再被多次引用

eg：重复引用相同变量的程序

### 空间局部性（下一刻时间的附近位置）

如果一个内存位置被引用了一次，那么程序很可能在不远的将来引用附近的一个内存位置

eg：双重嵌套循环按照行优先顺序读数组的元素

## 储存器层次结构

<img src="https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230223132904775.png" alt="image-20230223132904775" style="zoom:50%;" />

### 缓存

使用高速缓存（cache）的过程称为缓存

中心思想是，对于每个k，位于k层的更快更小的存储设备作为位于k+1层的更大更慢的存储设备的缓存。也就是说，层次结构中的每一层都缓存来自较低一层的数据对象。

<img src="https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230223185041120.png" alt="image-20230223185041120" style="zoom:50%;" />

#### 缓存命中

当程序需要第k+1层的某个数据对象d时，它首先在当前存储在第k层的一个块中査找d.如果d刚好缓存在第k层中，那就是缓存命中.程序可以直接从第k层读取d,比k+1快

##### 缓存不命中

第k层的缓存从第k+1层缓存中取出包含d的那个块，如果第k层的缓存已经满了,可能就会覆盖现存的一个块.

覆盖一个现存的块的过程称为替换或驱逐这个块,被驱逐的这个块有时也称为牺牲块

##### 种类

- 强制性不命中/冷不命中:如果第k层的缓存是空的，那么对任何数据对象的访问都会不命中
- 冲突不命中:因为这些对象会映射到同一个缓存块，缓存会一直不命中。

## 高速缓存存储器

<img src="https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230223205826772.png" alt="image-20230223205826772" style="zoom: 80%;" />

一般而言，高速缓存的结构可以用元组（S, E，B,m)来描述。高速缓存的大小(或容量）C 指的是所有块的大小的和。标记位和有效位不包括在内。因此，
$$
C=S*E*B
$$
![image-20230223210356630](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230223210356630.png)

抽取出被请求的字的过程:

1. 组选择
2. 行匹配
3. 字抽取

### 直接映射高速缓存 E=1