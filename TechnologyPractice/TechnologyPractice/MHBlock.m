//
//  MHBlock.m
//  TechnologyPractice
//
//  Created by coolkernel on 2019/6/23.
//  Copyright © 2019 coolKernel. All rights reserved.
//

#import "MHBlock.h"

@implementation MHBlock
{

}

- (void)blockReference {
    __weak typeof(self) ws = self;
    NSLog(@"start retaincount self:%ld, %p", [self objCount:self], self);
    self.callBack = ^{
        NSLog(@"ws retaincount ws:%ld, %p", [ws objCount:ws], ws);
        __strong typeof(ws) ss = ws;
        NSLog(@"ws retaincount ws:%ld, %p", [ws objCount:ws], ws);
        NSLog(@"ss retaincount ss:%ld, %p", [ss objCount:ss], ss);

    };

    self.callBack();
    NSLog(@"end retaincount self:%ld", [self objCount:self]);
}

- (NSInteger)objCount:(NSObject *)obj {
    id result = [obj valueForKey:@"retainCount"];
    return [result integerValue];
}

@end

