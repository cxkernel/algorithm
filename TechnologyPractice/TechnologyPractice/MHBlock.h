//
//  MHBlock.h
//  TechnologyPractice
//
//  Created by coolkernel on 2019/6/23.
//  Copyright © 2019 coolKernel. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHBlock : NSObject
@property (nonatomic, copy) void (^callBack)(void);
@property (nonatomic, copy) NSString *name;

- (void)blockReference;

@end

NS_ASSUME_NONNULL_END
