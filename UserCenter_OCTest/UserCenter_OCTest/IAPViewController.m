//
//  IAPViewController.m
//  UserCenter_OCTest
//
//  Created by admin on 2021/2/22.
//  Copyright © 2021 os. All rights reserved.
//

#import "IAPViewController.h"

@import UserCenterSDK;

@interface IAPViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) NSArray *iapArr;
@property (nonatomic, strong) NSDictionary *priceDict;

@end

@implementation IAPViewController

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
    return self.iapArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString *ID = @"OCIAPCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.iapArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self pay:self.iapArr[indexPath.row] price:self.priceDict[self.iapArr[indexPath.row]]];
}

- (void)pay:(NSString *)productId price:(NSString *)price {
    //__weak typeof(self) weakSelf = self;
    NSDictionary *dict = @{
        @"orderId": [NSString stringWithFormat:@"YYZZ%d",(int)[[NSDate date]timeIntervalSince1970]],
        @"userId": @"13229328200372159",
        @"userName": @"허깨비벤드이",
        @"serverId": @"1",
        @"serverName": @"",
        @"productId": productId,
        @"productName": @"45 다이아 선물",
        @"price": price,
        @"app_extra1": @"1|471012|E8DD5418-0265-4D4F-8195-072281A1ABA7|iPhone8,2",
        @"app_extra2": @"0|CN_1.0.1_10010_201907191604_12.3.1_8_sc_ko",
        @"callback_url": @"http://myip.ipip.net"
    };
    
    [[UserCenterSDK share] IAPStatusWithDict: dict statusCallback:^(NSString *iapStatus) {
        if ([iapStatus isEqualToString:@"0"]) {//成功
            NSLog(@"内购完成");
        }else{//失败
            NSLog(@"内购失败");
        };
    }];
}

- (NSArray *)iapArr{
    if (!_iapArr) {
        NSMutableArray *dArr = [NSMutableArray array];
        NSArray *priceArr = @[@"6",@"30",@"68",@"98",@"128",@"198",@"328",@"648"];
        for (int i = 0; i < priceArr.count; i ++) {
            NSString *str = [NSString stringWithFormat:@"%@%@",@"com.overseasgm.testnum.",priceArr[i]];
            [dArr addObject:str];
        }
        _iapArr = [dArr copy];
    }
    return _iapArr;
}

- (NSDictionary *)priceDict{
    if (!_priceDict) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSArray *priceArr = @[@"6",@"30",@"68",@"98",@"128",@"198",@"328",@"648"];
        __weak typeof(self) weakSelf = self;
        [priceArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [dict setObject:obj forKey:weakSelf.iapArr[idx]];
        }];
        _priceDict = [dict copy];
    }
    return _priceDict;
}

@end
