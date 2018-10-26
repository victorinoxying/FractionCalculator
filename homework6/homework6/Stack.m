//
//  Stack.m
//  homework6
//
//  Created by WF on 2018/5/4.
//  Copyright © 2018年 Victorinox. All rights reserved.
//

#import "Stack.h"

@interface Stack ()
// 存储栈数据
@property (nonatomic, strong) NSMutableArray *stackArray;
@end

@implementation Stack

- (void)push:(id)obj {
    [self.stackArray addObject:obj];
}

- (id)pop {
    if ([self isEmpty]) {
        return nil;
    } else {
        id obj = self.stackArray.lastObject;
        [self.stackArray removeLastObject];
        return obj;
    }
}

- (BOOL)isEmpty {
    return !self.stackArray.count;
}

- (NSInteger)length {
    return self.stackArray.count;
}

-(void)enumerateObjectsFromBottom:(StackBlock)block {
    [self.stackArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block ? block(obj) : nil;
    }];
}

-(void)enumerateObjectsFromtop:(StackBlock)block {
    [self.stackArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        block ? block(obj) : nil;
    }];
}

-(void)enumerateObjectsPopStack:(StackBlock)block {
    __weak typeof(self) weakSelf = self;
    NSUInteger count = self.stackArray.count;
    for (NSUInteger i = count; i > 0; i --) {
        if (block) {
            block(weakSelf.stackArray.lastObject);
            [self.stackArray removeLastObject];
        }
    }
}

-(void)removeAllObjects {
    [self.stackArray removeAllObjects];
}

-(id)topObj {
    if ([self isEmpty]) {
        return nil;
    } else {
        return self.stackArray.lastObject;
    }
}

- (NSMutableArray *)stackArray {
    if (!_stackArray) {
        _stackArray = [NSMutableArray array];
    }
    return _stackArray;
}
@end
