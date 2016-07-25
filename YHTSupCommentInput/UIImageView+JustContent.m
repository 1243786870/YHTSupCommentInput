//
//  UIImageView+JustContent.m
//  YHTSupCommentInput
//
//  Created by yanghaitao  on 16/7/21.
//  Copyright © 2016年 yanghaitao. All rights reserved.
//

#import "UIImageView+JustContent.h"

@implementation UIImageView (JustContent)

- (void)yht_justContentWithImage:(UIImage *)image{
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    
    CGFloat imageViewW = self.frame.size.width;
    CGFloat imageViewH = self.frame.size.height;
    
    CGFloat widthP = imageW/imageViewW;
    CGFloat heightP = imageH/imageViewH;
    
    BOOL WORH = widthP > heightP ? YES:NO;
    CGSize size;
    if (WORH) {
        size = CGSizeMake(imageViewW, imageViewW*imageH/imageW);
    }else{
        size = CGSizeMake(imageViewH*imageW/imageH, imageH);
    }
    self.image = [self scaleToSize:image size:size];
}
- (UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *endImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return endImage;
}

@end
