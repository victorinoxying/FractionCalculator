//
//  Calculator.h
//  homework6
//
//  Created by WF on 2018/5/3.
//  Copyright © 2018年 Victorinox. All rights reserved.
//
#import <UIKit/UIKit.h>
#import"Fraction.h"
#import"Stack.h"

@interface Calculator : NSObject

-(Fraction*)Calculate:(NSMutableArray*) postfix;
+(bool)IsOper:(NSString*)oper;
-(NSMutableArray*)infixTopostfix:(NSString*)infix;
+(int)Priority:(NSString*)oper;
+(Fraction*)StringToFraction:(NSString*)string;
+(void)GetResult:(NSString* )oper stack:(Stack*) tmpStack;
+(BOOL)isPureInt:(NSString*)string;
@end

