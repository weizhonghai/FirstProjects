//
//  ZHBaseViewController.m
//  获取未链接状态内容
//
//  Created by 海神 on 2016/12/26.
//  Copyright © 2016年 海神. All rights reserved.
//

#import "ZHBaseViewController.h"




@interface ZHBaseViewController ()
{
    UIView *tabBarView;
    UIButton *cacheBtn;
}
@end

@implementation ZHBaseViewController

static ZHBaseViewController *baseVC = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-57, self.view.frame.size.width, 57)];
    tabBarView.backgroundColor = [UIColor colorWithHexString:@"101010"];
    [self.view addSubview:tabBarView];
    self.tabBar.hidden = YES;
    [self initSubItems];
    [self initSubViewController];
    self.tabbarView = tabBarView;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];//白色
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)setZH_seletedIndex:(NSInteger)ZH_seletedIndex{
    _ZH_seletedIndex = ZH_seletedIndex;
    [self touchBtn:[self.view viewWithTag:ZH_seletedIndex + 1]];
}

#pragma mark 添加tabbar上面的按钮
- (void)initSubItems{
    UIView *itemsView1;
    NSArray *itemImageArray = @[@"tabbar广场",@"tabbar关注",@"tabbar播报",@"tabbar私信",@"tabbar我的"];
    NSArray *itemSelImageArray = @[@"tabbarSel广场",@"tabbarSel关注",@"tabbarSel播报",@"tabbarSel私信",@"tabbarSel我的"];
    for (int i = 0; i < 5; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * self.view.frame.size.width / 5, 0, self.view.frame.size.width / 5, 57)];
        [tabBarView addSubview:view];
        switch (i) {
            case 0:itemsView1 = view;break;
        }
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 37, 31)];
//        if (i != 1) {
        btn.frame = CGRectMake(0, 0, 50, 50);
//        }else{
//            btn.frame = CGRectMake(0, 0, 114, 57);
//        }
        if (i == 2) {
            btn.frame = CGRectMake(0, 0, 100, 50);
        }
        if (i == 0) {
            cacheBtn = btn;
            btn.selected = YES;
        }else{
            btn.transform = CGAffineTransformScale(cacheBtn.transform, 0.9, 0.9);
        }
        [view addSubview:btn];
        [btn setImage:[UIImage imageNamed:itemImageArray[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:itemSelImageArray[i]] forState:UIControlStateSelected];
        btn.center = itemsView1.center;
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}
#pragma mark tabbar点击事件
- (void)touchBtn:(UIButton *)sender{
    if (sender != cacheBtn) {
        cacheBtn.selected = NO;
        sender.selected = YES;
        [UIView animateWithDuration:0.5 animations:^{
            cacheBtn.transform = CGAffineTransformScale(cacheBtn.transform, 0.9, 0.9);
            sender.transform = CGAffineTransformIdentity;
        }];
        cacheBtn = sender;
        self.selectedIndex = sender.tag - 1;
        NSLog(@"%ld",(long)sender.tag);
    }
}

#pragma mark 添加子控制器
- (void)initSubViewController{
//    LiveListViewController *LLVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"vc"];
//    FocusOnViewController *FOVC = [[FocusOnViewController alloc] init];
//    LLVC = [[UIStoryboard storyboardWithName:@"NewLiveListStoryboard" bundle:nil] instantiateInitialViewController];
//    LiveMainViewController *VC = [[UIStoryboard storyboardWithName:@"LiveMainStoryboard" bundle:nil] instantiateInitialViewController];
//    EaseConversationListViewController *chatListVC = [[EaseConversationListViewController alloc] init];//聊天列表页面
//    chatListVC.title = @"我的消息";
////    [self.navigationController pushViewController:chatListVC animated:YES];
//    NewMeMainViewController *MVC = [[NewMeMainViewController alloc] init];
//    
//    NSArray *VCArray = @[LLVC,FOVC,VC,chatListVC,MVC];
//    for (UIViewController *vc in VCArray) {
//        WZHNavigationViewController *NavigaVC = [[WZHNavigationViewController alloc] initWithRootViewController:vc];
//        [self addChildViewController:NavigaVC];
//    }
    
}

#pragma mark 声明代理对象
+ (instancetype)shareManager{
    if (baseVC == nil) {
        baseVC = [[ZHBaseViewController alloc] init];
    }
    return baseVC;
}
@end
