//
//  Statistics.h
//  KingNetSDK
//
//  Created by admin on 2020/12/10.
//  Copyright © 2020 niujf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Statistics : NSObject

+ (void)configuration;

+ (NSString *)getDataUUID;

+ (void)registerWithDict: (NSDictionary *)dict;

+ (void)activation;

+ (void)dupgrade;

+ (void)clickLoginWithDict: (NSDictionary *)dict;

+ (void)clickRegister;

+ (void)upAccount;

+ (void)startPayWithDict: (NSDictionary *)dict;

+ (void)cancelPayWithDict: (NSDictionary *)dict;

+ (void)ecommerce_purchaseWithDict: (NSDictionary *)dict;

+ (void)fistPayWithDict: (NSDictionary *)dict;

+ (void)payFailWithDict: (NSDictionary *)dict;

+ (void)unitEvent:(NSString *)event dict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
