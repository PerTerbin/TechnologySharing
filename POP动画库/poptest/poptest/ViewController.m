//
//  ViewController.m
//  poptest
//
//  Created by PerTerbin on 2017/7/9.
//  Copyright © 2017年 PerTerbin. All rights reserved.
//

#import "ViewController.h"
#import <pop/POP.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initView {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 50, 50)];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"动画" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(animation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(150, 100, 50, 50)];
    button2.backgroundColor = [UIColor grayColor];
    [button2 setTitle:@"动画" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(animation2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(250, 100, 50, 50)];
    button3.backgroundColor = [UIColor grayColor];
    [button3 setTitle:@"动画" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(animation3:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}

- (void)animation:(UIButton *)button {
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(button.center.x, button.center.y + 100)];
    [button pop_addAnimation:animation forKey:@"animation"];
}

- (void)animation2:(UIButton *)button {
    //    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    animation.springBounciness = 10;
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(button.center.x, button.center.y + 100)];
    [button pop_addAnimation:animation forKey:@"animation"];
}

- (void)animation3:(UIButton *)button {
    POPDecayAnimation *animation = [POPDecayAnimation animationWithPropertyNamed:kPOPViewCenter];
    animation.velocity = [NSValue valueWithCGPoint:CGPointMake(0, 100)];
    [button pop_addAnimation:animation forKey:@"animation"];
}

@end
