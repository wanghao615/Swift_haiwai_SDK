//
//  AppDelegate.m
//  UserCenter_OCTest
//
//  Created by admin on 2021/2/7.
//  Copyright © 2021 os. All rights reserved.
//

#import "AppDelegate.h"
#import "GameViewController.h"
@import UserCenterSDK;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    [self.window makeKeyAndVisible];
    self.window.rootViewController  = [[GameViewController alloc] init];//游戏方生成的rootVC
    //初始化
    [[UserCenterSDK share] SDKInitWithApplication:application launchOptions:launchOptions];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [[UserCenterSDK share] callbackWithApplication: application url: url options: options];
}


@end
