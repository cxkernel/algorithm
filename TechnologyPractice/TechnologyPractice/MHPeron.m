//
//  MHPeron.m
//  TechnologyPractice
//
//  Created by coolkernel on 2019/7/7.
//  Copyright © 2019 coolKernel. All rights reserved.
//

#import "MHPeron.h"

@implementation MHPeron
- (id)copyWithZone:(NSZone *)zone {
    MHPeron *person = [MHPeron new];
    person.name = self.name;
    person.age = self.age;

    return self;
}

@end
