//
//  FirstViewController.m
//  YHTSupCommentInput
//
//  Created by yanghaitao  on 16/7/20.
//  Copyright © 2016年 yanghaitao. All rights reserved.
//

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen ]bounds].size.height
#import "FirstViewController.h"

@interface FirstViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scrollView];
}
- (UIView *)view1{
    if (!_view1) {
        _view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _view1.backgroundColor = [UIColor yellowColor];
    }
    return _view1;
}
- (UIView *)view2{
    if (!_view2) {
        _view2 = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight)];
        _view2.backgroundColor = [UIColor grayColor];
    }
    return _view2;
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen ]bounds].size.height)];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        
        _scrollView.contentSize = CGSizeMake( ScreenWidth* 2,0);
        [_scrollView addSubview:self.view1];
        [_scrollView addSubview:self.view2];
    }
    return _scrollView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
