//
//  BridgeManger.h
//  KingNetSDK
//
//  Created by admin on 2020/12/3.
//  Copyright © 2020 niujf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BridgeManger : NSObject

///xxxtea
+ (NSString *)encryptStringToBase64String:(NSString *)data stringKey:(NSString *)key;

///urlEncode
+ (NSString *)encode: (NSString *)encodeStr;

///获取签名
+ (NSString *)getSignWithDict: (NSDictionary *)dict;

///请求参数加密
+ (NSString *)encryptWithAES: (NSString *)str;

///获取dana的属性
+ (NSString *)getPara: (NSString *)orderId;

///获取dana的idfa
+ (NSString *)getIdfa;

+ (long)calculate;

@end

NS_ASSUME_NONNULL_END
