//
//  UINavigationBar+BackGroundColor.m
//  YHTSupCommentInput
//
//  Created by yanghaitao  on 16/7/21.
//  Copyright © 2016年 yanghaitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "UINavigationBar+BackGroundColor.h"

@implementation UINavigationBar (BackGroundColor)
static char overlaykey;

- (UIView *)overlay{
    return objc_getAssociatedObject(self, &overlaykey);
}
- (void)setOverlay:(UIView *)overlay{
    objc_setAssociatedObject(self, &overlaykey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)yht_setBackgroundColor:(UIColor *)backgroundclolr{
    if (!self.overlay) {
        // 这么做可以让导航条背景为透明的
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        // 创建UIView，高度为64，y为-20
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        // 设置该UIView没有用户交互功能
        self.overlay.userInteractionEnabled = NO;
        // 设置自动布局
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        // 注意这个self是导航条，而导航条是不包括状态栏的
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundclolr;
}
- (void)yht_setTranslationY:(CGFloat)translationY{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}
- (void)yht_setElementsAlpha:(CGFloat)alpha{
    [[self valueForKey:@"_leftViews"]enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.alpha = alpha;
    }];
    [[self valueForKey:@"_rightViews"]enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    // when viewController first load ,the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}
- (void)yht_reset{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}




@end








