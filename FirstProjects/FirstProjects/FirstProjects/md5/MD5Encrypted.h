//
//  MD5Encrypted.h
//  Flights
//
//  Created by duyg on 15/6/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicHead.h"
@interface MD5Encrypted : NSObject

+(NSString *) md5: (NSString *)inputString;
@end
