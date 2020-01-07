//
//  ViewController.m
//  TestICloud
//
//  Created by coolkernel on 2018/12/16.
//  Copyright © 2018 CoolKernel. All rights reserved.
//

#import "ViewController.h"
#import <CloudKit/CloudKit.h>
#import "MHViewController.h"

#define WriteToPath @"/Users/coolkernel/Desktop/filterResult.json"
#define OriginDataPath @"/Users/coolkernel/Desktop/filter.json"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSData *data = [NSData dataWithContentsOfFile:OriginDataPath];
    NSArray *list = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableArray *allContainer = @[].mutableCopy;

    NSMutableArray *mutiple = @[].mutableCopy;

    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr = [obj1 objectForKey:@"models"];
        __block BOOL isequal = NO;
        [allContainer enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj2, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj2.count == arr.count) {
                isequal = YES;
                [obj2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (![arr[idx] isEqualToString:obj]) {
                        isequal = NO;
                        *stop = YES;
                    }
                }];
            }

            if (isequal) {
                *stop = YES;
            }
        }];
        if (isequal) {
            [mutiple addObject:arr];
        }

        [allContainer addObject:arr];
    }];

    NSLog(@"======%@", mutiple);

    [self deleteMutipleConfig:list mutiple:mutiple];
}

- (void)deleteMutipleConfig:(NSArray *)origin mutiple:(NSArray *)mutiple
{
    NSMutableArray *originData = origin.mutableCopy;
    [mutiple enumerateObjectsUsingBlock:^(NSArray * _Nonnull mutipleModels, NSUInteger idx, BOOL * _Nonnull stop) {
        __block BOOL isequal = NO;
        __block NSInteger index = -1;
        [originData enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull category, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *modes = [category objectForKey:@"models"];
            if (mutipleModels.count == modes.count) {
                isequal = YES;
                [mutipleModels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (![modes[idx] isEqualToString:obj]) {
                        isequal = NO;
                        *stop = YES;
                    }
                }];
            }

            if (isequal) {
                index = idx;
                *stop = YES;
            }
        }];

        if (index >= 0) {
            [originData removeObjectAtIndex:index];
        }
    }];

    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:originData options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    BOOL success = [jsonData writeToFile:WriteToPath atomically:YES];
    NSLog(@"=======%d", success);
}


@end
