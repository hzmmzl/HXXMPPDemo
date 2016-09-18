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
@end
