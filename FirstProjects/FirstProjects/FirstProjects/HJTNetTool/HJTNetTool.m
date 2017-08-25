//
//  HJTNetTool.m
//  HJTMVVM
//
//  Created by Heige on 16/6/16.
//  Copyright © 2016年 Heige. All rights reserved.
//

#import "HJTNetTool.h"

@interface HJTNetTool ()

@end

@implementation HJTNetTool
- (void)dealloc
{
}

+ (UIView *)keepView{
    NSObject *objc = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([objc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = objc;
        UINavigationController *nav = tab.viewControllers[tab.selectedIndex];
        return tab.view;
    }else if ([objc isKindOfClass:[UINavigationController class]]) {
        return [(UINavigationController *)objc view];
    }
    return nil;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                    error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return str;
}

+ (NSDictionary *)transformation:(id)responseObject
{
    NSString *resultString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
#if DEBUG
    NSLog(@"**********************");
    NSLog(@"%@",resultString);
    NSLog(@"**********************");
#else
    
#endif
    
    NSData *jsonData = [resultString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    [self visitDict:dic];
    return dic;
}
#pragma mark 递归
+ (void)visitDict:(id)dict{
    if ([dict isKindOfClass:[NSMutableDictionary class]]) {
        NSArray *keys=[dict allKeys];
        for (NSString *key in keys) {
            if ([[dict objectForKey:key] isKindOfClass:[NSNull class]]) {
                dict[key] = @"";
            }else if([[dict objectForKey:key] isKindOfClass:[NSDictionary class]]) {
                NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:[dict objectForKey:key]];
                [self visitDict:dic1];
                dict[key] = dic1;
            }else if ([dict[key] isKindOfClass:[NSArray class]]) {
                NSMutableArray *arr = [NSMutableArray arrayWithArray:dict[key]];
                [self visitDict:arr];
                dict[key] = arr;
            }
        }
    }else if ([dict isKindOfClass:[NSMutableArray class]]) {
        for (int i = 0 ; i < ((NSMutableArray *)dict).count; i++) {
            if ([((NSMutableArray *)dict)[i] isKindOfClass:[NSNull class]]) {
                ((NSMutableArray *)dict)[i] = @"";
            }else if ([((NSMutableArray *)dict)[i] isKindOfClass:[NSArray class]]) {
                NSMutableArray *arr = [NSMutableArray arrayWithArray:((NSMutableArray *)dict)[i]];
                [self visitDict:arr];
                ((NSMutableArray *)dict)[i] = arr;
            }else if ([((NSMutableArray *)dict)[i] isKindOfClass:[NSDictionary class]]) {
                NSMutableDictionary *dic1 = [NSMutableDictionary dictionaryWithDictionary:((NSMutableArray *)dict)[i]];
                [self visitDict:dic1];
                dict[i] = dic1;
            }
        }
    }
}

+ (void)get:(nonnull NSString *)urlString progress:(nullable void(^)(NSProgress * _Nonnull progress))progressBlock success:(nullable void(^)(id _Nonnull responseObject))successBlock failure:(nullable void(^)(NSString  * _Nonnull errorLD))failureBlokc
{
    NSLog(@"%@",urlString);
    NSParameterAssert(urlString);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self keepView] animated:YES];
    // Set the label text.
    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    __weak typeof(self) weakSelf = self;
    [session GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [hud hideAnimated:YES];
        __strong typeof(self) strongSelf = weakSelf;
        successBlock([strongSelf transformation:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [hud hideAnimated:YES];
        failureBlokc(error.localizedDescription);
    }];
}

+ (void)gettwo:(nonnull NSString *)urlString progress:(nullable void(^)(NSProgress * _Nonnull progress))progressBlock success:(nullable void(^)(id _Nonnull responseObject))successBlock failure:(nullable void(^)(NSString  * _Nonnull errorLD))failureBlokc
{
    NSLog(@"%@",urlString);
    NSParameterAssert(urlString);
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[self keepView] animated:YES];
    // Set the label text.
//    hud.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    __weak typeof(self) weakSelf = self;
    [session GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [hud hide:YES];
        __strong typeof(self) strongSelf = weakSelf;
        successBlock([strongSelf transformation:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [hud hide:YES];
        failureBlokc(error.localizedDescription);
    }];
}


