//
//  EventTypeTool.m
//  KingNetSDK
//
//  Created by niujf on 2019/3/13.
//  Copyright © 2019年 niujf. All rights reserved.
//

#import "StatisticalAnalysisTool.h"
#import <DanaAnalytic/DanaAnalytic.h>
#import "KN_ObjTool.h"
#import "Firebase.h"

///oc调用swift
#import <UserCenterSDK/UserCenterSDK-Swift.h>

@implementation StatisticalAnalysisTool

///基础SDK事件
+ (void)EventTypeWithType:(EventType)type
                               dict:(NSDictionary *)dict{
    //af和firebase的统一参数
    NSString *ouid = [SDKTool user_id]?:@"-1";
    [self Dana_LoginID: ouid];
    switch (type) {
        case EventTypeActivation:
            [[DanaAnalyticsSDK sharedInstance] Dana_Activation];
            //[[DanaAnalyticsSDK sharedInstance] track:@"activation" withProperties:nil withReduceBaseProperty:NO];
            [FIRAnalytics logEventWithName:@"activation" parameters:nil];
            break;
        case EventTypeDupgrade:
            [[DanaAnalyticsSDK sharedInstance] Dana_Dupgrade];
            //[[DanaAnalyticsSDK sharedInstance] track:@"dupgrade" withProperties:nil withReduceBaseProperty:NO];
            [FIRAnalytics logEventWithName:@"dupgrade" parameters:nil];
            break;
        case EventTypeClick_login:
            [[DanaAnalyticsSDK sharedInstance] track:@"click_login" withProperties:dict withReduceBaseProperty:NO];
            [FIRAnalytics logEventWithName:@"click_login" parameters:dict];
            break;
        case EventTypeClick_register:
            [[DanaAnalyticsSDK sharedInstance] track:@"click_register" withProperties:dict withReduceBaseProperty:NO];
            [FIRAnalytics logEventWithName:@"click_register" parameters:dict];
            break;
        case EventTypeUpAccount:
            [[DanaAnalyticsSDK sharedInstance] track:@"upaccount" withProperties:dict withReduceBaseProperty:NO];
            [FIRAnalytics logEventWithName:@"upaccount" parameters:dict];
            break;
        case EventTypeStartpay:
            [[DanaAnalyticsSDK sharedInstance] track:@"startpay" withProperties:dict withReduceBaseProperty:NO];
            [FIRAnalytics logEventWithName:@"startpay" parameters:dict];
            break;
        case EventTypeCancelpay:
            [[DanaAnalyticsSDK sharedInstance] track:@"cancelpay" withProperties:dict withReduceBaseProperty:NO];
            [FIRAnalytics logEventWithName:@"cancelpay" parameters:dict];
            break;
        case EventTypeEcommerce_purchase:
            [FIRAnalytics logEventWithName:@"ecommerce_purchase" parameters:dict];
            break;
        case EventTypeFirstPay:
            [[DanaAnalyticsSDK sharedInstance] track:@"firstpay" withProperties:dict withReduceBaseProperty:NO];
            [FIRAnalytics logEventWithName:@"firstpay" parameters:dict];
            break;
        case EventTypePayFail:
            [[DanaAnalyticsSDK sharedInstance] track:@"payfail" withProperties:dict withReduceBaseProperty:NO];
            [FIRAnalytics logEventWithName:@"payfail" parameters:dict];
            break;
        default:
            break;
    }
}

+ (void)SWConfiguration {
    //dana统计上报
    //初始化配置文件 DAConf.plist文件   需要事先在plist文件中配置好相关参数
    [DanaAnalyticsSDK sharedInstanceWithConf];
    //是否需要自动记录和传送打开app和退出app的事件 enterbackground  enterfrontground，最好在didFinishLaunchingWithOptions 里面调用，记录到更精确的启动app的事件启动到关闭的事件长度
    [[DanaAnalyticsSDK sharedInstance] enableAutoTrack];
    //是否输出日志的，默认不输出
    [DanaAnalyticsSDK sharedInstance].logSwitch = NO;
}

+ (void)EventTypeWithEvent:(NSString *)event
                                dict:(NSDictionary *)dict{
    [[DanaAnalyticsSDK sharedInstance] track:event withProperties:dict withReduceBaseProperty:NO];
    [FIRAnalytics logEventWithName:event parameters:dict];
}


+ (void)Dana_LoginID:(NSString *)loginID{
    if (loginID.length > 0) {
        [[DanaAnalyticsSDK sharedInstance] login:loginID];
    }
}

+ (void)Dana_RegisterPublicPra:(NSDictionary *)pra{
    [[DanaAnalyticsSDK sharedInstance] registerSuperProperties:pra];
}


@end


