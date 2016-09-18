//
//  UIImage+Size.h
//  TestOCWeiBo
//
//  Created by winbei on 16/8/8.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Size)
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
+(UIImage *)resizedImageWithName:(NSString *)name;
@end
