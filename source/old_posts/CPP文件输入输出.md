---
title: C文件输入输出
time: 2023/02/28
category: 基础C
description: 巩固一些C的知识,C Primer Plus文件输入输出
---



# 文件

## 文件概述

​	C把文件看做一些列的连续的字节,每个字节都能被单独的读取

C的两种文件模式==文本模式=={可以访问每个字节）和==二进制模式==（把行末尾或文件末尾映射为C模式）

![image-20230301220536466](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230301220536466.png)

stdio.h头文件把3个文件指针与3个标准文件相关联即stdin,stdout,stderr



### 不同的文件：

- 文本文件：文件使用二进制编码的字符（ASCII或其他）表示文本，类似于字符串
- 二进制文件：使用二进制值代表机器语言代码或数值数据，如图片音乐

​	存储：所有的文件内容都以二进制形式存储，也就是在磁盘上是一串01010

### I/O

底层I/O:使用操作系统提供的基本I/O服务

标准高级I/O:使用C库的标准包的stdio.h头文件定义(C标准只支持这个)

#### 标准I/O好处:

- 可移植
- 有很多函数简化问题
- 输入输出都是缓冲的

### 在每一行开头处检测到^Z时,会返回EOF值,一般为-1

```c
int char;					//由于返回值是-1,使用char类型可能会出错
FILE* fp =open("readin.txt","r");
while((ch=getc(fp))!=EOF){	//检测是否读到末尾
    something...
}
```

## 相关函数

### getc(FILE* InStream),putc(char, FILE* InOutStream)

getchar(),putchar都是由上面定义的

### fprintf(fp, "%s\n", char*)

### fscanf(fp, "%s", char*)

注意文件指针的位置和getc区分开

### fgets(buf, STLEN, fp)

buf是char类型数组的名称，STLEN是字符串的大小，fp是指向FILE的指针

fgets()函数读取输入直到第 1 个换行符的后面，或读到文件结尾，或者读取STLEN-1 个字符

fgets()函数在遇到EOF时将返回NULL值,如果未遇到EOF则之前返回传给它的地址

### fputs(buf, fp)

fputs()函数接受两个参数：第1个是字符串的地址；第2个是文件指针。

fputs()在打印字符串时==不会==在其末尾添加换行符

由于fgets()保留了换行符，fputs()就不会再添加换行符，好配合!

### fopen(FILE*,”r”) fclose(FILE)

![image-20230301220730027](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230301220730027.png)

fclose必要时会刷新缓冲区,但如果磁盘已满等错误可能会导致fclose失败

### exit()

关闭所有打开的文件并结束程序,即使递归遇到一个exit也会终止程序

### fseek(fp, 0L, SEEK_SET); // 定位至文件开始处

![image-20230301220749765](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230301220749765.png)

L后缀表明其值是long类型,所以第二个参数作为偏移量可正可负可零

如果一切正常，fseek()的返回值为0；如果出现错误（如试图移动的距离超出文件的范围），其返回值为-1。

### ftell(fp)

ftell()函数的返回类型是long，返回的是当前的位置.文件的第1个字节到文件开始处的距离是0，以此类推。ANSI C规定，该定义适用于二进制模式打开的文件，以文件模式打开文件的情况不同。

### int fflush(FILE *fp)

刷新缓冲区

### fread()和 fwrite()

fread()和 fwrite函数用于以二进制形式处理数据

![image-20230301220808354](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/image-20230301220808354.png)