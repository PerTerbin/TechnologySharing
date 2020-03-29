//
//  PopFoldingViewController.m
//  poptest
//
//  Created by PerTerbin on 2017/7/9.
//  Copyright © 2017年 PerTerbin. All rights reserved.
//

#import "PopFoldingViewController.h"
#import "FoldingView.h"

@interface PopFoldingViewController ()

@property(nonatomic) FoldingView *foldView;

@end

@implementation PopFoldingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.foldView poke];
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat padding = 30.f;
    CGFloat width = CGRectGetWidth(self.view.bounds) - padding * 2;
    CGRect frame = CGRectMake(0, 0, width, width);
    
    _foldView = [[FoldingView alloc] initWithFrame:frame image:[UIImage imageNamed:@"boat"]];
    _foldView.center = self.view.center;
    [self.view addSubview:self.foldView];
}

@end
