//
//  SVProgressManger.m
//  KingNetSDK
//
//  Created by admin on 2020/12/3.
//  Copyright © 2020 niujf. All rights reserved.
//

#import "SVProgressManger.h"
#import "SVProgressHUD.h"

@implementation SVProgressManger

+ (void)configuration {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
}

+ (void)show {
    [SVProgressHUD show];
}

+ (void)showWithStatus: (NSString *)status {
    [SVProgressHUD showWithStatus:status];
}

+ (void)dismiss {
    [SVProgressHUD dismiss];
}

+ (void)showErrorWithStatus: (NSString *)status {
    [SVProgressHUD showErrorWithStatus:status];
}

+ (void)showSuccessWithStatus: (NSString *)status {
    [SVProgressHUD showSuccessWithStatus:status];
}

@end
