//
//  UIImage+Size.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/8.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "UIImage+Size.h"

@implementation UIImage (Size)
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [UIImage imageNamed:name];
    [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
    return image;
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}
@end
