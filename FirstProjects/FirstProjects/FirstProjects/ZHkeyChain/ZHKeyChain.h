//
//  ZHKeyChain.h
//  FirstProjects
//
//  Created by 海神 on 2017/8/28.
//  Copyright © 2017年 海神. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <CommonCrypto/CommonCrypto.h>
#import <Security/Security.h>

@interface ZHKeyChain : NSObject
/**
 需要存储一个钥匙串
 
 @param KeyChain 直接输入要是串
 */
+ (void)SaveKeyChain:(NSString * __nonnull)KeyChain;


/**
 获取钥匙串
 
 @return 返回一个字符串类型的要是串
 */
+ (nullable NSString *)ReadKeyChain;


/**
 修改一个钥匙串
 */
+ (void)ModifyKeyChain:(NSString * __nonnull)KeyChain;

/**
 删除钥匙串
 */
+ (void)DeleteKeyChain;


/*------------------------存储多个钥匙串时使用--------------------------------*/


/**
 存储一个带有标识的钥匙串
 
 @param key 标识
 @param KeyChain 钥匙串
 */
+ (void)SaveKey:(NSString * __nonnull)key KeyChain:(NSString * __nonnull)KeyChain;


/**
 根据标识获取一个要是串
 
 @param Key 标识
 @return 返回钥匙串
 */
+ (nullable NSString *)ReadOneOfTheKey:(NSString * __nonnull)Key;

/**
 修改一个钥匙串
 */
+ (void)ModifyOneOfTheKey:(NSString * __nonnull)Key KeyChain:(NSString * __nonnull)KeyChain;

/**
 移除指定钥匙串
 
 @param Key 指定钥匙串的标识
 */
+ (void)DeleteOneOfTheKey:(NSString * __nonnull)Key;


/**
 移除所有钥匙串
 */
+ (void)DeleteAllKeyChain;

@end
