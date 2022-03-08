//
//  KN_ObjTool.m
//  KingNetSDK
//
//  Created by niujf on 2019/3/4.
//  Copyright © 2019年 niujf. All rights reserved.
//

#import "KN_ObjTool.h"
#import "sys/utsname.h"
#import <DanaAnalytic/DanaAnalytic.h>
#import <CommonCrypto/CommonCrypto.h>
#import "PublicDefine.h"

@implementation KN_ObjTool

+ (NSString *)getEquipUUID {
    NSString *equipUUID = [[DanaAnalyticsSDK sharedInstance] getDanaDid];
    return equipUUID ?: @"";
}

+ (NSString *)base64DecodeString:(NSString *)string{
    NSData *data=[[NSData alloc]initWithBase64EncodedString:string options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)deviceType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *hardware = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([hardware isEqualToString:@"iPhone1,1"])    return @"iPhone 2G";
    if ([hardware isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([hardware isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([hardware isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([hardware isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([hardware isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([hardware isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([hardware isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([hardware isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([hardware isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([hardware isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([hardware isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([hardware isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([hardware isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([hardware isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([hardware isEqualToString:@"iPhone8,3"])    return @"iPhone SE";
    if ([hardware isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([hardware isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([hardware isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([hardware isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([hardware isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([hardware isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([hardware isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([hardware isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([hardware isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([hardware isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([hardware isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([hardware isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([hardware isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([hardware isEqualToString:@"iPhone11,4"])   return @"iPhone X Max";
    if ([hardware isEqualToString:@"iPhone11,6"])   return @"iPhone X Max";
    if ([hardware isEqualToString:@"iPod1,1"])      return @"iPod Touch (1 Gen)";
    if ([hardware isEqualToString:@"iPod2,1"])      return @"iPod Touch (2 Gen)";
    if ([hardware isEqualToString:@"iPod3,1"])      return @"iPod Touch (3 Gen)";
    if ([hardware isEqualToString:@"iPod4,1"])      return @"iPod Touch (4 Gen)";
    if ([hardware isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([hardware isEqualToString:@"iPod7,1"])      return @"iPod Touch (6 Gen)";
    if ([hardware isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([hardware isEqualToString:@"iPad1,2"])      return @"iPad";
    if ([hardware isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([hardware isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([hardware isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([hardware isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([hardware isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([hardware isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([hardware isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([hardware isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([hardware isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([hardware isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([hardware isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([hardware isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([hardware isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([hardware isEqualToString:@"iPad4,2"])      return @"iPad Air (WiFi/Cellular)";
    if ([hardware isEqualToString:@"iPad4,3"])      return @"iPad Air (China)";
    if ([hardware isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([hardware isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (WiFi/Cellular)";
    if ([hardware isEqualToString:@"iPad4,6"])      return @"iPad Mini Retina (China)";
    if ([hardware isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([hardware isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (WiFi/Cellular)";
    if ([hardware isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([hardware isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (WiFi/Cellular)";
    if ([hardware isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([hardware isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (WiFi/Cellular)";
    if ([hardware isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7-inch (WiFi)";
    if ([hardware isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7-inch (WiFi/Cellular)";
    if ([hardware isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9-inch (WiFi)";
    if ([hardware isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9-inch (WiFi/Cellular)";
    if ([hardware isEqualToString:@"iPad6,11"])     return @"iPad 5 (WiFi)";
    if ([hardware isEqualToString:@"iPad6,12"])     return @"iPad 5 (WiFi/Cellular)";
    if ([hardware isEqualToString:@"iPad7,1"])      return @"iPad Pro 12.9-inch 2nd-gen (WiFi)";
    if ([hardware isEqualToString:@"iPad7,2"])      return @"iPad Pro 12.9-inch 2nd-gen (WiFi/Cellular)";
    if ([hardware isEqualToString:@"iPad7,3"])      return @"iPad Pro 10.5-inch (WiFi)";
    if ([hardware isEqualToString:@"iPad7,4"])      return @"iPad Pro 10.5-inch (WiFi/Cellular)";
    if ([hardware isEqualToString:@"i386"])         return @"Simulator";
    if ([hardware isEqualToString:@"x86_64"])       return @"Simulator";
    //NSLog(@"Your device hardware string is: %@", hardware);
    if ([hardware hasPrefix:@"iPhone"]) return @"iPhone";
    if ([hardware hasPrefix:@"iPod"]) return @"iPod";
    if ([hardware hasPrefix:@"iPad"]) return @"iPad";
    return nil;
}

/// 获取dnan的Porpertys
+ (NSString *)getDanaBasicPorpertys{
    NSDictionary *danaDict = [[DanaAnalyticsSDK sharedInstance] currentSuperProperties];
    NSString *basicStr = [NSString stringWithFormat:@"channel=appstore&_mfr=%@&_os=iOS&platform=iOS&_sdk=iOS&_appver=%@&terminal=%@&_wifi=%@&_res=%@&_osver=%@&_sdkserver=%@&bundle_name=%@&bundle_id=%@",[self deviceType],AppVersion,@"iOS", @"1",danaDict[@"_res"]?:@"",danaDict[@"_osver"]?:@"",danaDict[@"_sdkver"]?:@"",APPName,BundleId];
    return basicStr;
}

///获取ae的key
+ (NSString *)getAeKey {
    NSString *iapKey = @"ZGV5dWxpdTMwMzMyOTU5NQ==";
    return [self base64DecodeString:iapKey];
}

+ (NSString *)knMD5:(NSString *)str {
     unsigned char result[CC_MD5_DIGEST_LENGTH];
     NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
     CC_MD5(data.bytes, (CC_LONG)data.length, result);
     return [NSString stringWithFormat:
             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ];
}


@end
