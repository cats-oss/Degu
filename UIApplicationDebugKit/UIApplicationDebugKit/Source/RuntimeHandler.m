//
//  RuntimeHandler.m
//  UIApplicationDebugKit
//
//  Created by marty-suzuki on 2018/04/26.
//  Copyright © 2018年 AbemaTV. All rights reserved.
//

#import "RuntimeHandler.h"

@implementation _RuntimeHandler

+ (void)handleLoad {
    NSLog(@"Please override RuntimeHandler.handleLoad if you want to use");
}

+ (void)handleInitialize {
    NSLog(@"Please override RuntimeHandler.handleInitialize if you want to use");
}

@end

@implementation RuntimeHandler

+ (void)initialize {
    [super initialize];
    [self handleInitialize];
}

+ (void)load {
    [super load];
    [self handleLoad];
}

@end
