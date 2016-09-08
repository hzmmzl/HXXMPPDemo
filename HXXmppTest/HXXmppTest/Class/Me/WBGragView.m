//
//  GragView.m
//  HXXmppTest
//
//  Created by winbei on 16/9/6.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "WBGragView.h"

@implementation WBGragView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //允许用户交互
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        //允许用户交互
        self.image = image;
        self.x = 0;
        self.y = kScreenHeight*3/5;
        [self sizeToFit];
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //保存触摸起始点位置
    CGPoint point = [[touches anyObject] locationInView:self];
    _startPoint = point;
    
    //该view置于最前
    [[self superview] bringSubviewToFront:self];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //计算位移=当前位置-起始位置
    CGPoint point = [[touches anyObject] locationInView:self];
    float dx = point.x - _startPoint.x;
    float dy = point.y - _startPoint.y;
    
    //计算移动后的view中心点
    CGPoint newcenter = CGPointMake(self.center.x + dx, self.center.y + dy);
    
    
    /* 限制用户不可将视图托出屏幕 */
    float halfx = CGRectGetMidX(self.bounds);
    //x坐标左边界
    newcenter.x = MAX(halfx, newcenter.x);
    //x坐标右边界
    newcenter.x = MIN(self.superview.bounds.size.width - halfx, newcenter.x);
    
    //y坐标同理
    float halfy = CGRectGetMidY(self.bounds);
    newcenter.y = MAX(halfy, newcenter.y);
    CGFloat hWidth = self.image.size.height*0.5;
    newcenter.y = MIN(self.superview.bounds.size.height - halfy, newcenter.y);
    if (newcenter.y >= kScreenHeight-49-hWidth) {
        newcenter.y = kScreenHeight-49-hWidth;
    }
    if (newcenter.y <= 64+hWidth) {
        newcenter.y = 64+hWidth;
    }
    //移动view
    self.center = newcenter;
}

// 触摸取消(有短息,电话,发生临时中断)
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"触摸取消");
}

//触摸结束
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"触摸结束");
    CGPoint currentPoint = self.center;
    CGFloat length = currentPoint.x < kScreenWidth*0.5 ? currentPoint.x : kScreenWidth - currentPoint.x;
    NSTimeInterval timeInterval = 0.4*2*length/kScreenWidth;
    if (currentPoint.x > kScreenWidth / 2) {
        [UIView animateWithDuration:timeInterval animations:^{
            self.x = kScreenWidth - self.width;
        }];
    }else{
        [UIView animateWithDuration:timeInterval animations:^{
            self.x = 0;
        }];
    }
}

@end
