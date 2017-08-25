//
//  NSObject+HKExtension.m
//  runtime001
//
//  Created by H on 16/6/19.
//  Copyright © 2016年 TanZhou. All rights reserved.
//

#import "NSObject+HKExtension.h"
#import <objc/runtime.h>

@implementation NSObject (HKExtension)

//归档必须实现的方法
- (void)encodeWithCoder:(NSCoder *)coder
{
    //归档  OC 对象 每一个属性  解析为 键值对!!
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        //从列表中取出Ivar
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        NSString * KEY = [NSString stringWithUTF8String:name];
        //归档
        [coder encodeObject:[self valueForKey:KEY] forKey:KEY];
    }
    free(ivars);
}



- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [self init]) {
        unsigned int count = 0;
        Ivar * ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i ++) {
            //取出Ivar
            Ivar ivar = ivars[i];
            //取出名称
            const char * name = ivar_getName(ivar);
            //转NSString 取出KEY
            NSString * KEY = [NSString stringWithUTF8String:name];
            //解档
            id value = [coder decodeObjectForKey:KEY];
            //设置到自己的属性上去
            [self setValue:value forKey:KEY];
        }
        free(ivars);
    }
    return self;
}



@end
