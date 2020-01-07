//
//  MHLoad.m
//  TechnologyPractice
//
//  Created by coolkernel on 2019/6/21.
//  Copyright © 2019 coolKernel. All rights reserved.
//

#import "MHLoad.h"

@implementation MHLoad
+ (void)load {
//    NSLog(@"%s", __func__);
}

- (void)testAtomicValue {
    self.age = @10;
    NSNumber *age = self.age;
    NSLog(@"%@", age);
}

@end
