//
//  SVProgressManger.h
//  KingNetSDK
//
//  Created by admin on 2020/12/3.
//  Copyright © 2020 niujf. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface SVProgressManger : NSObject

+ (void)configuration;

+ (void)show;

+ (void)showWithStatus: (NSString *)status;

+ (void)dismiss;

+ (void)showErrorWithStatus: (NSString *)status;

+ (void)showSuccessWithStatus: (NSString *)status;

@end

NS_ASSUME_NONNULL_END
