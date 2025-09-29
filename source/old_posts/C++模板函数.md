---
title: 模板函数
category: C++
time: 2023/03/07
description: 多个函数只是参数类型不同，逻辑完全相同。如果可以用一个函数来取代
---

# 模板函数

考虑我们想要实现一个用来比较两个 int 变量大小的函数：

```cpp
bool biggerThan(int lhs, int rhs)
{
    return lhs > rhs;
}
```

后来我们发现我们又需要一个支持 double 类型的比较函数：

```cpp
bool biggerThan(double lhs, double rhs)
{
    return lhs > rhs;
}
```

上面的两个函数只是参数类型不同，逻辑完全相同。如果可以用一个函数来取代，代码就得到了简化。

对以上的需求，C++使用**模板函数**（也叫**函数模板** template function）来实现。

**定义像下面这样：**

```cpp
template<typename T>
bool biggerThan(T lhs, T rhs)
{
    return lhs > rhs;
}
```

上面的 biggerThan 的参数类型是 T。

这个 T 是上一行的 template<typename T> 指定的。 表示是一个不确定的类型，当你调用的时候给什么类型的参数，它就把这里的 T 当做什么类型（自动类型推断）。

**模板函数的调用(完整代码)：**

```cpp
#include <iostream>
using namespace std;

template<typename T>
bool biggerThan(const T& lhs, const T& rhs)
{
    return lhs > rhs;
}

int main()
{
    cout << "123 > 456 ? : " << biggerThan(123, 456)<<endl;
    cout << "1.0 > 2.0 ? : " << biggerThan(1.0, 2.0) << endl;
}
```