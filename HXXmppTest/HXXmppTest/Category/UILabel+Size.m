//
//  UILabel+Size.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/8.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "UILabel+Size.h"

@implementation UILabel (Size)
- (CGSize)getLabelSize:(UIFont *)font maxSize:(CGSize)maxSize
{
    CGSize size = CGSizeZero;
    if (IS_IOS7) {
        size = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
//        size = [self.text sizeWithAttributes:@{NSFontAttributeName:font}];
    }else{
        size = [self.text sizeWithFont:font];
    }
    return size;
}
@end
