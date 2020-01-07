//
//  MHSiriShortcutController.h
//  Pods
//
//  Created by coolkernel on 2018/11/7.
//

#import <Foundation/Foundation.h>
#import <Intents/Intents.h>
#import <IntentsUI/IntentsUI.h>
#import "MHSceneAutoIntent.h"

static inline void XMDispatchMain(void (^block)(void))
{
    if ([NSThread isMainThread]) {
        if (block) {
            block();
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

@interface MHSceneShortcut : NSObject
@property (nonatomic, copy) NSString *sceneId;
@property (nonatomic, copy) NSString *sceneName;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *serviceCode;
@property (nonatomic, strong) NSUUID *identifier;
@property (nonatomic, copy) NSString *invocationPhrase;


@end


NS_ASSUME_NONNULL_BEGIN

@class MHSceneShortcut, INVoiceShortcut;
API_AVAILABLE(ios(12.0))
NS_EXTENSION_UNAVAILABLE_IOS("Not available in app extensions.")
@interface MHSiriShortcutController : NSObject

- (void)addSceneAutoSiriShortcut:(MHSceneShortcut *)sceneShortcut
                      completion:(void (^)(INVoiceShortcut *))completion;

- (void)editSceneAutoSiriShortcut:(MHSceneShortcut *)sceneShortcut
                 updateCompletion:(void (^)(INVoiceShortcut *))updateCompletion
                 deleteCompeltion:(void (^)(NSUUID *))deleteCompeltion;

@end

NS_ASSUME_NONNULL_END
