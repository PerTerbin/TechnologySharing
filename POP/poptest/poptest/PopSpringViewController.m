//
//  PopSpringViewController.m
//  poptest
//
//  Created by PerTerbin on 2017/7/9.
//  Copyright © 2017年 PerTerbin. All rights reserved.
//

#import "PopSpringViewController.h"
#import "POP.h"

@interface PopSpringViewController ()

@property (nonatomic) UILabel *errorLabel;
@property (nonatomic) UIButton *button;
@property (nonatomic) UIActivityIndicatorView *activityIndicatorView;


@end

@implementation PopSpringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    _button = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 80) / 2, 200, 100, 50)];
    _button.layer.cornerRadius = 4;
    [_button setTitle:@"Login" forState:UIControlStateNormal];
    _button.backgroundColor = [UIColor colorWithRed:52 / 255.0 green:152 / 255.0 blue:219 / 255.0 alpha:1];
    [_button addTarget:self action:@selector(scaleToSmall) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragEnter];
    [_button addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [_button addTarget:self action:@selector(scaleToDefault) forControlEvents:UIControlEventTouchDragExit];
    [self.view addSubview:_button];
    
    _errorLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, 20)];
    _errorLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18];
    _errorLabel.textColor = [UIColor colorWithRed:231 / 255.0 green:76 / 255.0 blue:60 / 255.0 alpha:1];
    _errorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _errorLabel.text = @"Just a serious login error.";
    _errorLabel.textAlignment = NSTextAlignmentCenter;
    _errorLabel.layer.opacity = 0.0;
    [self.view insertSubview:_errorLabel belowSubview:_button];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicatorView];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)scaleToSmall {
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.95f, 0.95f)];
    [_button.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}

- (void)touchUpInside {
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.springBounciness = 18.0f;
    [_button.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
    
    [self hideLabel];
    [self.activityIndicatorView startAnimating];
    _button.userInteractionEnabled = NO;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self.activityIndicatorView stopAnimating];
        [self shakeButton];
        [self showLabel];
    });
}

- (void)scaleToDefault {
    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [_button.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleDefaultAnimation"];
}

- (void)hideLabel {
    POPBasicAnimation *layerScaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    layerScaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.5f, 0.5f)];
    [self.errorLabel.layer pop_addAnimation:layerScaleAnimation forKey:@"layerScaleAnimation"];
    
    POPBasicAnimation *layerPositionAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    layerPositionAnimation.toValue = @(self.button.layer.position.y);
    _errorLabel.layer.opacity = 0.0;
    [self.errorLabel.layer pop_addAnimation:layerPositionAnimation forKey:@"layerPositionAnimation"];
}

- (void)showLabel {
    self.errorLabel.layer.opacity = 1.0;
    POPSpringAnimation *layerScaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    layerScaleAnimation.springBounciness = 18;
    layerScaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    [self.errorLabel.layer pop_addAnimation:layerScaleAnimation forKey:@"labelScaleAnimation"];
    
    POPSpringAnimation *layerPositionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    layerPositionAnimation.toValue = @(self.button.layer.position.y + self.button.intrinsicContentSize.height);
    layerPositionAnimation.springBounciness = 12;
    [self.errorLabel.layer pop_addAnimation:layerPositionAnimation forKey:@"layerPositionAnimation"];
}

- (void)shakeButton {
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    positionAnimation.velocity = @2000;
    positionAnimation.springBounciness = 20;
    [positionAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        self.button.userInteractionEnabled = YES;
    }];
    [self.button.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
}

@end
