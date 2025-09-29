---
title: 复制控制（深拷贝）
category: C++
time: 2023/03/07
description: 简单了解对象的构造与析构（默认构造函数constructor与析构函数destructor ）
---

## 构造函数

定义一个对象的时候，总是会执行构造函数（并且不需要我们手动调用，而是编译器会生成调用构造函数的机器代码）。

构造函数用来给对象的成员赋初始值。

```cpp
#include <iostream>
using namespace std;

struct Student
{
    //默认构造函数：没有参数
    Student(void) {
        cout << "Student constructor called." << endl;
    }
};

int main()
{
	cout << "main begin" << endl;
        //下面创建一个对象。定义对象分两步：
        // 1 在栈空间开辟空间存放Student类的对象stuZhangsan；
        // 2 对这个空间执行默认构造函数执Student()行初始化,
        //   这个调用默认构造函数的代码是编译器生成的，不需要我们显示调用就会执行
	Student stuZhangsan;//这里调用Student类的默认构造函数Student()
	cout << "main end" << endl;
	return 0;
}
```

![image-20230308162656798](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303081627868.png)

**说明：不定义构造函数会怎么样？**

- 如果用户没有默认构造函数Student()，编译器会合成一个；
- 如果成员是类类型的对象，合成的默认构造函数会依次调用各个成员对象的默认构造函数。

##  析构函数

2.1 类对象释放的时候会自动调用析构函数

```cpp
#include <iostream>
using namespace std;

struct Student
{
	Student(void) {//默认构造函数：没有参数
		cout << "Student constructor called." << endl;
	}
	~Student(){//析构函数
		cout << "Student destructor called." << endl;
	}
};

int main()
{
	cout << "main begin" << endl;
	Student stu;//这里调用默认构造函数创建对象
	cout << "main end" << endl;
	return 0;
}//这里执行对象析构函数（对象超出作用域的时刻）
```

![image-20230308162919081](https://cdn.jsdelivr.net/gh/gdlearncoding/blogImage@main/202303081629102.png)

说明：大部分类并不需要定义析构函数。除非遇到非平凡的类。