//
//  ZHBaseViewController.h
//  获取未链接状态内容
//
//  Created by 海神 on 2016/12/26.
//  Copyright © 2016年 海神. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Color+Hex.h"
@interface ZHBaseViewController : UITabBarController
+ (instancetype)shareManager;
@property (nonatomic, strong) UIView *tabbarView;
@property (nonatomic, assign) NSInteger ZH_seletedIndex;
@end
