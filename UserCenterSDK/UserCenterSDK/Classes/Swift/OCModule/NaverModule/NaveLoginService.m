//
//  NJFNaverConfigurator.m
//  KingNetSDK
//
//  Created by admin on 2020/3/17.
//  Copyright © 2020 niujf. All rights reserved.
//

#import "NaveLoginService.h"

@interface NaveLoginService()

@property (nonatomic, strong) UIViewController *targetVC;
@property (nonatomic, copy) void (^callbackParams)(NSDictionary<NSString *,NSString *> *dict);

@end

@implementation NaveLoginService

- (void)configWithDict: (NSDictionary *)dict {
    //naver
    NaverThirdPartyLoginConnection *thirdConn = [NaverThirdPartyLoginConnection getSharedInstance];
    [thirdConn setConsumerKey:dict[@"consumerKey"] ?: @""];
    [thirdConn setConsumerSecret:dict[@"consumerSecret"] ?: @""];
    [thirdConn setAppName:dict[@"appName"] ?: @""];
    [thirdConn setServiceUrlScheme:dict[@"urlScheme"] ?: @""];
    [thirdConn setIsInAppOauthEnable:YES];
}


- (void)loginWithParams:(id _Nullable)params callbackParams:(void(^_Nullable)(NSDictionary<NSString *,NSString *> * _Nonnull dict))callbackParams{
    self.callbackParams = callbackParams;
    if ([params isKindOfClass:[UIViewController class]]) {
        self.targetVC = params;
    }
    [[NaverThirdPartyLoginConnection getSharedInstance] resetToken];
    [NaverThirdPartyLoginConnection getSharedInstance].delegate = self;
    [[NaverThirdPartyLoginConnection getSharedInstance] requestThirdPartyLogin];
}

- (BOOL)application:(UIApplication *_Nullable)application
            openURL:(NSURL *_Nonnull)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *_Nullable)options{
    if ([[url scheme] isEqualToString:kServiceAppUrlScheme]) {
           if ([[url host] isEqualToString:kCheckResultPage]) {
               // 네이버앱으로부터 전달받은 url값을 NaverThirdPartyLoginConnection의 인스턴스에 전달
               NaverThirdPartyLoginConnection *thirdConnection = [NaverThirdPartyLoginConnection getSharedInstance];
               THIRDPARTYLOGIN_RECEIVE_TYPE resultType = [thirdConnection receiveAccessToken:url];
               if (SUCCESS == resultType) {
                   NSLog(@"Getting auth code from NaverApp success!");
               } else {
                   // 앱에서 resultType에 따라 실패 처리한다.
               }
           }
           return YES;
       }
       return NO;
}

- (void)oauth20ConnectionDidOpenInAppBrowserForOAuth:(NSURLRequest *)request {
    [self presentWebviewControllerWithRequest:request];
}

- (void)oauth20Connection:(NaverThirdPartyLoginConnection *)oauthConnection didFailWithError:(NSError *)error {
    NSLog(@"%s=[%@]", __FUNCTION__, error);
}

- (void) presentWebviewControllerWithRequest:(NSURLRequest *)urlRequest   {
    // FormSheet모달위에 FullScreen모달이 뜰 떄 애니메이션이 이상하게 동작하여 애니메이션이 없도록 함
    NLoginThirdPartyOAuth20InAppBrowserViewController *inAppBrowserViewController = [[NLoginThirdPartyOAuth20InAppBrowserViewController alloc] initWithRequest:urlRequest];
    inAppBrowserViewController.parentOrientation = (UIInterfaceOrientation)[[UIDevice currentDevice] orientation];
    [self.targetVC presentViewController:inAppBrowserViewController animated:NO completion:nil];
}

- (void)oauth20ConnectionDidFinishRequestACTokenWithAuthCode {
    NSLog(@"%@",[NSString stringWithFormat:@"OAuth Success!\n\nAccess Token - %@\n\nAccess Token Expire Date- %@\n\nRefresh Token - %@", [NaverThirdPartyLoginConnection getSharedInstance].accessToken, [NaverThirdPartyLoginConnection getSharedInstance].accessTokenExpireDate, [NaverThirdPartyLoginConnection getSharedInstance].refreshToken]);
    if ([NaverThirdPartyLoginConnection getSharedInstance].accessToken) {//开始登录
        NSDictionary *dict = @{@"accessToken":[NaverThirdPartyLoginConnection getSharedInstance].accessToken};
        if (self.callbackParams) {
            self.callbackParams(dict);
        }
    }
}

- (void)oauth20ConnectionDidFinishRequestACTokenWithRefreshToken {
    NSLog(@"%@",[NSString stringWithFormat:@"Refresh Success!\n\nAccess Token - %@\n\nAccess sToken ExpireDate- %@", [NaverThirdPartyLoginConnection getSharedInstance].accessToken, [NaverThirdPartyLoginConnection getSharedInstance].accessTokenExpireDate]);
    if ([NaverThirdPartyLoginConnection getSharedInstance].accessToken) {
        NSDictionary *dict = @{@"accessToken":[NaverThirdPartyLoginConnection getSharedInstance].accessToken};
        if (self.callbackParams) {
            self.callbackParams(dict);
        }
    }
}

- (void)oauth20ConnectionDidFinishDeleteToken {
    NSLog(@"%@",[NSString stringWithFormat:@"로그아웃 완료"]);
}
@end
