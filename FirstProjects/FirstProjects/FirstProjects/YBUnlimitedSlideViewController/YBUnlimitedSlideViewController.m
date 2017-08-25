//
//  YBUnlimitedSlideViewController.m
//  YBExample
//
//  Created by laouhn on 15/11/14.
//  Copyright (c) 2015年 laouhn. All rights reserved.
//

#import "YBUnlimitedSlideViewController.h"


@interface YBUnlimitedSlideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *leftImageView, *middleImageView, *rightImageView;

@property (nonatomic, strong) UIScrollView *scrollerView;
//当前展示的图片
@property (nonatomic, assign) NSInteger currentIndex;
//数据源
@property (nonatomic, strong) NSMutableArray *dataSource;
//scrollerView的宽高
@property (nonatomic, assign) NSInteger scrollerViewWidth, scrollerViewHeight;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation YBUnlimitedSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollerViewWidth = [UIScreen mainScreen].bounds.size.width;
    _scrollerViewHeight = self.scrollerViewWidth * 0.5625;
    
    if (_delegate && [_delegate respondsToSelector:@selector(backDataSourceArray:)]) {
        if (_delegate && [_delegate respondsToSelector:@selector(backScrollerViewForWidthAndHeight:)]) {
            CGSize size = [_delegate backScrollerViewForWidthAndHeight:self];
            self.scrollerViewWidth = size.width;
            self.scrollerViewHeight = size.height;
        }
        self.dataSource = [NSMutableArray arrayWithArray:[_delegate backDataSourceArray:self]];
        [self configureScrollerView];
        [self configureImageView];
        if (self.isPageControl) {
            [self configurePageController];
        }else{
            [self configurePageController];
            _pageControl.pageIndicatorTintColor = [UIColor clearColor];
            _pageControl.currentPageIndicatorTintColor = [UIColor clearColor];
        }
        
    }
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(time:) userInfo:nil repeats:YES];
}
- (void)time:(NSTimer *)time{
    [UIView animateWithDuration:1 animations:^{
        [self.scrollerView setContentOffset:CGPointMake(self.scrollerViewWidth * 2, 0) animated:YES];
    }];
}
- (void)setAgain:(NSString *)again{
    self.dataSource = [self.delegate backDataSourceArray:self];
    _pageControl.numberOfPages = self.dataSource.count;
    CGSize size = [_delegate backScrollerViewForWidthAndHeight:self];
    self.scrollerViewWidth = size.width;
    self.scrollerViewHeight = size.height;
    _scrollerView.frame = CGRectMake(0, 0, self.scrollerViewWidth, self.scrollerViewHeight);
    _scrollerView.backgroundColor = [UIColor clearColor];
    _scrollerView.delegate = self;
    _scrollerView.contentSize = CGSizeMake(self.scrollerViewWidth * 3, self.scrollerViewHeight);
    _scrollerView.contentOffset = CGPointMake(self.scrollerViewWidth, 0);
    [self.leftImageView removeFromSuperview];
    [self.middleImageView removeFromSuperview];
    [self.rightImageView removeFromSuperview];
    [self configureImageView];
    
}
- (void)configureScrollerView{
    _scrollerView = [[UIScrollView alloc]initWithFrame:(CGRectMake(0, 0, self.scrollerViewWidth, self.scrollerViewHeight))];
    _scrollerView.backgroundColor = [UIColor clearColor];
    _scrollerView.delegate = self;
    _scrollerView.contentSize = CGSizeMake(self.scrollerViewWidth * 3, self.scrollerViewHeight);
    _scrollerView.contentOffset = CGPointMake(self.scrollerViewWidth, 0);
    _scrollerView.pagingEnabled = YES;
    [self.view addSubview:_scrollerView];
}
- (void)configureImageView{
    self.leftImageView = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 0, self.scrollerViewWidth, self.scrollerViewHeight))];
    self.middleImageView = [[UIImageView alloc]initWithFrame:(CGRectMake(self.scrollerViewWidth, 0, self.scrollerViewWidth, self.scrollerViewHeight))];
    self.rightImageView = [[UIImageView alloc]initWithFrame:(CGRectMake(2*self.scrollerViewWidth, 0, self.scrollerViewWidth, self.scrollerViewHeight))];
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    if (self.dataSource.count != 0) {
        [self ImgStr:_leftImageView Str:[self.dataSource lastObject]];
        [self ImgStr:_middleImageView Str:[self.dataSource firstObject]];
        [self ImgStr:_rightImageView Str:self.dataSource[1]];
    }
    [self.scrollerView addSubview:self.leftImageView];
    [self.scrollerView addSubview:self.middleImageView];
    [self.scrollerView addSubview:self.rightImageView];
}
- (void)ImgStr:(UIImageView *)img Str:(NSString *)str{
    if ([str rangeOfString:@"http://"].location == NSNotFound){
        img.image = [UIImage imageNamed:str];
    }else{
        img.imageURL = [NSURL URLWithString:str];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    if (self.dataSource.count != 0) {
        if (offset >= 2*self.scrollerViewWidth) {
            scrollView.contentOffset = CGPointMake(self.scrollerViewWidth, 0);
            self.currentIndex++;
            if (self.currentIndex == self.dataSource.count -1) {
                [self ImgStr:_leftImageView Str:self.dataSource[self.currentIndex - 1]];
                [self ImgStr:_middleImageView Str:self.dataSource[self.currentIndex]];
                [self ImgStr:_rightImageView Str:self.dataSource.firstObject];
                self.pageControl.currentPage = self.currentIndex;
                self.currentIndex = -1;
            }
            else if (self.currentIndex == self.dataSource.count){
                [self ImgStr:_leftImageView Str:self.dataSource.lastObject];
                [self ImgStr:_middleImageView Str:self.dataSource.firstObject];
                [self ImgStr:_rightImageView Str:self.dataSource[1]];
                self.pageControl.currentPage = 0;
                self.currentIndex = 0;
            }
            else if(self.currentIndex == 0){
                [self ImgStr:_leftImageView Str:self.dataSource.lastObject];
                [self ImgStr:_middleImageView Str:self.dataSource[self.currentIndex]];
                [self ImgStr:_rightImageView Str:self.dataSource[self.currentIndex+1]];
                self.pageControl.currentPage = self.currentIndex;
            }else{
                [self ImgStr:_leftImageView Str:self.dataSource[self.currentIndex-1]];
                [self ImgStr:_middleImageView Str:self.dataSource[self.currentIndex]];
                [self ImgStr:_rightImageView Str:self.dataSource[self.currentIndex+1]];
                self.pageControl.currentPage = self.currentIndex;
            }
            
        }
        if (offset <= 0) {
            scrollView.contentOffset = CGPointMake(self.scrollerViewWidth, 0);
            self.currentIndex--;
            if (self.currentIndex == -2) {
                self.currentIndex = self.dataSource.count-2;
                [self ImgStr:_leftImageView Str:self.dataSource[self.dataSource.count-1]];
                [self ImgStr:_middleImageView Str:self.dataSource[self.currentIndex]];
                [self ImgStr:_rightImageView Str:self.dataSource.lastObject];
                self.pageControl.currentPage = self.currentIndex;
            }
            else if (self.currentIndex == -1) {
                self.currentIndex = self.dataSource.count-1;
                [self ImgStr:_leftImageView Str:self.dataSource[self.currentIndex-1]];
                [self ImgStr:_middleImageView Str:self.dataSource[self.currentIndex]];
                [self ImgStr:_rightImageView Str:self.dataSource.firstObject];
                self.pageControl.currentPage = self.currentIndex;
            }else if (self.currentIndex == 0){
                [self ImgStr:_leftImageView Str:self.dataSource.lastObject];
                [self ImgStr:_middleImageView Str:self.dataSource[self.currentIndex]];
                [self ImgStr:_rightImageView Str:self.dataSource[self.currentIndex+1]];
                self.pageControl.currentPage = self.currentIndex;
            }else{
                [self ImgStr:_leftImageView Str:self.dataSource[self.currentIndex-1]];
                [self ImgStr:_middleImageView Str:self.dataSource[self.currentIndex]];
                [self ImgStr:_rightImageView Str:self.dataSource[self.currentIndex+1]];
                self.pageControl.currentPage = self.currentIndex;
            }
        }
    }
}


- (void)configurePageController{
    _pageControl = [[UIPageControl alloc]initWithFrame:(CGRectMake(0, _scrollerViewHeight-20, _scrollerViewWidth / 2, 20))];
    _pageControl.numberOfPages = self.dataSource.count;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"cd72b5"];
    _pageControl.userInteractionEnabled = NO;
    [self.view addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.mas_equalTo(0);
    }];
}
//返回当前展示的是第几张图片
- (NSInteger)backCurrentCilkPicture{
    return self.pageControl.currentPage;
}
@end
