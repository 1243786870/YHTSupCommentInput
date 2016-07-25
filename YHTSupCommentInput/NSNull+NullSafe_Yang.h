//
//  NSNull+NullSafe_Yang.h
//  YHTSupCommentInput
//
//  Created by yanghaitao  on 16/7/25.
//  Copyright © 2016年 yanghaitao. All rights reserved.
//


//问题：
//
//在项目中，一直遇到一个坑的问题，程序在获取某些数据之后莫名崩溃。原因是：由于服务器的数据库中有些字段为空，然后以JSON形式返回给客户端时就会出现这样的数据：repairs = "<null>"
//
//这个数据类型不是nil 也不是 String。 解析成对象之后，如果直接向这个对象发送消息（eg：length，count 等等）就会直接崩溃。提示错误为：
//-[NSNull length]: unrecognized selector sent to instance
//用了一个Category，叫做NullSafe 。
//http://mp.weixin.qq.com/s?__biz=MzA5OTU3NjAxNA==&mid=2653646281&idx=1&sn=67deeced31477f0183fba36d6d734551&scene=23&srcid=0725pqHrSssmHswwp7yGqZdL#rd
//NullSafe思路：在运行时操作，把这个讨厌的空值置为nil，而nil是安全的，可以向nil对象发送任何message而不会奔溃。这个category使用起来非常方便，只要加入到了工程中就可以了，你其他的什么都不用做，很简单。


#import <objc/runtime.h>
#import <Foundation/Foundation.h>

#ifndef NULLSAFE_ENABLED
#define NULLSAFE_ENABLED 1
#endif



#pragma GCC diagnostic ignored "-Wgnu-conditional-omitted-operand"

@interface NSNull (NullSafe_Yang)

@end
