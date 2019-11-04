//
//  ViewController.m
//  DMProgressHud
//
//  Created by ymt_dsz on 2019/11/4.
//  Copyright © 2019 dsz. All rights reserved.
//

#import "ViewController.h"
#import "DMToastViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"弹窗组件";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame  = CGRectMake(100, 100, [UIScreen mainScreen].bounds.size.width-200, 50);
    btn.backgroundColor = UIColor.lightGrayColor;
    [btn setTitle:@"toast弹窗" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view.
}

- (void)btnClick:(UIButton *)btn{
    [self.navigationController pushViewController:[[DMToastViewController alloc]init] animated:NO];
        
}
@end
