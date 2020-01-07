//
//  MHSceneHandler.m
//  Intent
//
//  Created by coolkernel on 2019/1/9.
//  Copyright © 2019 CoolKernel. All rights reserved.
//

#import "MHSceneHandler.h"

@implementation MHSceneHandler
- (void)handleCaptureScene:(CaptureSceneIntent *)intent completion:(void (^)(CaptureSceneIntentResponse *response))completion NS_SWIFT_NAME(handle(intent:completion:))
{
    CaptureSceneIntentResponse *response = [[CaptureSceneIntentResponse alloc] initWithCode:CaptureSceneIntentResponseCodeSuccess userActivity:nil];
    completion(response);

}

- (void)confirmCaptureScene:(CaptureSceneIntent *)intent completion:(void (^)(CaptureSceneIntentResponse *response))completion NS_SWIFT_NAME(confirm(intent:completion:))
{
    CaptureSceneIntentResponse *response = [[CaptureSceneIntentResponse alloc] initWithCode:CaptureSceneIntentResponseCodeReady userActivity:nil];
    completion(response);

}


@end
