//
//  NSString+Str.m
//  TestOCWeiBo
//
//  Created by winbei on 16/8/10.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "NSString+Str.h"

@implementation NSString (Str)
- (BOOL)containsSubString:(NSString *)str
{
    if (IS_IOS8) {
        return [self containsString:str];
    }else{
        NSRange range = [self rangeOfString:str];
        if (range.length != NSNotFound) {
            return YES;
        }
    }
    return NO;
}


- (CGSize)getSize:(UIFont *)font maxSize:(CGSize)maxSize
{
    CGSize size = CGSizeZero;
    if (IS_IOS7) {
        size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        //        size = [self.text sizeWithAttributes:@{NSFontAttributeName:font}];
    }else{
        size = [self sizeWithFont:font];
    }
    return size;
}
@end
