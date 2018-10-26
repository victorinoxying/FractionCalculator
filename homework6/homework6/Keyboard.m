//
//  Keyboard.m
//  homework6
//
//  Created by WF on 2018/5/5.
//  Copyright © 2018年 Victorinox. All rights reserved.
//

#import "Keyboard.h"

@implementation Keyboard

//初始化，用两层for循环来创建的键盘
-(id)initWithFrame:(CGRect)frame
{
    
    if ([super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        //初始化
        result=[[Fraction alloc]init];
        self.expression = [[NSMutableString alloc]init];
        calculatorCore = [[Calculator alloc]init];
        
        int width=frame.size.width;
        int height=frame.size.height;
        
        for (int i=0; i<5; i++) {
            for (int j=0; j<4; j++) {
                
                if ((i==4)&&(j==0)) {
                    //这里创建的是按键 0 的按钮，因为按键 0 占了两个，宽度是原先的两倍，并且跳过下一次的按钮创建
                    button=[[UIButton alloc]initWithFrame:CGRectMake(j*(width/4), i*(height/5), width/2, height/5)];
                    button.backgroundColor=[UIColor whiteColor];
                    button.tag=(i+1)*10+(j+1);//设置tag的值
                    [button.layer setBorderWidth:0.5];//设置边框
                    button.layer.borderColor = [UIColor grayColor].CGColor;
                    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [button setTitle:@"0" forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(number:) forControlEvents:UIControlEventTouchDown];
                    [self addSubview:button];
                    j++;
                    continue;
                }
                
                //按钮的创建，按钮的宽高是通过计算得出来的，为了屏幕适配
                button=[[UIButton alloc]initWithFrame:CGRectMake(j*(width/4), i*(height/5), width/4, height/5)];
                button.backgroundColor=[UIColor whiteColor];
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [button.layer setBorderWidth:0.5];
                button.tag=(i+1)*10+(j+1);
                
                if (((j+1)==4)&&(i+1)==5) {
                    //在这里设置最边上竖排的按钮颜色为橘黄色
                    [button setBackgroundColor:[UIColor orangeColor]];
                }
                if (((j+1)==1)&&(i+1)==1) {
                    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                }
                [self addSubview:button];
                
                
                if (i>0&&j<3&&i<4) {//在这里，为数字按键赋显示的值
                    int num=(3-i)*3+(j+1);//num 的值可以通过计算得出来，与i、j相关
                    NSString *s=[NSString stringWithFormat:@"%d",num];//把int转成字符串，并给按钮赋值
                    [button setTitle:s forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(number:) forControlEvents:UIControlEventTouchDown];
                    //这里为数字按键设置方法、因为数字是一类的，所以都用一个方法
                }
                
                switch (button.tag) {
                        //这里为其他的功能键设置显示和按键的方法
                    case 11:
                        [button setTitle:@"C" forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchDown];
                        break;
                    case 12:
                        [button setTitle:@"x/y" forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(fractionSignal:) forControlEvents:UIControlEventTouchDown];
                        break;
                    case 13:
                        [button setTitle:@"digitalize" forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(digitalize:) forControlEvents:UIControlEventTouchDown];
                        break;
                    case 14:
                        [button setTitle:@"÷" forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(operator:) forControlEvents:UIControlEventTouchDown];
                        break;
                    case 24:
                        [button setTitle:@"x" forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(operator:) forControlEvents:UIControlEventTouchDown];
                        break;
                    case 34:
                        [button setTitle:@"-" forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(operator:) forControlEvents:UIControlEventTouchDown];
                        break;
                    case 44:
                        [button setTitle:@"+" forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(operator:) forControlEvents:UIControlEventTouchDown];
                        break;
                    case 53:
                        [button setTitle:@"fractionize" forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(fractionize:) forControlEvents:UIControlEventTouchDown];
                        break;
                    case 54:
                        [button setTitle:@"=" forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(calculate:) forControlEvents:UIControlEventTouchDown];
                        break;
                    default:
                        break;
                }
            }
        }
    }
    [self HideFractionSignal];
    return self;
}

-(void)number:(UIButton*)btn{
    [self.expression appendString: btn.titleLabel.text];
    
    //这里是取到父视图，通过tag取到label，但是注意一点，，通过tag取到的是视图对象，这里先强制类型转换一下，然后用uilabel对象接收，这样就可以操作者的label对象
    
    UILabel *lable=(UILabel*)[[self superview] viewWithTag:1];
    lable.text= self.expression;
    
    [self showSignals];
    
}

-(void)showSignals{
    UIButton * fractionsignal = (UIButton*) [self viewWithTag:12];
    fractionsignal.userInteractionEnabled =YES;
    fractionsignal.alpha =1;
    
    UIButton * plus = (UIButton*) [self viewWithTag:44];
    plus.userInteractionEnabled =YES;
    plus.alpha =1;
    UIButton * sub = (UIButton*) [self viewWithTag:34];
    sub.userInteractionEnabled =YES;
    sub.alpha =1;
    UIButton * mul = (UIButton*) [self viewWithTag:24];
    mul.userInteractionEnabled = YES;
    mul.alpha =1;
    UIButton * div = (UIButton*) [self viewWithTag:14];
    div.userInteractionEnabled = YES;
    div.alpha =1;
    UIButton * equal = (UIButton*) [self viewWithTag:54];
    equal.userInteractionEnabled = YES;
    equal.alpha =1;
}

-(void)HideFractionSignal{
    UIButton * fractionsignal = (UIButton*) [self viewWithTag:12];
    fractionsignal.userInteractionEnabled =NO;
    fractionsignal.alpha =0.4;
    
    UIButton * plus = (UIButton*) [self viewWithTag:44];
    plus.userInteractionEnabled =NO;
    plus.alpha =0.4;
    UIButton * sub = (UIButton*) [self viewWithTag:34];
    sub.userInteractionEnabled =NO;
    sub.alpha =0.4;
    UIButton * mul = (UIButton*) [self viewWithTag:24];
    mul.userInteractionEnabled =NO;
    mul.alpha =0.4;
    UIButton * div = (UIButton*) [self viewWithTag:14];
    div.userInteractionEnabled =NO;
    div.alpha =0.4;
    UIButton * equal = (UIButton*) [self viewWithTag:54];
    equal.userInteractionEnabled = NO;
    equal.alpha =0.4;
}

-(void)clear{
    [self.expression setString:@""];
    [result setTo:0 over:1];
    UILabel *lable=(UILabel*)[[self superview] viewWithTag:1];
    lable.text= self.expression;
    
    [self HideFractionSignal];
}

-(void)operator:(UIButton*)btn{
    [self HideFractionSignal];
    
    if([btn.titleLabel.text isEqualToString: @"+"]){
        [self.expression appendString:@" + "];
        UILabel *lable=(UILabel*)[[self superview] viewWithTag:1];
        lable.text= self.expression;
    }
    
    else if([btn.titleLabel.text isEqualToString: @"-"]){
        [self.expression appendString:@" - "];
        UILabel *lable=(UILabel*)[[self superview] viewWithTag:1];
        lable.text= self.expression;
    }
    
    else if([btn.titleLabel.text isEqualToString: @"x"]){
        [self.expression appendString:@" x "];
        UILabel *lable=(UILabel*)[[self superview] viewWithTag:1];
        lable.text= self.expression;
    }
    
    else if([btn.titleLabel.text isEqualToString: @"÷"]){
        [self.expression appendString:@" ÷ "];
        UILabel *lable=(UILabel*)[[self superview] viewWithTag:1];
        lable.text= self.expression;
    }
    
    
}

-(void)digitalize:(UIButton*)btn{
    [self HideFractionSignal];
    
    UILabel *lable=(UILabel*)[[self superview] viewWithTag:1];
    lable.text= [NSMutableString stringWithFormat:@"%lf",[result convertToNum]];
    
}

-(void)fractionize:(UIButton*)btn{
    [self HideFractionSignal];
    
    [self.expression setString: [result convertToString]];
    UILabel *lable=(UILabel*)[[self superview] viewWithTag:1];
    lable.text= self.expression;
}
-(void)fractionSignal:(UIButton* )btn{
    [self HideFractionSignal];
    
    [self.expression appendString:@"/"];
    UILabel *lable=(UILabel*)[[self superview] viewWithTag:1];
    lable.text= self.expression;
}

-(void)calculate:(UIButton*)btn{
    [self HideFractionSignal];
    
    NSMutableArray * postfix =[calculatorCore infixTopostfix: self.expression];
    result = [calculatorCore Calculate:postfix];
    if(result.denominator <0){
        result.denominator= -result.denominator;
        result.numerator =- result.numerator;
    }
    [self.expression setString: [result convertToString]];
    UILabel *lable=(UILabel*)[[self superview] viewWithTag:1];
    lable.text= self.expression;
    
    [self showSignals];
    UIButton * fractionsignal = (UIButton*) [self viewWithTag:12];
    fractionsignal.userInteractionEnabled =NO;
    fractionsignal.alpha =0.4;
    
    
}
@end
