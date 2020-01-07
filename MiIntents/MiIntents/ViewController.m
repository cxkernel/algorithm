//
//  ViewController.m
//  MiIntents
//
//  Created by coolkernel on 2018/11/29.
//  Copyright © 2018 CoolKernel. All rights reserved.
//

#import "ViewController.h"
#import "SceneIntent.h"
#import <objc/runtime.h>
#import <objc/message.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *path = @"/Users/coolkernel/Desktop/configs/roomconfig_11.json";

    NSLog(@"%@", [self localOldCardConfig]);
    NSLog(@"%@", [[NSFileManager defaultManager] URLsForDirectory:NSDesktopDirectory inDomains:NSUserDomainMask]);
}

- (id)localOldCardConfig
{
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, NO).lastObject;
//    path = [NSString stringWithFormat:@"%@/roomconfig_11.json", path];

//    [[NSFileManager defaultManager] URLsForDirectory:NSDesktopDirectory inDomains:NSUserDomainMask]
    NSString *path = @"/Users/coolkernel/Desktop/configs/roomconfig_11.json";
    id json = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        if (data) {
            NSError *error = nil;
            json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        }
    }

    return json;
}
@end


