//
//  EventTypeTool.h
//  KingNetSDK
//
//  Created by niujf on 2019/3/13.
//  Copyright © 2019年 niujf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, EventType) {
    EventTypeActivation,
    EventTypeDupgrade,
    EventTypeClick_login,
    EventTypeClick_register,
    EventTypeUpAccount,
    EventTypeStartpay,
    EventTypeCancelpay,
    EventTypeEcommerce_purchase,
    EventTypeFirstPay,
    EventTypePayFail
};

@interface StatisticalAnalysisTool : NSObject

+ (void)EventTypeWithType:(EventType)type
                             dict:(NSDictionary *)dict;

+ (void)EventTypeWithEvent:(NSString *)event
                             dict:(NSDictionary *)dict;

+ (void)Dana_LoginID:(NSString *)loginID;

+ (void)Dana_RegisterPublicPra:(NSDictionary *)pra;

+ (void)SWConfiguration;

@end

