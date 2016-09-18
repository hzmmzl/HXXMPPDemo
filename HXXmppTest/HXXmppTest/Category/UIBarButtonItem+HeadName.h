//
//  UIBarButtonItem+HeadName.h
//  TestOCWeiBo
//
//  Created by winbei on 16/8/8.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HeadName)
+ (UIBarButtonItem *)barButtonItemWithNormalImage:(NSString *)normalImage HighlightedImage:(NSString *)highlightedImage Title:(NSString *)title TitleSize:(int)size maxSize:(CGSize)maxSize Target:(id)target Action:(SEL)action;

+(UIButton *)customViewWithNormalImage:(NSString *)normalImage HighlightedImage:(NSString *)highlightedImage Title:(NSString *)title TitleSize:(int)size maxSize:(CGSize)maxSize Target:(id)target Action:(SEL)action isTitleView:(BOOL)isTitle;
@end
