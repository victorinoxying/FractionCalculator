//
//  ViewController.m
//  homework6
//
//  Created by WF on 2018/5/3.
//  Copyright © 2018年 Victorinox. All rights reserved.
//

#import "ViewController.h"
#import "Keyboard.h"
@interface ViewController (){
    UILabel* showView;
}

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    int width=[[UIScreen mainScreen] bounds].size.width;
    int height=[[UIScreen mainScreen] bounds].size.height;//获得屏幕宽高，下面需要使用来设置控件大小
    
    showView=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, width,200)];
    showView.backgroundColor = [UIColor colorWithHexString:@" #F5F5F5"];
    showView.tag=1;//设置tag，方便后面对他操作
    [showView setTextAlignment:NSTextAlignmentRight];
    [showView setFont:[UIFont systemFontOfSize:40]];
    [self.view addSubview:showView];
    
    //创建了一个自定义视图，显示键盘，并且按键监控
    Keyboard *key=[[Keyboard alloc]initWithFrame:CGRectMake(0, 200, width, height-200)];
    [self.view addSubview:key];
    showView .text =[NSString stringWithFormat:@"%@",key.expression];//设置显示的结果
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    UIAlertController *alrt=[UIAlertController alertControllerWithTitle:@"victorinox" message:@"powered" preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alrt addAction:cancelAction];
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alrt addAction:cancelAction];
    
    [self presentViewController:alrt animated:YES completion:nil];
}

@end
