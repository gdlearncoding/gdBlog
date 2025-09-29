---
title: 函数重载
category: C++
time: 2023/04/11
description: 用法,说明
---

## 函数重载

在C++中，用户可以重载函数。这意味着，在同一作用域内，只要`函数参数的类型不同，或者参数的个数不同`，或者二者兼而有之，两个或者两个以上的函数可以使用相同的函数名。

```c++
#include <iostream>
using namespace std;

int add(int x, int y)
{
	return x + y;
}

double add(double x, double y)
{
	return x + y;
}

int add(int x, int y, int z)
{
	return x + y + z;
}

int main() 
{
	int a = 3, b = 5, c = 7;
	double x = 10.334, y = 8.9003;
	cout << add(a, b) << endl;
	cout << add(x, y) << endl;
	cout << add(a, b, c) << endl;
	return 0;
}

```

调用重载函数时，`函数返回值类型不在参数匹配检查之列`。因此，若两个函数的参数个数和类型都相同，而只有返回值类型不同，则不允许重载。

函数的重载与`带默认值的`函数一起使用时，有可能引起二义性。

作用:

**重载函数通常用来在同一个作用域内 用同一个函数名 命名一组功能相似的函数，这样做减少了函数名的数量，避免了名字空间的污染，对于程序的可读性有很大的好处。**

### C与C++

![image-20230411202137883](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202304112021996.png)