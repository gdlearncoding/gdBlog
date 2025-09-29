---
title: map
category: C++
time: 2023/03/07
description: map是STL的一个关联容器（字典）,是有序键（key）值（value）对容器.还需进一步学习添加key可以重复的关联容器multimap
---

## map

- map在c++中翻译为映射是STL（中文标准模板库）的一个关联容器（字典）。是**有序键（key）值（value）对容器**。

- map的每一个元素包括两部分key和value；map的键（key）是索引，不能重复，一个键对应着一个值；value为关键字的值，可以重复。

- key在插入后就不再可以改变，可以被删除（同时对应的value一起被删除）；
- key对应的value可以被访问和读写；
- map使用中括号[]操作符来获取key对应的value；
- map的元素在插入的过程中会自动排序（使用小于号<对元素按照key排序）。并且增删改查整体上都很快。

使用map必须包含头文件：

```cpp
#include<map>
using namespace std;
```

### 定义与初始化

格式为map<typename1，typename2> universities，其中typename1为键的类型，typename2为值的类型。

eg:定义一个key和value的类型都是整数的map，存放学生的学号和成绩：

```cpp
map<int, int> student_score{
        //学号不可以有重复
        //学号可以不按顺序创建
        //学号在创建完成之后会在内部自动排好顺序
        //学号排序按照大小顺序，int类型的数据就按数值大小排序
        {003, 90},
        {004, 88},
        {001, 88},//分数可以有相同的分数
        {002, 78},
    };
```

### map的元素与遍历

map的元素是一个key和一个value共同构成的组合体，这个组合体是一个pair<int,int> 类型。

pair<int, int> 类型有两个成员：first，second。

```cpp
#include <iostream>
#include <map>
using namespace std;
//先通过for循环遍历map，再用first和second访问元素的key和value。
int main(int argc, char** argv)
{
    map<int, int> student_score{
        {003, 90},
        {004, 88},
        {001, 88},
        {002, 78},
    };
    //item变量来迭代student_score 的每一个元素
    for (auto item : student_score)
    {
        //item是一个pair<int, int>类型
        cout << "id=" << item.first << " " << " score=" << item.second << endl;
    }

    return 0;
}
```

![image-20230307230857149](C:/Users/Echo/AppData/Roaming/Typora/typora-user-images/image-20230307230857149.png)

**如果**某个元素**不存在**，**则**会**创建**这个元素，

```cpp
#include <iostream>
#include <string>
#include <map>
using namespace std;

int main(int argc, char** argv)
{
    //初始化map
    //map会自动对插入的元素按照key大小进行排序
    //这里key是string类型，所以使用string的小于号来排序
     //string的小于号比较大小按照ASCII码的字母表排序
    map<string, string> universities{
        {"UCB", "加州大学伯克利分校 University of  California - Berkeley"},
        {"CMU", "卡内基梅隆大学 Carnegie Mellon  University"},
        {"CC", "哥伦比亚大学 Columbia University  /Community College"},
        {"CU", "康奈尔大学 Cornell University"},
        {"UNC", "北卡罗来纳大学 University of North  Carolina - Chapel Hill"},
        {"UWM", "威斯康辛大学麦迪逊分校 University of  Wisconsin - Madison"},
        {"GWU", "乔治华盛顿大学 George Washington  University"},
        {"JHU", "约翰霍普金斯大学 Johns Hopkins  University"},
        {"MSU", "密歇根州立大学 Michigan State  University"},
    };

    //运行时根据业务需要，插入一条记录
    universities["Penn"] = "宾夕法尼亚大学 University of  Pennsylvania";//没有,自动添加
    universities.insert({"MIT", "麻省理工学院 Massachussets  Institute of Technology"});//或者用insert

    //按照字母表顺序输出所有大学
    cout << "All " << universities.size() << " universities:" << endl;
    for (auto& item : universities)
    {
        cout<<"key=" << item.first << " , value= " << item.second << endl;
    }

    return 0;
}
```

![image-20230307231548475](C:/Users/Echo/AppData/Roaming/Typora/typora-user-images/image-20230307231548475.png)