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
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (self.viewControllers >= 0) {
        [viewController hidesBottomBarWhenPushed];
    }
//    [super pushViewController:viewController animated:animated];
}


@end
