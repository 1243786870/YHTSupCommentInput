//
//  UINavigationBar+BackGroundColor.h
//  YHTSupCommentInput
//
//  Created by yanghaitao  on 16/7/21.
//  Copyright © 2016年 yanghaitao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (BackGroundColor)

@property (nonatomic, strong) UIView *overlay;
/**
 *  设置背景颜色
 *
 *  @param backgroundclolr 添加背景颜色
 */
- (void)yht_setBackgroundColor:(UIColor *)backgroundclolr;
/**
 *  设置元素透明度
 *
 *  @param alphe 透明度
 */
- (void)yht_setElementsAlpha:(CGFloat)alpha;
/**
 *  设置形变高度
 *
 *  @param translationY 高度
 */
- (void)yht_setTranslationY:(CGFloat)translationY;
//重设
- (void)yht_reset;
@end
