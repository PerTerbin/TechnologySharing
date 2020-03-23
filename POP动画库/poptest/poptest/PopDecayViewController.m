//
//  PopDecayViewController.m
//  poptest
//
//  Created by PerTerbin on 2017/7/9.
//  Copyright © 2017年 PerTerbin. All rights reserved.
//

#import "PopDecayViewController.h"
#import "POP.h"

@interface PopDecayViewController ()<POPAnimationDelegate>

@property(nonatomic) UIControl *dragView;

@end

@implementation PopDecayViewController

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
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    _dragView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _dragView.center = self.view.center;
    _dragView.layer.cornerRadius = CGRectGetWidth(_dragView.bounds) / 2;
    _dragView.backgroundColor = [UIColor colorWithRed:52 / 255.0 green:152 / 255.0 blue:219 / 255.0 alpha:1];
    [_dragView addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [_dragView addGestureRecognizer:recognizer];
    
    [self.view addSubview:_dragView];
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if(recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        POPDecayAnimation *positionAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.delegate = self;
        positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        [recognizer.view.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    }
}

- (void)touchDown:(UIControl *)sender {
    [sender.layer pop_removeAllAnimations];
}


#pragma mark - POPAnimationDelegate
- (void)pop_animationDidApply:(POPDecayAnimation *)anim {
    BOOL isDragViewOutsideOfSuperView = !CGRectContainsRect(self.view.frame, self.dragView.frame);
    if (isDragViewOutsideOfSuperView) {
        CGPoint currentVelocity = [anim.velocity CGPointValue];
        CGPoint velocity = CGPointMake(currentVelocity.x, -currentVelocity.y);
        POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        positionAnimation.velocity = [NSValue valueWithCGPoint:velocity];
        positionAnimation.toValue = [NSValue valueWithCGPoint:self.view.center];
        [self.dragView.layer pop_addAnimation:positionAnimation forKey:@"layerPositionAnimation"];
    }
}

@end
