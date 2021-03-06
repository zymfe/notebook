//
//  main.m
//  struct
//
//  Created by 赵一鸣 on 2019/10/31.
//  Copyright © 2019 赵一鸣. All rights reserved.
//

// 浅谈 OC 与结构体 https://www.jianshu.com/p/f1b2085c4179

#import <Foundation/Foundation.h>

int compare (int a, int b){
    return a > b ? a : b;
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        struct Person {
            NSString *name;
            NSString *sex;
            NSInteger age;
        };
        
        struct Person p = { @"zhaoyiming", @"man", 18 };
        NSLog(@"%@", p.name);
        
        // OC 初始化结构体跟 C 的数组很像，所以用下面这种方式，编译器无法分辨是给 p 重新赋值为一个结构体，还是重新赋值一个数组
        // 如果是赋值为一个数组，则与 p 定义时的结构体类型不匹配，会报错
        
        // p = { @"zhangsan", @"man", 180 };
        
        // 非结构体变量可以直接修改, 结构体变量需要强转或者通过另一个结构体变量来进行修改
        
        // 基于上面的问题，可以用以下方式解决
        
        // 1、初始化一个临时变量
        struct Person tempP = { @"zhangsan", @"man", 19 };
        p = tempP;
        
        NSLog(@"%@", p.name);
        
        // 2、强转
        p = (struct Person){ @"lisi", @"man", 20 };
        NSLog(@"%@", p.name);
        
        // 在OC中struct是值类型的，也就是说当将一个结构体赋值给另一个结构体时，二者实际上是相互独立互不影响的。
        // 当使用@property修饰的结构体，我们虽然表面是可以直接访问到，但是实际上我们是调用的编译器自动生成的get方法，这样就会有问题。
        // 因为struct是值类型，所以get方法会返回一个完全独立的struct，而这种修改是完全没有意义的，所以，编译器就禁止了这种调用。
        // 当使用@public修饰struct时，外部是直接访问到的该struct，而不是该struct的一个值拷贝，所以是可以的。
    }
    
    @autoreleasepool {
        typedef struct person {
            char name[20];
            int age;
            char sex[10];
        } Person;
        
        Person p = {"zhaoyiming", 18, "man"};
        NSLog(@"%s", p.sex);
    }
    
    @autoreleasepool {
        char str1[3] = "hel";
        str1[0] = 'a';
        printf("%s\n", str1);
        
        char str2[3] = {'a', 'b', 'c'};
        printf("%c\n", str2[2]);
        
        char *str3 = "hello world";
        // 指针类型的字符串，不可更改
//        str3[0] = 'b';
        printf("%s\n", str3);
        
        int arr[5] = {1, 2, 3, 4, 5};
        printf("%d\n", arr[0]);
    }
    
    @autoreleasepool {
        int num1 = 100;
        
        int num2 = num1;
        num2 = 200;
        printf("%d\n", num1);
        
        int *num3 = &num1;
        *num3 = 300;
        printf("%d\n", num1);
    }
    
    @autoreleasepool {
        int nums[5] = {1, 2, 3, 4, 5};
        // 数组指针默认指向其第一个元素的内存地址
        printf("%p\n", nums);
        printf("%d\n", *nums);
        
        printf("---------\n");
        
        for (int i = 0; i < 5; i++) {
            // 可以看到每个 int 类型的数值占 4 个字节
            printf("数字：%d 内存地址：%p\n", *(nums+i), nums+i);
        }
        
        printf("计算数组元素个数：%ld\n", sizeof(nums) / sizeof(int));
    }
    
    @autoreleasepool {
        // 指针和数组名字的区别：
        // 指针是变量，可以随意更改指向（保存的内存地址可以随意更改）
        // 数组名字是常量，永远表示数组首元素的内存地址，可以在数组名字前加 * 来访问第一个元素
        // 通过移动指针的方式访问对应索引位置的元素
        
        int nums[2] = {1, 2};
        
        // 会报错
        // nums = {3, 4};
        printf("%d\n", *nums);
        
        // 不会报错
        *nums = 100;
        printf("%d\n", *nums);
        
        printf("%d\n", *(nums+1));
    }
    
    @autoreleasepool {
        // 函数指针
        // result 是一个函数指针，它指向返回值为 int 类型，并且带有两个 int 类型参数的函数
        int (*result)(int, int) = compare;
        printf("比较大小：%d\n", result(1, 2));
    }
    
    return 0;
}
