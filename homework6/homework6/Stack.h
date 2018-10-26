//
//  Stack.h
//  homework6
//
//  Created by WF on 2018/5/4.
//  Copyright © 2018年 Victorinox. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^StackBlock)(id obj);

// 简单实现一个栈
@interface Stack : NSObject

/**
 入栈
 @param obj 指定入栈对象
 */
- (void)push:(id)obj;

/**
 出栈
 */
- (id)pop;

/**
 是否为空
 */
- (BOOL)isEmpty;

/**
 栈的长度
 */
- (NSInteger)length;

/**
 从栈底开始遍历
 @param block 回调遍历的结果
 */
-(void)enumerateObjectsFromBottom:(StackBlock)block;

/**
 从顶部开始遍历
 */
-(void)enumerateObjectsFromtop:(StackBlock)block;

/**
 所有元素出栈，一边出栈一边返回元素
 */
-(void)enumerateObjectsPopStack:(StackBlock)block;

/**
 清空
 */
-(void)removeAllObjects;

/**
 返回栈顶元素
 */
-(id)topObj;

@end
