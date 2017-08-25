//
//  DesUtil.h
//  Flights
//
//  Created by mac on 13-3-23.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesUtil : NSObject

+(NSString *)jDesString:(NSString *)string;
/**
 DES加密
 */
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;

/**
 DES解密
 */
+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key;

/**
 des转译
 */
+(NSString *)addDesString:(NSString *)string;


@end
