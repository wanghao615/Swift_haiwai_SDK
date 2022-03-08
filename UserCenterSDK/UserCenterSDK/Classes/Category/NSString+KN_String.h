//
//  NSString+KN_String.h
//  KingNetSDK
//
//  Created by niujf on 2019/3/14.
//  Copyright © 2019年 niujf. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSString (KN_String)

/**
 URL encode a string in utf-8.
 @return the encoded string.
 */
- (NSString *)stringByURLEncode;

- (NSArray *)componentsSeparatedByString:(NSString *)separator limit:(NSUInteger)limit;

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;


@end

NS_ASSUME_NONNULL_END
