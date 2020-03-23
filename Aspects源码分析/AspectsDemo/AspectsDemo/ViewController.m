//
//  ViewController.m
//  AspectsDemo
//
//  Created by PerTerbin on 2018/9/15.
//  Copyright © 2018年 PerTerbin. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Aspects.h"

@interface ViewController ()

@property (nonatomic, strong) Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hookClassAction:(id)sender {
    Person *person1 = [Person new];
    person1.name = @"person1";
    Person *person2 = [Person new];
    person2.name = @"person2";
    
    [Person aspect_hookSelector:@selector(printName) withOptions:AspectPositionBefore usingBlock:^{
        NSLog(@"Person hooked");
    } error:nil];
    
    [person1 printName];
    [person2 printName];
}


- (IBAction)hookInstanceAction:(id)sender {
    Person *person1 = [Person new];
    person1.name = @"person1";
    Person *person2 = [Person new];
    person2.name = @"person2";
    
    [person1 aspect_hookSelector:@selector(printName) withOptions:AspectPositionBefore usingBlock:^{
        NSLog(@"Person hooked");
    } error:nil];
    
    [person1 printName];
    [person2 printName];
}

- (IBAction)hookInsteadAction:(id)sender {
    Person *person1 = [Person new];
    person1.name = @"person1";
    [person1 printName];
    
    [person1 aspect_hookSelector:@selector(printName) withOptions:AspectPositionInstead usingBlock:^{
        NSLog(@"Person hooked");
    } error:nil];
    
    [person1 printName];
}

- (IBAction)hookAfterAction:(id)sender {
    Person *person1 = [Person new];
    person1.name = @"person1";
    
    [person1 aspect_hookSelector:@selector(printName) withOptions:AspectPositionAfter usingBlock:^{
        NSLog(@"Person hooked");
    } error:nil];
    
    [person1 printName];
}


- (IBAction)getMethodArgumentsAction:(id)sender {
    Person *person1 = [Person new];
    person1.name = @"person1";
    
    [person1 aspect_hookSelector:@selector(printNameWithSuffix:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, NSString *suffix){
        NSArray *arguments = aspectInfo.arguments;
        NSLog(@"Person:(%@) hooked, suffix:%@. arguments:%@", aspectInfo.instance, suffix, arguments);
    } error:nil];
    
    [person1 printNameWithSuffix:@"_coder"];
}

- (IBAction)removeAspectCodeAction:(id)sender {
    Person *person1 = [Person new];
    person1.name = @"person1";
    Person *person2 = [Person new];
    person2.name = @"person2";
    
    // remove automatically
    [Person aspect_hookSelector:@selector(printName) withOptions:AspectPositionBefore | AspectOptionAutomaticRemoval usingBlock:^{
        NSLog(@"Person hooked");
    } error:nil];
    
    [person1 printName];
    [person2 printName];
    
    Person *person3 = [Person new];
    person3.name = @"person3";
    
    id<AspectToken> token = [Person aspect_hookSelector:@selector(printName) withOptions:AspectPositionBefore usingBlock:^{
        NSLog(@"Person hooked");
    } error:nil];
    
    [person1 printName];
    [person2 printName];
    [token remove];
    [person3 printName];
}

- (IBAction)kvoAction:(id)sender {
    self.person = [Person new];
    self.person.name = @"Lily";
    [self.person printInfo];
    
    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    self.person.name = @"Jane";
    [self.person printInfo];
    
    [self.person removeObserver:self forKeyPath:@"name"];
    [self.person printInfo];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSLog(@"监听到了%@的%@属性发生了改变", object, keyPath);
    NSLog(@"%@", change);
}

@end
