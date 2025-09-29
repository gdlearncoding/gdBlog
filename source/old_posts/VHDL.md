---
title: VHDL
time: 2023/03/05
category: VHDL
description: VHDL语言快速入门
---

# 基本语法

## 标识符

![image-20230305145111250](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014787.png)

英文字+字符(不能是#)+字符(不能是_)

## 数字

156E2的意思是15600

_可连接数字

数字前可加零,数字中间无空格

![image-20230305145522706](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014788.png)

![image-20230305150429098](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014789.png)

## 下标

![image-20230305145813649](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014791.png)

==downto 和 to 区别:显示方向不同==
Signal s1: std_logic_vector(7 downto 0); 这个形成的数组下标值从右到左依次是7,6,5,4,3,2,1,0
Signal s2: std_logic_vector(0 to 7);这个形成的数组的下标值从右到做依次是0,1,2,3,4,5,6,7

# 数据对象

## 常数

![image-20230305150108416](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014792.png)

![image-20230305150151962](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014793.png)

## 变量

![image-20230305150324959](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014794.png)

## 信号

![image-20230305150536378](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014795.png)

![image-20230305150715687](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014796.png)

![image-20230305150909944](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014797.png)

# 数据类型

![image-20230305150942473](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014798.png)

## 预定义数据类型

### 布尔(BOOLEAN)

![image-20230305192516790](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014799.png)

### 位(BIT)

![image-20230305192605147](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014800.png)

### 位矢量(BIT_VECTOR)

![image-20230305192646719](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014801.png)

### 字符(CHARACHTER)

![image-20230305192732820](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014802.png)

### 整数(INTEGER)

![image-20230305192743734](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014803.png)

### 实数(REAL)

![image-20230305192757412](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014804.png)

### 字符串(STRING)

![image-20230305192804620](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014805.png)

### 时间(TIME)数据类型

![image-20230305192822061](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014806.png)

### 错误等级(SEVERITY_LEVEL)

![image-20230305192852997](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014807.png)

## IEEE预定义标准逻辑位与矢量

![image-20230305192959286](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014808.png)

![image-20230305193010796](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014809.png)

![image-20230305193026122](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014810.png)

![image-20230305193045728](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014811.png)

![image-20230305193100840](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014812.png)

![image-20230305193114294](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014813.png)

![image-20230305193133541](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014814.png)

![image-20230305193151981](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014815.png)

![image-20230305193235052](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303052014816.png)

# VHDL In Quartus Ⅱ

## 基本结构

### vhdl设计组成

- 库和程序包(libary, package)

- 实体(entity)

```
entity 实体名 is  
    generic(常数名：数据类型：初值)  
    port(端口信号名：数据类型)  
end 实体名  
```

- 结构体(architecture)

```
architecture 结构体名 of 实体名 is  
    说明部分（可选，如数据类型type 常数constand 信号signal 元件component 过程pocedure 变量variable和进程process等）  
begin  
    功能描述部分  
end 结构体名  
```

- 配置(configuration)

### 一些结构

```vhdl
if 条件 then  
    --do something;
else if 条件 then 
    --do something;
else 
    --do something;
end if; 
    
for x in 0 to n loop
    --do something;
end loop;

```

### 运算符

#### **赋值运算**：

> < = 信号赋值
> : = 变量赋值
> = > 数组内部分元素赋值

逻辑运算

> nand 与非
> nor 或非
> xor 异或
>
> /= 不等于		注意：对数组类型，参与运算的数组位数要相等，运算为对应位进行

VHDL代码是并发执行的。只有PROCESS，FUNCTION或者PROCEDURE内部的代码才是顺序执行的。

值得注意的是，尽管这些模块中的代码是顺序执行的，但是当它们作为一个整体是，与其他模块之间又是并发的。

IF，WAIT,CASE,LOOP语句都是顺序代码，`只能`用在PROCESS,FUNCTION和PROCEDURE内部。

## 实战

```vhdl
--halfadder半加器
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity halfadder is
    port(a, b : in std_logic;
         s, c : out std_logic
         --s -> sum, c -> carry
        );
end halfadder;

architecture f_halfadder of halfadder is 
begin
    s <= a xor b;
    c <= a and b;
end f_halfadder;

```

```vhdl
--fulladder一位全加器
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fulladder is 
    port(a, b, c0 : in std_logic;
            s, c1 : out std_logic
        );
end fulladder;

architecture f_fulladder of fulladder is 
begin 
    s  <= a xor b xor c0;
    c1 <= (a and b) or (c0 and (a xor b)); 
end f_fulladder;

```

```vhdl
--add4四位加法器
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity add4 is 
    port(a, b : in std_logic_vector(3 downto 0); 
            s : out std_logic_vector(3 downto 0);
           c0 : in std_logic;
           c1 : out std_logic
        );
end add4;

architecture f_add4 of add4 is 
begin 
    --模拟手算加法
    process(a, b, c0)
    variable t : std_logic;
    begin
        t := c0;
        for x in 0 to 3 loop
            s(x) <= a(x) xor b(x) xor t;
               t := (a(x) and b(x)) or (t and (a(x) xor b(x)));
        end loop;
        c1 <= t;
    end process;
end f_add4;

```

```vhdl
---mul4,四位不带符号乘法器,直接使用 ”+“ 号要结果的存储要多加一位。
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mul4 is 
    port(n0, n1 : in std_logic_vector(3 downto 0);
             a0 : out  std_logic_vector(7 downto 0)
        ); 
end mul4;

architecture f_mul4 of mul4 is 
signal t0, t1, t2, t3 : std_logic_vector(3 downto 0);

begin  
    process(n0, n1, t0, t1, t2, t3) 
    begin
        --模拟手算乘法
        if n1(0) = '1' then
            t0 <= n0;
        else 
            t0 <= "0000";
        end if;
        
        if n1(1) = '1' then
            t1 <= n0;
        else 
            t1 <= "0000";
        end if;
        
        if n1(2) = '1' then
            t2 <= n0;
        else 
            t2 <= "0000";
        end if;
        
        if n1(3) = '1' then
            t3 <= n0;
        else 
            t3 <= "0000";
        end if;
        
        a0 <= ("0000" & t0) + ("000" & t1 & '0') + ("00" & t2 & "00") + ('0' & t3 & "000");
    end process;
end f_mul4;

```

```vhdl
--四位求补器
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity comp4 is 
	port (c0 : in std_logic;
			flag1: in std_logic;
			num1 : in std_logic_vector (3 downto 0);
			flag2: in std_logic;
			num2 : in std_logic_vector (3 downto 0);
			res1 : out std_logic_vector(3 downto 0);
			res2 : out std_logic_vector(3 downto 0));
end comp4;
architecture f_comp4 of comp4 is
begin
process(num1,flag1,num2,flag2,c0)
	Variable tmp_ci:std_logic;
	begin
		res1<="0000";
		res2<="0000";
		tmp_ci:='0';
		for i in 0 to 3 loop
			res1(i)<=(num1(i) xor (tmp_ci and flag1));
			tmp_ci:=num1(i) or tmp_ci;
		end loop;
		tmp_ci:='0';
		for i in 0 to 3 loop
			res2(i)<=(num2(i) xor (tmp_ci and flag2));
			tmp_ci:=num2(i) or tmp_ci;
		end loop;
end process;
end f_comp4;

```

```vhdl
--这里实现的是没有符号的乘法阵列,四位乘法阵列
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity mult_array is
	port(num1, num2: in std_logic_vector(3 downto 0); -- num1是被乘数，舗um2是成乘数
			   res : out std_logic_vector(7 downto 0);
			   test: out std_logic_vector(7 downto 0));
end mult_array;
architecture f_mult_array of mult_array is
TYPE mult_array is Array(3 downto 0) of std_logic_vector(6 downto 0);
Signal m: mult_array;
begin
	process(m,num1,num2)
	Variable tmp_num2:std_logic_vector(3 downto 0);
	begin
		for i in 0 to 3 loop
			m(i)<="0000000";
			if num2(i)='1' then 
				m(i)(3+i downto i)<=num1(3 downto 0);
			end if;
		end loop;
		--test(7 downto 4 ) <= num2(3 downto 0);
		res<=('0' & m(0)) + ('0' & m(1)) + ('0' & m(2)) + ('0' & m(3));
	end process;
end f_mult_array;

```

