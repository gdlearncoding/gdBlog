---
title: 类与对象
category: C++
time: 2023/03/08
description: 类与对象简介,先会大概写出代码(可能会很烂),再去看C++Primer细节
---

# 类

> 定义**类类型**:类类型是我们自己定义的**新类型（自定义类型）**，这个新的类型在C++中原来并不存在。

> 创建**类对象**,类类型的变量又叫**对象**。

从面向对象的角度来说，**修改类的成员变量应该是类自己的事情**，**用户不应该直接访问类的成员变量，而应该通过类提供的成员函数类访问**。

**默认情况下class的成员是private私有的，struct的成员是public的**。这是struct和class的唯一区别。当然也可以自己添加private和public

在类的const成员函数内部，不可以修改类的任何成员变量。

```cpp
int get_age(void) const { return m_age; }//如果const成员函数内修改了类的成员变量，会在编译的时候报语法错误。
```

## 例题

题目:题目描述

已知，某专业有10名同学，这10名同学的信息如下：

每一行记录表示一个学生的信息：学号, {10门课的成绩}, {10门课对应的学分}, "姓名"

```text
学号, {10门课的成绩}, {10门课对应的学分}, "姓名"
111, { 88, 86, 87, 82, 82, 86, 83, 86, 80, 89 }, { 3, 3, 1, 1, 2, 1, 3, 2, 3, 3 } , "杜特尔特"
112, { 92, 80, 81, 75, 93, 80, 81, 89, 84, 85 }, { 3, 2, 3, 1, 2, 2, 2, 1, 1, 1 } , "文在寅" 
113, { 88, 92, 93, 86, 84, 81, 81, 80, 81, 89 }, { 3, 2, 1, 2, 1, 3, 3, 3, 2, 3 } , "佐科"
114, { 94, 81, 89, 89, 80, 71, 88, 89, 89, 88 }, { 1, 3, 3, 2, 1, 1, 3, 1, 3, 3 } , "莱希"
115, { 83, 85, 84, 82, 63, 81, 83, 64, 81, 83 }, { 1, 2, 1, 3, 1, 3, 1, 1, 1, 2 } , "雅各布"
116, { 90, 81, 84, 91, 85, 88, 84, 72, 94, 87 }, { 2, 2, 2, 1, 2, 2, 1, 1, 2, 3 } , "卢卡申科"
117, { 89, 81, 86, 88, 81, 91, 84, 75, 90, 88 }, { 2, 2, 2, 2, 1, 3, 3, 2, 2, 3 } , "马克龙"
118, { 82, 80, 82, 94, 87, 80, 94, 80, 71, 92 }, { 1, 2, 3, 3, 1, 2, 3, 3, 2, 1 } , "萨科奇"
119, { 89, 91, 80, 90, 85, 87, 87, 94, 81, 70 }, { 2, 3, 3, 2, 3, 2, 2, 3, 1, 3 } , "默克尔"
120, { 88, 95, 84, 89, 92, 79, 80, 96, 83, 80 }, { 3, 4, 1, 3, 3, 2, 2, 4, 3, 3 } , "金正恩"
```

现在需要取GPA从高到低排序，前三名作为保研名额。

请你求出哪三个人会被保研。

解答:

