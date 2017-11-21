//
//  KeychainUDID.m
//  Demo
//
//  Created by Silence on 2017/11/21.
//  Copyright © 2017年 Silence. All rights reserved.
//

#import "KeychainUDID.h"
#import <Security/Security.h>
#import <AdSupport/AdSupport.h>

// 私有Keychain管理类
@interface KeychainManager: NSObject
@end

@implementation KeychainManager

+ (NSMutableDictionary *)keychainQuery
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)(kSecClassGenericPassword),kSecClass,
            UDID_KEY, kSecAttrService,
            UDID_KEY, kSecAttrAccount,
            kSecAttrAccessibleAfterFirstUnlock,kSecAttrAccessible,nil];
}

+ (void)save:(id)data {
    NSMutableDictionary *keychainQuery = [self keychainQuery];
    SecItemDelete((__bridge CFDictionaryRef)(keychainQuery));
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data]
                      forKey:(__bridge id<NSCopying>)(kSecValueData)];
    SecItemAdd((__bridge CFDictionaryRef)(keychainQuery), NULL);
}

+ (id)loads {
    id re ;
    NSMutableDictionary *keychainQuery = [self keychainQuery];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id<NSCopying>)(kSecReturnData)];
    [keychainQuery setObject:(__bridge id)(kSecMatchLimitOne) forKey:(__bridge id<NSCopying>)(kSecMatchLimit)];
    
    CFTypeRef result = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, &result) == noErr){
        re = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData*)result];
    }
    
    return re;
}

+ (void)delete {
    NSMutableDictionary *keychainQuery = [self keychainQuery];
    SecItemDelete((__bridge CFDictionaryRef)(keychainQuery));
}

@end

@implementation KeychainUDID

+ (NSString *)UDID {
    // 首先读取 keychain已存在的UDID
    NSString *UDID = [self keychainUDID];
    if (UDID && UDID.length > 0) {
        return UDID;
    }
    
    // 第一个获取UUID,充当UDID
    UDID = [self UUID];
    if(UDID && UDID.length > 0) {
        [KeychainManager save:UDID];
        return UDID;
    }
    
    // 获取IDFA充当UDID
    if([ASIdentifierManager sharedManager].advertisingTrackingEnabled){
        UDID = [[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] lowercaseString];
        [KeychainManager save:UDID];
        return UDID;
    }
    
    return nil;
}

+ (void)deleteUDID {
    [KeychainManager delete];
}

#pragma mark -- Private

+ (NSString *)keychainUDID {
    NSString *keychainUDID = [KeychainManager loads];
    return keychainUDID;
}

+ (NSString *)UUID {
    CFUUIDRef uuid_ref = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef uuid_string_ref= CFUUIDCreateString(kCFAllocatorDefault, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return [uuid lowercaseString];
}

@end
