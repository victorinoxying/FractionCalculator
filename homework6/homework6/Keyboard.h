//
//  Keyboard.h
//  homework6
//
//  Created by WF on 2018/5/5.
//  Copyright © 2018年 Victorinox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculator.h"

@interface Keyboard : UIView
{
    Fraction * result;
    UIButton *button;
    Calculator* calculatorCore;
}
@property (nonatomic,strong)NSMutableString * expression;
-(id)initWithFrame:(CGRect)frame;
@end


