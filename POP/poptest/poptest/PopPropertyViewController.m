//
//  PopPropertyViewController.m
//  poptest
//
//  Created by PerTerbin on 2017/7/9.
//  Copyright © 2017年 PerTerbin. All rights reserved.
//

#import "PopPropertyViewController.h"
#import "POP.h"

@interface PopPropertyViewController ()

@property (strong, nonatomic) UILabel *textLabel;
@property (assign, nonatomic) float value;

@end

@implementation PopPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.value = 0;
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 30)];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.text = @"0";
    [self.view addSubview:_textLabel];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 100) / 2, 240, 100, 30)];
    button.backgroundColor = [UIColor colorWithRed:52 / 255.0 green:152 / 255.0 blue:219 / 255.0 alpha:1];
    [button setTitle:@"Animation" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(textLabelAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)textLabelAnimation {
    POPBasicAnimation *animation = [POPBasicAnimation animation];
    POPAnimatableProperty *property = [POPAnimatableProperty propertyWithName:@"labelText" initializer:^(POPMutableAnimatableProperty *prop) {
        prop.readBlock = ^(UILabel *obj, CGFloat values[]) {
            values[0] = [obj.text floatValue];
        };
        
        prop.writeBlock = ^(UILabel *obj, const CGFloat values[]) {
            obj.text = [NSString stringWithFormat:@"%f", values[0]];
        };
    }];
    animation.property = property;
    animation.fromValue = @0;
    animation.toValue = @100;
    animation.duration = 1.0;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_textLabel pop_addAnimation:animation forKey:@"labelAnimation"];
}

@end
