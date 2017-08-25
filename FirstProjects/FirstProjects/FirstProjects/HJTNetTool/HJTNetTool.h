//
//  HJTNetTool.h
//  HJTMVVM
//
//  Created by Heige on 16/6/16.
//  Copyright © 2016年 Heige. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "APIdefine.h"
NS_ASSUME_NONNULL_BEGIN
@interface HJTNetTool : NSObject
typedef void(^successBlock)(id _Nullable responseObject);
typedef void(^failureBlock)(NSError * _Nonnull error);
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

+ (NSDictionary *)transformation:(id)responseObject;

+ (void)get:(nonnull NSString *)urlString progress:(nullable void(^)(NSProgress * _Nonnull progress))progressBlock success:(nullable void(^)(id _Nonnull responseObject))successBlock failure:(nullable void(^)(NSString  * _Nonnull errorLD))failureBlokc ;
+ (void)gettwo:(nonnull NSString *)urlString progress:(nullable void(^)(NSProgress * _Nonnull progress))progressBlock success:(nullable void(^)(id _Nonnull responseObject))successBlock failure:(nullable void(^)(NSString  * _Nonnull errorLD))failureBlokc;
+ (void)post:(nonnull NSString *)urlString parameters:(nullable NSDictionary<NSString *,id> *)parameters progress:(nullable void(^)(NSProgress * _Nullable progress))progressBlock success:(void(^)(id _Nullable responseObject))successBlock failure:(void(^)(NSString  * _Nonnull errorLD))failureBlokc;
+(void)uploadImgWithUrlString:(NSString *)urlString parameters:(NSDictionary<NSString *,id> *)parameters image:(nonnull UIImage*)image progress:(void (^)(NSProgress * _Nullable progress))progressBlock success:(successBlock)successBlock failure:(failureBlock)failureBlock;
+(void)uploadImgWithUrlStringtwo:(NSString *)urlString parameters:(NSDictionary<NSString *,id> *)parameters image:(nonnull UIImage*)image progress:(void (^)(NSProgress * _Nullable progress))progressBlock success:(successBlock)successBlock failure:(failureBlock)failureBlock;
+(void)uploadImgWithUrlStringthree:(NSString *)urlString parameters:(NSDictionary<NSString *,id> *)parameters image:(nonnull UIImage*)image progress:(void (^)(NSProgress * _Nullable progress))progressBlock success:(successBlock)successBlock failure:(failureBlock)failureBlock;

@end
NS_ASSUME_NONNULL_END
