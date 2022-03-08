//
//  PublicDefine.h
//  NJF_Project
//
//  Created by jinfeng niu on 2018/9/14.
//  Copyright © 2018年 jinfeng niu. All rights reserved.
//

#ifndef PublicDefine_h
#define PublicDefine_h

/************************应用相关*******************/
#define APPName             [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]
#define BundleId            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#define AppVersion          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/************************屏幕坐标、尺寸相关*******************/
// 屏幕高度
#define kScreenHeight           [[UIScreen mainScreen] bounds].size.height

/************************防止循环饮用*******************/

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

/************************log*******************/
#ifdef DEBUG
#define KN_Log(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define KN_Log(...)
#endif

//自定义打印
#define KNLog(format, ...) {\
if ([[UserInterface share] logEnable]) {\
NSLog(@"[KN]: %s():%d " format, __func__, __LINE__, ##__VA_ARGS__);\
}\
}\

/************************国际化*******************/

#define Localized(key)  [[NSBundle bundleWithPath:[[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"internationalization.bundle" ofType:nil]] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"appLanguage"]] ofType:@"lproj"]] localizedStringForKey:(key) value:nil table:@"InfoPlist"]

/***********************个性化需求*****************/

#define Bundle(imageName) [NSString stringWithFormat:@"%@/%@",@"SDKImageResource.bundle",imageName]

#endif /* PublicDefine_h */
