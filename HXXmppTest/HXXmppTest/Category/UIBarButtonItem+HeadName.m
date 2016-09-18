//
//  UIBarButtonItem+HeadName.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/8.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "UIBarButtonItem+HeadName.h"
#import "UILabel+Size.h"
#import "UIImage+Size.h"
@implementation UIBarButtonItem (HeadName)
+(UIBarButtonItem *)barButtonItemWithNormalImage:(NSString *)normalImage HighlightedImage:(NSString *)highlightedImage Title:(NSString *)title TitleSize:(int)size maxSize:(CGSize)maxSize Target:(id)target Action:(SEL)action
{
    UIButton *customView = [self customViewWithNormalImage:normalImage HighlightedImage:highlightedImage Title:title TitleSize:size maxSize:maxSize Target:target Action:action isTitleView:NO];
    return [[UIBarButtonItem alloc] initWithCustomView:customView];
}


+(UIButton *)customViewWithNormalImage:(NSString *)normalImage HighlightedImage:(NSString *)highlightedImage Title:(NSString *)title TitleSize:(int)size maxSize:(CGSize)maxSize Target:(id)target Action:(SEL)action isTitleView:(BOOL)isTitle
{
    UIButton *customButton = [[UIButton alloc] init];
    [customButton setTitle:title forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [customButton setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [customButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [customButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    customButton.adjustsImageWhenHighlighted = NO;
    [customButton sizeToFit];
    return customButton;
}
@end