+ (void)post:(nonnull NSString *)urlString parameters:(nullable NSDictionary *)parameters progress:(nullable void(^)(NSProgress * _Nullable progress))progressBlock success:(void(^)(id _Nullable responseObject))successBlock failure:(void(^)(NSString  * _Nonnull errorLD))failureBlokc
{
    
    NSParameterAssert(urlString);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSString* mutableURLString = [NSString stringWithFormat:@"%@%@",NetworkServer,urlString];
    NSString* mutableURLString = urlString;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    __weak typeof(self) weakSelf = self;
    [session POST:mutableURLString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock([weakSelf transformation:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

#pragma mark upload Image
+(void)uploadImgWithUrlString:(NSString *)urlString parameters:(NSDictionary<NSString *,id> *)parameters image:(nonnull UIImage*)image progress:(void (^)(NSProgress * _Nullable progress))progressBlock success:(successBlock)successBlock failure:(failureBlock)failureBlock{
    NSParameterAssert(urlString);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    __weak typeof(self) weakSelf = self;
    [session POST:urlString parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 通过UUID生成一个全局唯一的文件名
        NSString *filename = [NSString stringWithFormat:@"%@.png", [NSUUID UUID].UUIDString];
        
        // 将UIImage对象转成NSData对象(二进制数据)
        NSData *data = UIImageJPEGRepresentation(image, 0.4);
        // 第一个参数: 上传的二进制数据
        // 第二个参数: 上传文件对应的参数名(通过查API手册获得)
        // 第三个参数: 上传文件的文件名(这个名字通常没用, 因为服务器通常会用自己的命名规则给上传的文件起名字来避免名字冲突)
        // 第四个参数: MIME类型(告知服务器上传的文件的类型)
        [formData appendPartWithFileData:data name:@"User_Avatar" fileName:filename mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strong typeof(self) strongSelf = weakSelf;
        successBlock([strongSelf transformation:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
#pragma mark upload Image
+(void)uploadImgWithUrlStringtwo:(NSString *)urlString parameters:(NSDictionary<NSString *,id> *)parameters image:(nonnull UIImage*)image progress:(void (^)(NSProgress * _Nullable progress))progressBlock success:(successBlock)successBlock failure:(failureBlock)failureBlock{
    NSParameterAssert(urlString);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    __weak typeof(self) weakSelf = self;
    [session POST:urlString parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 通过UUID生成一个全局唯一的文件名
        NSString *filename = [NSString stringWithFormat:@"%@.png", [NSUUID UUID].UUIDString];
        // 将UIImage对象转成NSData对象(二进制数据)
        NSData *data = UIImageJPEGRepresentation(image, 0.4);
        // 第一个参数: 上传的二进制数据
        // 第二个参数: 上传文件对应的参数名(通过查API手册获得)
        // 第三个参数: 上传文件的文件名(这个名字通常没用, 因为服务器通常会用自己的命名规则给上传的文件起名字来避免名字冲突)
        // 第四个参数: MIME类型(告知服务器上传的文件的类型)
        [formData appendPartWithFileData:data name:@"User_Pic" fileName:filename mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strong typeof(self) strongSelf = weakSelf;
        successBlock([strongSelf transformation:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
#pragma mark upload Image
+(void)uploadImgWithUrlStringthree:(NSString *)urlString parameters:(NSDictionary<NSString *,id> *)parameters image:(nonnull UIImage*)image progress:(void (^)(NSProgress * _Nullable progress))progressBlock success:(successBlock)successBlock failure:(failureBlock)failureBlock{
    NSParameterAssert(urlString);
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    __weak typeof(self) weakSelf = self;
    [session POST:urlString parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 通过UUID生成一个全局唯一的文件名
        NSString *filename = [NSString stringWithFormat:@"%@.png", [NSUUID UUID].UUIDString];
        // 将UIImage对象转成NSData对象(二进制数据)
        NSData *data = UIImageJPEGRepresentation(image, 0.4);
        // 第一个参数: 上传的二进制数据
        // 第二个参数: 上传文件对应的参数名(通过查API手册获得)
        // 第三个参数: 上传文件的文件名(这个名字通常没用, 因为服务器通常会用自己的命名规则给上传的文件起名字来避免名字冲突)
        // 第四个参数: MIME类型(告知服务器上传的文件的类型)
        [formData appendPartWithFileData:data name:@"User_Live" fileName:filename mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strong typeof(self) strongSelf = weakSelf;
        successBlock([strongSelf transformation:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}

@end
