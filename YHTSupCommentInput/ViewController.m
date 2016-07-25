//
//  ViewController.m
//  YHTSupCommentInput
//
//  Created by yanghaitao  on 16/7/20.
//  Copyright © 2016年 yanghaitao. All rights reserved.
//

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen ]bounds].size.height
#import "ViewController.h"
#import "FirstViewController.h"
#import "UINavigationBar+BackGroundColor.h"
#import "UIImageView+JustContent.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *firstB;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"你好啊";
    self.view.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:self.firstB];
    [self.view addSubview:self.tableView];
    [self header];
    [self observeTableView];
}
//添加监听者
- (void)observeTableView{
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}
#pragma mark UIViewContentMode很重要
- (void)header{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -150, ScreenWidth, 300)];
//    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [UIImage imageNamed:@"5"];
//    [imageView yht_justContentWithImage:[UIImage imageNamed:@"1"]];
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    headerV.contentMode =  UIViewContentModeScaleAspectFit;
    headerV.backgroundColor = [UIColor clearColor];
    [headerV addSubview:imageView];
    self.tableView.tableHeaderView = headerV;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{

    CGFloat offset = self.tableView.contentOffset.y;
    CGFloat delta  = offset / 64.f +1.f;
    delta = delta > 0 ? delta: 0;
#if 0
    [self.navigationController.navigationBar yht_setBackgroundColor:[[UIColor orangeColor] colorWithAlphaComponent:(delta > 1 ? 1:delta)]];
#else
    if (offset > 0) {
        if (offset > 44) {
            [self setNavigationBarTransformProgress:1];
        }else{
            [self setNavigationBarTransformProgress:(offset / 44)];
        }
    }else{
        [self setNavigationBarTransformProgress:0];
        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    }
    
#endif
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar yht_reset];
}
- (void)setNavigationBarTransformProgress:(CGFloat)progress{
    [self.navigationController.navigationBar yht_setElementsAlpha:(1-progress)];
    [self.navigationController.navigationBar yht_setTranslationY:(-44 * progress)];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,ScreenHeight ) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 44;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"text";
    return cell;
}

- (UIButton *)firstB{
    if (!_firstB) {
        _firstB = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 100, 100)];
        [_firstB setTitle:@"first" forState:UIControlStateNormal];
        [_firstB addTarget:self action:@selector(jumpFirst) forControlEvents:UIControlEventTouchUpInside];
        [_firstB setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_firstB setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        _firstB.backgroundColor = [UIColor orangeColor];
    }return _firstB;
}
- (void)jumpFirst{
    FirstViewController *firstView = [[FirstViewController alloc]init];
    self.navigationController.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self.navigationController pushViewController:firstView animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
