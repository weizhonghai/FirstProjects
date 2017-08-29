//
//  ZHKeyChain.m
//  FirstProjects
//
//  Created by 海神 on 2017/8/28.
//  Copyright © 2017年 海神. All rights reserved.
//

#import "ZHKeyChain.h"
#ifdef DEBUG

NSString *const State = @"Debug";

#else

NSString *const State = @"Release";

#endif



enum ZHKeyChainState {
    ZHKeyChainAdd = 0,//增加
    ZHKeyChainDelete,//删除
    ZHKeyChainModify,//修改
    ZHKeyChainFind//查找
};
typedef enum ZHKeyChainState ZHKeyChainState;

NSString *const DeleteAllKeyChain = @"DeleteAllKeyChain";

@implementation ZHKeyChain


/**
 需要存储一个钥匙串
 
 @param KeyChain 直接输入要是串
 */
+ (void)SaveKeyChain:(NSString *)KeyChain{
    if ([self ExceptionHandling]) NSAssert(KeyChain.length != 0, @"存储的钥匙串不能为空");
    if (KeyChain.length == 0) return;
    [self CoreKeyChain:KeyChain Key:nil forState:ZHKeyChainAdd];
}

/**
 修改一个钥匙串
 */
+ (void)ModifyKeyChain:(NSString *)KeyChain{
    if ([self ExceptionHandling]) NSAssert(KeyChain.length != 0, @"修改的钥匙串不能为空");
    if (KeyChain.length == 0) return;
    [self CoreKeyChain:KeyChain Key:nil forState:ZHKeyChainModify];
}

/**
 获取钥匙串
 
 @return 返回一个字符串类型的要是串
 */
+ (NSString *)ReadKeyChain{
    return [self CoreKeyChain:nil Key:nil forState:ZHKeyChainFind];
}


/**
 删除钥匙串
 */
+ (void)DeleteKeyChain{
    [self CoreKeyChain:nil Key:nil forState:ZHKeyChainDelete];
}

/*------------------------存储多个钥匙串时使用--------------------------------*/


/**
 存储一个带有标识的钥匙串
 
 @param key 标识
 @param KeyChain 钥匙串
 */
+ (void)SaveKey:(NSString *)key KeyChain:(NSString *)KeyChain{
    if ([self ExceptionHandling]) NSAssert(KeyChain.length != 0 && key.length != 0, @"存储的钥匙串和标识不能为空");
    if (KeyChain.length == 0 && key.length == 0) return;
    [self CoreKeyChain:KeyChain Key:key forState:ZHKeyChainAdd];
}


/**
 修改一个钥匙串
 */
+ (void)ModifyOneOfTheKey:(NSString *)Key KeyChain:(NSString *)KeyChain{
    if ([self ExceptionHandling]) NSAssert(KeyChain.length != 0 && Key.length != 0, @"修改的钥匙串和标识不能为空");
    if (KeyChain.length == 0 && Key.length == 0) return;
    [self CoreKeyChain:KeyChain Key:Key forState:ZHKeyChainModify];
}

/**
 根据标识获取一个要是串
 
 @param Key 标识
 @return 返回钥匙串
 */
+ (NSString *)ReadOneOfTheKey:(NSString *)Key{
    if ([self ExceptionHandling]) NSAssert(Key.length != 0, @"指定获取钥匙串的标识不能为空");
    if (Key.length == 0) return nil;
    return [self CoreKeyChain:nil Key:Key forState:ZHKeyChainFind];
}


/**
 移除指定钥匙串
 
 @param Key 指定钥匙串的标识
 */
+ (void)DeleteOneOfTheKey:(NSString *)Key{
    if ([self ExceptionHandling]) NSAssert(Key.length != 0, @"指定移除钥匙串的标识不能为空");
    if (Key.length == 0) return;
    [self CoreKeyChain:nil Key:Key forState:ZHKeyChainDelete];
}


/**
 移除所有钥匙串
 */
