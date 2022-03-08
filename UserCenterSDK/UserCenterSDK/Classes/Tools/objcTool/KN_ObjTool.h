//
//  KN_ObjTool.h
//  KingNetSDK
//
//  Created by niujf on 2019/3/4.
//  Copyright © 2019年 niujf. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface KN_ObjTool : NSObject

+ (NSString *)getEquipUUID;

/// 获取dnan的Porpertys
+ (NSString *)getDanaBasicPorpertys;

///获取ae的key
+ (NSString *)getAeKey;

+ (NSString *)knMD5:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
