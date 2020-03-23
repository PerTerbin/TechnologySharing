//
//  IOViewController.m
//  WoodPeckerDemo
//
//  Created by xiaogang zhang on 2018/1/17.
//  Copyright © 2018年 lifebetter. All rights reserved.
//

#import "IOViewController.h"
#import "WoodPeckeriOS/WoodPeckeriOS.h"
#import "EchoService.h"

@interface IOViewController ()

@end

@implementation IOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)logButtonPressed:(id)sender {
    NSString * text = @"A channel between mac and your app, you can transfer data, call service in you app, or log message to mac client,  try log something, or you create a custom ADHService";
    // log to mac
    adhColorLog([UIColor redColor], text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
