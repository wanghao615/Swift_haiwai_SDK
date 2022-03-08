//
//  GameViewController.m
//  UserCenter_OCTest
//
//  Created by admin on 2021/2/22.
//  Copyright © 2021 os. All rights reserved.
//

#import "GameViewController.h"
#import "IAPViewController.h"
#import "EventViewController.h"

@import UserCenterSDK;

@interface GameViewController ()

@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *loginOutBtn;
@property (nonatomic, strong) UIButton *payBtn;
@property (nonatomic, strong) UIButton *eventBtn;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    [[UserCenterSDK share] setLoginSuccessCallback:^(NSString * _Nonnull userName, NSString * _Nonnull userId, NSString * _Nonnull access_token) {
        NSLog(@"userName: %@\n userId: %@\n access_token: %@", userName, userId, access_token);
    }];
    
    [[UserCenterSDK share] setLogoutSuccessCallback:^{
        NSLog(@"退出账号成功");
    }];
    
    self.loginBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 300, 100, 50, 30);
        [btn setTitle:@"登录" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        [btn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    self.loginOutBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 300, 320, 100, 30);
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        [btn addTarget:self action:@selector(loginOutBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
    self.payBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 300, 180, 50, 30);
        [btn setTitle:@"支付" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        [btn addTarget:self action:@selector(payBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
        });
    self.eventBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 300, 260, 50, 30);
        [btn setTitle:@"事件" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        [btn addTarget:self action:@selector(eventBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
}

- (void)loginBtnClicked {
    [[UserCenterSDK share] accountAutoLogin];
}

- (void)loginOutBtnClicked {
    [[UserCenterSDK share]accountLogout];
}

- (void)payBtnClicked {
    [self presentViewController:[[IAPViewController alloc] init] animated:NO completion:nil];
}

- (void)eventBtnClicked {
    [self presentViewController:[[EventViewController alloc] init] animated:NO completion:nil];
}

@end
