//
//  MainNavigationController.m
//  HXXmppTest
//
//  Created by winbei on 16/9/8.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "MainNavigationController.h"

@interface MainNavigationController ()

@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.barTintColor = [UIColor brownColor];
    
    // 设置导航栏标题颜色为白色
    [bar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName : [UIColor whiteColor]
                                     }];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置导航栏按钮文字颜色为白色
    [item setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName : [UIColor whiteColor],
                                      NSFontAttributeName : [UIFont systemFontOfSize:14]
                                      } forState:UIControlStateNormal];
    item.tintColor = [UIColor whiteColor];
    
    //设置导航栏完全不透明
    bar.translucent = NO;
    

    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}



@end
