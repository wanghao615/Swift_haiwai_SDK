//
//  NJFNaverConfigurator.h
//  KingNetSDK
//
//  Created by admin on 2020/3/17.
//  Copyright © 2020 niujf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NaverThirdPartyLoginConnection.h"
#import "NLoginThirdPartyOAuth20InAppBrowserViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NaveLoginService : NSObject <NaverThirdPartyLoginConnectionDelegate>

- (void)configWithDict: (NSDictionary *)dict;
- (void)loginWithParams:(id _Nullable)params
         callbackParams:(void(^_Nullable)(NSDictionary<NSString *,NSString *> * _Nonnull dict))callbackParams;
- (BOOL)application:(UIApplication *_Nullable)application
            openURL:(NSURL *_Nonnull)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *_Nullable)options;

@end

NS_ASSUME_NONNULL_END
