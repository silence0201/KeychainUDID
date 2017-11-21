//
//  KeychainUDID.h
//  Demo
//
//  Created by Silence on 2017/11/21.
//  Copyright © 2017年 Silence. All rights reserved.
//  使用IDFA+Keychain模拟UDID的相关功能,如果没有开启IDFA用UUID代替

#import <Foundation/Foundation.h>

#ifndef UDID_KEY

#define UDID_KEY   @"com.silence.udid"    // 可以重新定义实现自定义保存的Key

#endif

@interface KeychainUDID : NSObject

///  获取UDID
+ (NSString *)UDID ;

/// 删除保存的UDID
+ (void)deleteUDID;

@end
