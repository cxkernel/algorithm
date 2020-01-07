//
//  MHSiriShortcutController.m
//  Pods
//
//  Created by coolkernel on 2018/11/7.
//

#import "MHSiriShortcutController.h"
#import <UIKit/UIKit.h>


@implementation MHSceneShortcut

@end

#define XM_WS(weakself) __weak typeof(self) weakself = self;
@interface MHSiriShortcutController()<INUIEditVoiceShortcutViewControllerDelegate, INUIAddVoiceShortcutViewControllerDelegate>
@property (nonatomic, copy) void (^addCompletion)(INVoiceShortcut *);
@property (nonatomic, copy) void (^editCompletion)(INVoiceShortcut *, NSUUID *deleteIdentifier);

@end
@implementation MHSiriShortcutController

- (void)addSceneAutoSiriShortcut:(MHSceneShortcut *)sceneShortcut
                      completion:(void (^)(INVoiceShortcut *))completion {
    MHSceneAutoIntent *intent = [[MHSceneAutoIntent alloc] init];
    intent.sceneName = sceneShortcut.sceneName;
    INShortcut *shortcut = [[INShortcut alloc] initWithIntent:intent];
    INUIAddVoiceShortcutViewController *addVoiceShortcutVC = [[INUIAddVoiceShortcutViewController alloc] initWithShortcut:shortcut];
    addVoiceShortcutVC.delegate = self;
    self.addCompletion = completion;
    [[[self class] topMostViewController] presentViewController:addVoiceShortcutVC animated:YES completion:^{

    }];
}

- (void)editSceneAutoSiriShortcut:(MHSceneShortcut *)sceneShortcut
                 updateCompletion:(void (^)(INVoiceShortcut *))updateCompletion
                 deleteCompeltion:(void (^)(NSUUID *))deleteCompeltion
{
    MHSceneAutoIntent *intent = [[MHSceneAutoIntent alloc] init];
    intent.sceneName = sceneShortcut.sceneName;
    XM_WS(ws);
    [[INVoiceShortcutCenter sharedCenter] getVoiceShortcutWithIdentifier:sceneShortcut.identifier completion:^(INVoiceShortcut * _Nullable voiceShortcut, NSError * _Nullable error) {
        XMDispatchMain(^{
            INUIEditVoiceShortcutViewController *editVoiceShortcut = [[INUIEditVoiceShortcutViewController alloc] initWithVoiceShortcut:voiceShortcut];
            editVoiceShortcut.delegate = ws;
            ws.editCompletion = ^(INVoiceShortcut *voice, NSUUID *deleteIdentifier) {
                if (voice) {
                    if (updateCompletion) {
                        updateCompletion(voice);
                    }
                }
                if (deleteIdentifier) {
                    if (deleteCompeltion) {
                        deleteCompeltion(deleteIdentifier);
                    }
                }
            };
            [[[ws class] topMostViewController] presentViewController:editVoiceShortcut animated:YES completion:^{

            }];
        });
    }];
}

#pragma mark - INUIEditVoiceShortcutViewControllerDelegate
- (void)editVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)controller didUpdateVoiceShortcut:(nullable INVoiceShortcut *)voiceShortcut error:(nullable NSError *)error;
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (self.editCompletion) {
        self.editCompletion(voiceShortcut, nil);
    }
}

- (void)editVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)controller didDeleteVoiceShortcutWithIdentifier:(NSUUID *)deletedVoiceShortcutIdentifier;
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (self.editCompletion) {
        self.editCompletion(nil, deletedVoiceShortcutIdentifier);
    }
}

- (void)editVoiceShortcutViewControllerDidCancel:(INUIEditVoiceShortcutViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (self.editCompletion) {
        self.editCompletion(nil, nil);
    }
}

#pragma - mark <INUIAddVoiceShortcutViewControllerDelegate>
- (void)addVoiceShortcutViewController:(INUIAddVoiceShortcutViewController *)controller didFinishWithVoiceShortcut:(nullable INVoiceShortcut *)voiceShortcut error:(nullable NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (self.addCompletion) {
        self.addCompletion(voiceShortcut);
    }

    INInteraction *interaction = [[INInteraction alloc] initWithIntent:voiceShortcut.shortcut.intent response:nil];
    [interaction donateInteractionWithCompletion:^(NSError * _Nullable error) {
        NSLog(@"========%@", error);
    }];
}

- (void)addVoiceShortcutViewControllerDidCancel:(INUIAddVoiceShortcutViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (self.addCompletion) {
        self.addCompletion(nil);
    }
}

+ (UIViewController *)topMostViewController 
{
    return [self topMostViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController *)topMostViewController:(UIViewController *)lastViewController
{
    if ([lastViewController presentedViewController]) {
        return [self topMostViewController:[lastViewController presentedViewController]];
    }
    else if ([lastViewController isKindOfClass:[UITabBarController class]]) {
        return [self topMostViewController:[(UITabBarController *)lastViewController selectedViewController]];
    }
    else if ([lastViewController isKindOfClass:[UINavigationController class]]) {
        return [self topMostViewController:[(UINavigationController *)lastViewController visibleViewController]];
    }
    else if ([[lastViewController childViewControllers] count]) {
        return [self topMostViewController:[[lastViewController childViewControllers] lastObject]];
    }
    else {
        return lastViewController;
    }
}


@end
