//
//  MHManager.m
//  TechnologyPractice
//
//  Created by coolkernel on 2019/6/10.
//  Copyright © 2019 coolKernel. All rights reserved.
//

#import "MHManager.h"

@implementation MHManager

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static MHManager *processor = nil;
    dispatch_once(&onceToken, ^{
        processor = [MHManager new];
        NSLog(@"===%ld", onceToken);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            onceToken = 0;
        });
    });

    NSLog(@"///%ld", onceToken);

    return processor;
}

@end