+ (void)DeleteAllKeyChain{
    [self CoreKeyChain:nil Key:DeleteAllKeyChain forState:ZHKeyChainDelete];
}

/*------------------------统一管理KeyChain--------------------------------*/


/**
 KeyChain核心方法
 
 @param KeyChain 钥匙串
 @param Key 标识
 @param keyState 状态（增删改查）
 @return 返回可能为空
 */
+ (nullable NSString *)CoreKeyChain:(NSString *)KeyChain Key:(NSString *)Key forState:(ZHKeyChainState)keyState{
    NSString *BundleIdentifier = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];//获取bundleid
    //创建添加所需字典
    NSMutableDictionary *DicRef = [NSMutableDictionary dictionaryWithDictionary:@{(id)kSecClass       :  (id)kSecClassGenericPassword,
                                                                                  (id)kSecAttrService    :  BundleIdentifier,
                                                                                  (id)kSecAttrAccount    :  BundleIdentifier,
                                                                                  (id)kSecAttrAccessible  :  (id)kSecAttrAccessibleAfterFirstUnlock}];
    //创建查看所需字典
    NSMutableDictionary *FindDic = [NSMutableDictionary dictionaryWithDictionary:DicRef];
    id ret = nil;
    [FindDic setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [FindDic setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    //读取原始数据
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)FindDic, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"错误");
        } @finally {
        }
    }
    if (keyData) CFRelease(keyData);
    //创建可更改的原始数据
    NSMutableDictionary *KeyChainDictionary = [NSMutableDictionary dictionaryWithDictionary:ret];
    NSString *MD5Key;//进行指定账号md5加密，防止直接窃取用户会员信息
    if (Key.length == 0) {
        MD5Key = BundleIdentifier;
    }else{
        MD5Key = [self MD5:Key];
    }
    
    if (keyState == ZHKeyChainAdd || keyState == ZHKeyChainModify) {//添加和修改
        SecItemDelete((CFDictionaryRef)DicRef);
        [KeyChainDictionary setObject:KeyChain forKey:MD5Key];
        [DicRef setObject:[NSKeyedArchiver archivedDataWithRootObject:KeyChainDictionary] forKey:(id)kSecValueData];
        SecItemAdd((CFDictionaryRef)DicRef, NULL);
    }else if (keyState == ZHKeyChainDelete) {//移除钥匙串
        if (Key.length == 0) {
            [KeyChainDictionary removeObjectForKey:BundleIdentifier];
            [DicRef setObject:[NSKeyedArchiver archivedDataWithRootObject:KeyChainDictionary] forKey:(id)kSecValueData];
            SecItemDelete((CFDictionaryRef)DicRef);
            SecItemAdd((CFDictionaryRef)DicRef,NULL);
        }else{
            if ([Key isEqualToString:DeleteAllKeyChain]) {
                SecItemDelete((CFDictionaryRef)DicRef);
            }else{
                [KeyChainDictionary removeObjectForKey:Key];
                [DicRef setObject:[NSKeyedArchiver archivedDataWithRootObject:KeyChainDictionary] forKey:(id)kSecValueData];
                SecItemAdd((CFDictionaryRef)DicRef,NULL);
            }
        }
    }else if (keyState == ZHKeyChainFind) {//需要返回 查看钥匙串
        
        return [KeyChainDictionary objectForKey:MD5Key];
    }
    return nil;
}


/**
 MD5加密算法
 
 @param String 传入需要加密的字符串
 @return 返回加密成功的字符串
 */
+ (id)MD5:(NSString *)String {
//    const char *cStr = [String UTF8String];
//    unsigned char digest[16];
//    unsigned int x=(int)strlen(cStr) ;
//    CC_MD5( cStr, x, digest );
//    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
//        [output appendFormat:@"%02x", digest[i]];
    return String;
}



+ (BOOL)ExceptionHandling{
    if ([State isEqualToString:@"Debug"]) {
        return YES;
    }else{
        return NO;
    }
    
}


@end
