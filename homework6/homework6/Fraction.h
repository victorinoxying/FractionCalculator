//
//  Fraction.h
//  homework6
//
//  Created by WF on 2018/5/3.
//  Copyright © 2018年 Victorinox. All rights reserved.
//

#import<UIKit/UIKit.h>
@interface Fraction : NSObject
@property int numerator, denominator;
-(void) print;
-(void) setTo: (int) n over :(int) d;
-(Fraction *) add:(Fraction*) f;
-(Fraction * )subtract :(Fraction *)f;
-(Fraction * )multiply :(Fraction *)f;
-(Fraction * )divide :(Fraction *)f;
-(void) reduce;
-(double) convertToNum;
-(NSString *)convertToString;

@end
