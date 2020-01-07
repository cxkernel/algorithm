//
//  ViewController.m
//  SiriShortcut
//
//  Created by coolkernel on 2019/1/9.
//  Copyright © 2019 CoolKernel. All rights reserved.
//

#import "ViewController.h"
#import <Intents/Intents.h>
#import <IntentsUI/IntentsUI.h>
#import "CaptureSceneIntent.h"

@interface ViewController () <INUIAddVoiceShortcutButtonDelegate, INUIAddVoiceShortcutViewControllerDelegate, INUIEditVoiceShortcutViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    INUIAddVoiceShortcutButton *btn = [[INUIAddVoiceShortcutButton alloc] initWithStyle:INUIAddVoiceShortcutButtonStyleBlack];
    //    MHSceneAutoIntent *intent = [[MHSceneAutoIntent alloc] init];
    //    intent.sceneName = @"测试name";
    //    intent.shortcutType = MHSceneAutoShortcutTypeSiriShortcut;
    //    intent.intentID = [NSUUID UUID].UUIDString;
    //    INShortcut *shortcut = [[INShortcut alloc] initWithIntent:intent];

    CaptureSceneIntent *intent = [[CaptureSceneIntent alloc] init];
    intent.name = @"测试capture scene";
    INShortcut *shortcut = [[INShortcut alloc] initWithIntent:intent];

    btn.shortcut = shortcut;
    btn.delegate = self;

    [self.view addSubview:btn];
    [btn setFrame:CGRectMake(0, 0, 200, 60)];
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

- (void)addVoiceShortcutViewControllerDidCancel:(INUIAddVoiceShortcutViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)editVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)controller didUpdateVoiceShortcut:(nullable INVoiceShortcut *)voiceShortcut error:(nullable NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)editVoiceShortcutViewController:(INUIEditVoiceShortcutViewController *)controller didDeleteVoiceShortcutWithIdentifier:(NSUUID *)deletedVoiceShortcutIdentifier
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)editVoiceShortcutViewControllerDidCancel:(INUIEditVoiceShortcutViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];

}


@end
