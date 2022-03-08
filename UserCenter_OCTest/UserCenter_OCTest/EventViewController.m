//
//  EventViewController.m
//  UserCenter_OCTest
//
//  Created by admin on 2021/2/22.
//  Copyright © 2021 os. All rights reserved.
//

#import "EventViewController.h"
@import UserCenterSDK;

@interface EventViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) NSArray *eventArr;

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = ({
        UITableView *tb = [[UITableView alloc] init];
        tb.frame = self.view.bounds;
        tb.dataSource = self;
        tb.delegate = self;
        [self.view addSubview:tb];
        tb;
    });
    self.backBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(450, 250, 100, 50);
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor lightGrayColor]];
        [btn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn;
    });
}

- (void)backBtnClicked{
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.eventArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString *ID = @"OCEventCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.eventArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.eventArr[indexPath.row] isEqual:@"闪退"]){
        NSArray *arr = @[@"1"];
        NSLog(@"%@",arr[2]);
    }else {
        [[UserCenterSDK share] uniteWithEvent:self.eventArr[indexPath.row] roleName:@"test" roleId:@"1" serverId:@"1" isOnce: NO];
    }
    
}

- (NSArray *)eventArr {
    if (!_eventArr) {
        _eventArr = @[@"hotstart", @"hotend", @"complete_pay_bind", @"VIP5", @"season_card_purchase", @"big_month_card_purchase", @"pay_1200", @"闪退"];
    }
    return _eventArr;
}

@end