```c++
#include <iostream>
#include <vector> //存放学生的课程和学分
#include <string> //存放学生的名字
#include <iomanip> //格式控制：小数部分2位小数
#include <map> //存放学生数据，排序数据
using namespace std;

struct Student
{
    double get_GPA(void) const { return GPA; }
    void set_GPA(void);//计算学生的GPA数值，存到学生的GPA成员变量中

    int id;//学号
    vector<int> score_list;//修的所有课程的成绩列表
    vector<int> credit_hour_list;//修的所有课程对应的学分列表
    double GPA;
    string name;//姓名
};
void Student::set_GPA(void)
{
    //累加课程学分绩点=课程学分绩点1+课程学分绩点2+...+课程学分绩点n
    double total_credit_hour_point = 0;

    for (int i = 0; i < score_list.size(); i++)
    {
        //课程绩点=课程成绩/10 -5
        double grade_point = score_list[i] / 10.0 - 5;//注意这里整数通过除以浮点数结果转换成了浮点数
        //课程学分绩点
        double credit_hour_point = credit_hour_list[i] * grade_point;
        //累加课程学分绩点
        total_credit_hour_point += credit_hour_point;
    }

    //平均学分绩点
    //各门课学分之和sum_credit_hour 
    int sum_credit_hour = 0;
    for (int i = 0; i < score_list.size(); i++)
    {
        sum_credit_hour += credit_hour_list[i];//累加
    }

    //平均学分绩点= 累加课程学分绩点/各门课学分之和
    GPA = total_credit_hour_point / sum_credit_hour;
}
void init_student_data(map<int, Student>& student_map)
{
    student_map[111] = { 111, { 88, 86, 87, 82, 82, 86, 83, 86, 80, 89 }, { 3, 3, 1, 1, 2, 1, 3, 2, 3, 3 } , 0.0, "杜特尔特" };
    student_map[112] = { 112, { 92, 80, 81, 75, 93, 80, 81, 89, 84, 85 }, { 3, 2, 3, 1, 2, 2, 2, 1, 1, 1 } , 0.0, "文在寅" };
    student_map[113] = { 113, { 88, 92, 93, 86, 84, 81, 81, 80, 81, 89 }, { 3, 2, 1, 2, 1, 3, 3, 3, 2, 3 } , 0.0, "佐科" };
    student_map[114] = { 114, { 94, 81, 89, 89, 80, 71, 88, 89, 89, 88 }, { 1, 3, 3, 2, 1, 1, 3, 1, 3, 3 } , 0.0, "莱希" };
    student_map[115] = { 115, { 83, 85, 84, 82, 63, 81, 83, 64, 81, 83 }, { 1, 2, 1, 3, 1, 3, 1, 1, 1, 2 } , 0.0, "雅各布" };
    student_map[116] = { 116, { 90, 81, 84, 91, 85, 88, 84, 72, 94, 87 }, { 2, 2, 2, 1, 2, 2, 1, 1, 2, 3 } , 0.0, "卢卡申科" };
    student_map[117] = { 117, { 89, 81, 86, 88, 81, 91, 84, 75, 90, 88 }, { 2, 2, 2, 2, 1, 3, 3, 2, 2, 3 } , 0.0, "马克龙" };
    student_map[118] = { 118, { 82, 80, 82, 94, 87, 80, 94, 80, 71, 92 }, { 1, 2, 3, 3, 1, 2, 3, 3, 2, 1 } , 0.0, "萨科奇" };
    student_map[119] = { 119, { 89, 91, 80, 90, 85, 87, 87, 94, 81, 70 }, { 2, 3, 3, 2, 3, 2, 2, 3, 1, 3 } , 0.0, "默克尔" };
    student_map[120] = { 120, { 88, 95, 84, 89, 92, 79, 80, 96, 83, 80 }, { 3, 4, 1, 3, 3, 2, 2, 4, 3, 3 } , 0.0, "金正恩" };
}
void set_student_gpa(map<int, Student>& student_map, map<double, int>& gpa_order)
{
    for (auto& student : student_map)
    {
        student.second.set_GPA();
        double gpa = student.second.get_GPA();
        //(1) your code
        
    }
}
void print_student_research_quota(map<double, int>& gpa_order, map<int, Student>& student_map)
{
    int pass_count = 3;
    int i = 0;
    //从后向前迭代容器：逆序迭代。因为map默认是从小到大排序，最小的元素放在最开始的位置
    for (auto itr = gpa_order.rbegin(); itr != gpa_order.rend(); ++itr)
    {
        auto& student = student_map[itr->second];
        cout << "GPA="
            //fixed使用小数计数法(而不是科学计数法)显示浮点数
            << fixed
            //setprecision(2) 小数部分保留2位，最后一位四舍五入
            << setprecision(2) << student.get_GPA()
            << ", id=" << student.id;
        if (i < pass_count)
        {
            cout << ", 保研";
        }
        else
        {
            cout << ", 不保";
        }
        //(2) your code

        cout << ", name=" << student.name << endl;
    }
}
int main()
{
    map<int, Student> student_map;
    init_student_data(student_map);

    map<double, int> gpa_order;
    //计算学生的GPA，并存放到gpa_order里
    set_student_gpa(student_map, gpa_order);

    //输出哪些学生被保研了，哪些没有
    print_student_research_quota(gpa_order, student_map);

    return 0;
}
```

