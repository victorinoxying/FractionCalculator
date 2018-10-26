//
//  Calculator.m
//  homework6
//
//  Created by WF on 2018/5/3.
//  Copyright © 2018年 Victorinox. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

-(id)init{
    self = [super init];
    return self;
}

+(bool)IsOper:(NSString *)oper{
    if([oper isEqualToString:@"+"]||[oper isEqualToString:@"-"]||[oper isEqualToString:@"x"]||[oper isEqualToString:@"÷"])
        return true;
    else
        return false;
}

+(int)Priority:(NSString *)oper{
    int priority =0;
    if([oper isEqualToString:@"+"]||[oper isEqualToString:@"-"])
        priority = 1;
    else if([oper isEqualToString:@"x"]||[oper isEqualToString:@"÷"])
        priority= 2;
    return priority;
}


-(NSMutableArray*)infixTopostfix:(NSString *)infix{
    Stack* operators = [[Stack alloc]init];
    NSMutableArray* postfix = [[NSMutableArray alloc]init];
    NSArray* array = [infix componentsSeparatedByString:@" "];
    for(int i=0;i<[array count];i++){
        if(![Calculator IsOper:array[i]]){
            [postfix addObject:array[i]];
        }
        else{
            if([operators length]<=0){
                [operators push:array[i]];
            }
            else if([Calculator Priority:array[i]]<=[Calculator Priority:[operators topObj]]){
                [postfix addObject:[operators topObj]];
                [operators pop];
                while ([operators length]>0&&[Calculator Priority:array[i]]<=[Calculator Priority:[operators topObj]]) {
                    [postfix addObject:[operators topObj]];
                    [operators pop];
                }
                [operators push:array[i]];
            }
            else{
                [operators push:array[i]];
            }
        }
    }
    
    while([operators length]>0){
        NSString* str = [operators topObj];
        [postfix addObject:str];
        [operators pop];
    }
    return postfix;
}

-(Fraction*)Calculate:(NSMutableArray*)postfix{
    if([postfix count]<=0){
        return nil;
    }
    Stack * stack = [[Stack alloc]init];
    for(int i =0; i<[postfix count];i++){
        if(![Calculator IsOper:postfix[i]]){
            [stack push:[Calculator StringToFraction: postfix[i]]];
        }
        else{
            [Calculator GetResult:postfix[i] stack:stack];
        }
    }
    if([stack length]>0){
        return [stack topObj];
    }
    else
        return nil;
}

+(Fraction*)StringToFraction:(NSString *)string{
    NSArray* array = [[NSArray alloc]init];
    Fraction* fraction = [[Fraction alloc]init];
    if([Calculator isPureInt:string]){
        fraction.numerator = [string intValue];
        fraction.denominator = 1;
    }
    else{
        array = [string componentsSeparatedByString:@"/"];
        fraction.numerator = [array[0] intValue];
        fraction.denominator = [array[1] intValue];
    }
   return fraction;
}

+(void)GetResult:(NSString *)oper stack:(Stack *)tmpStack{
    if([tmpStack length]<2){
        return;
    }
    Fraction* secondVal = [tmpStack topObj];
    [tmpStack pop];
    Fraction* firstVal = [tmpStack topObj];
    [tmpStack pop];
    
    Fraction* result = [[Fraction alloc]init];
    if([oper isEqualToString: @"+"])
        result = [firstVal add: secondVal];
    else if([oper isEqualToString: @"-"])
        result = [firstVal subtract:secondVal];
    else if([oper isEqualToString: @"x"])
        result = [firstVal multiply:secondVal];
    else if([oper isEqualToString: @"÷"])
        result = [firstVal divide: secondVal];
    [tmpStack push:result];
}

+(BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
    
}

@end
