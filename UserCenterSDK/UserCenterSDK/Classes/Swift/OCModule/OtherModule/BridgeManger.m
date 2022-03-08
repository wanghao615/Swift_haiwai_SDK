//
//  BridgeManger.m
//  KingNetSDK
//
//  Created by admin on 2020/12/3.
//  Copyright © 2020 niujf. All rights reserved.
//

#import "BridgeManger.h"
#import "XXTEA.h"
#import "KN_ObjTool.h"
#import "NSString+KN_String.h"
#import "NSString+AES.h"
#import <mach-o/dyld.h>
///oc调用swift
#import <UserCenterSDK/UserCenterSDK-Swift.h>

@implementation BridgeManger

+ (NSString *)encryptStringToBase64String:(NSString *)data stringKey:(NSString *)key{
    return  [XXTEA encryptStringToBase64String:data stringKey:key];
}

+ (NSString *)encode: (NSString *)encodeStr{
    return encodeStr.stringByURLEncode;
}

+ (NSString *)getSignWithDict: (NSDictionary *)dict {
    NSMutableString *pairs = [NSMutableString string];
    NSArray *unsetArray = @[@"action",@"sign",@"key",@"paid",@"action",@"resource_id",@"extra_currency",@"cash_type",@"callback_url",@"jump_url",@"app_name",@"app_name",@"app_user_name",@"product_name",@"user_ip"];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dict];
    [params removeObjectsForKeys:unsetArray];
    NSArray *values = [[params allValues]sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    for (NSString *value in values) {
        [pairs appendString:[NSString stringWithFormat:@"%@",value]];
    }
    NSString *sign = [KN_ObjTool knMD5:[NSString stringWithFormat:@"%@%@",@"582df15de91b3f12d8e710073e43f4f8",pairs]];
    return sign;
}

+ (NSString *)encryptWithAES: (NSString *)str {
    return str.aci_encryptWithAES;
}

+ (NSString *)getPara: (NSString *)orderId  {
    NSString *basicProperty = [KN_ObjTool getDanaBasicPorpertys];
    NSString *afSever = [NSString stringWithFormat:@"type=2&idfa=%@&itemid=%@&%@",[KN_ObjTool getEquipUUID],orderId,basicProperty];
    afSever =  [afSever stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"].invertedSet];
    return afSever;
}

+ (NSString *)getIdfa {
    return [KN_ObjTool getEquipUUID];
}

//MARK: - 获取偏移量地址
+ (long)calculate {
    long slide = 0;
    for (uint32_t i = 0; i < _dyld_image_count(); i++) {
        if (_dyld_get_image_header(i)->filetype == MH_EXECUTE) {
            slide = _dyld_get_image_vmaddr_slide(i);
            break;
        }
    }
    return slide;
}

@end
