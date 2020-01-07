//
//  ViewController.m
//  VocationInteraction
//
//  Created by coolkernel on 2018/11/14.
//  Copyright © 2018 CoolKernel. All rights reserved.
//

#import "ViewController.h"
#import "MHSiriShortcutController.h"

@interface ViewController () <INUIAddVoiceShortcutButtonDelegate, INUIAddVoiceShortcutViewControllerDelegate, INUIEditVoiceShortcutViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    MHSceneShortcut *scene = [MHSceneShortcut new];
    scene.sceneName = @"测试vocation shortcut";

    MHSceneAutoIntent *intent = [[MHSceneAutoIntent alloc] init];
    intent.sceneName = scene.sceneName;
    INShortcut *shortcut = [[INShortcut alloc] initWithIntent:intent];

    INUIAddVoiceShortcutButton *btn = [[INUIAddVoiceShortcutButton alloc] initWithStyle:INUIAddVoiceShortcutButtonStyleWhiteOutline];
    btn.delegate = self;
    btn.shortcut = shortcut;
    [self.view addSubview:btn];
    btn.frame = CGRectMake(0, 0, 200, 50);
    btn.center = self.view.center;
}

- (void)presentAddVoiceShortcutViewController:(INUIAddVoiceShortcutViewController *)addVoiceShortcutViewController forAddVoiceShortcutButton:(INUIAddVoiceShortcutButton *)addVoiceShortcutButton
{
    addVoiceShortcutViewController.delegate = self;
    [self presentViewController:addVoiceShortcutViewController animated:YES completion:nil];
}
- (void)presentEditVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)editVoiceShortcutViewController forAddVoiceShortcutButton:(INUIAddVoiceShortcutButton *)addVoiceShortcutButton
{
    editVoiceShortcutViewController.delegate = self;
    [self presentViewController:editVoiceShortcutViewController animated:YES completion:nil];
}


- (void)addVoiceShortcutViewController:(INUIAddVoiceShortcutViewController *)controller didFinishWithVoiceShortcut:(nullable INVoiceShortcut *)voiceShortcut error:(nullable NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)addVoiceShortcutViewControllerDidCancel:(INUIAddVoiceShortcutViewController *)controller;
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}


- (void)editVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)controller didUpdateVoiceShortcut:(nullable INVoiceShortcut *)voiceShortcut error:(nullable NSError *)error;
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}
- (void)editVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)controller didDeleteVoiceShortcutWithIdentifier:(NSUUID *)deletedVoiceShortcutIdentifier;
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}
- (void)editVoiceShortcutViewControllerDidCancel:(INUIEditVoiceShortcutViewController *)controller;
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}


@end
