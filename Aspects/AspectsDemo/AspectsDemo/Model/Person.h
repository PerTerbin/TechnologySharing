//
//  Person.h
//  AspectsDemo
//
//  Created by PerTerbin on 2018/9/15.
//  Copyright © 2018年 PerTerbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;

- (void)printName;

- (void)printNameWithSuffix:(NSString *)suffix;

- (void)printInfo;

@end
