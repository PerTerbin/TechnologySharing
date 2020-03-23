//
//  Person.m
//  AspectsDemo
//
//  Created by PerTerbin on 2018/9/15.
//  Copyright © 2018年 PerTerbin. All rights reserved.
//

#import "Person.h"
#include <objc/runtime.h>

@implementation Person

- (void)printName {
    NSLog(@"My name is:%@", _name);
}

- (void)printNameWithSuffix:(NSString *)suffix {
    NSLog(@"My name is:%@%@", _name, suffix);
}

- (void)printInfo {
    NSLog(@"isa:%@, superclass:%@", object_getClass(self),
          class_getSuperclass(object_getClass(self)));
    
    NSLog(@"self.class:%@, [self superclass]:%@", self.class, [self superclass]);
}

@end
