//
//  MainTabBarController.m
//  HXXmppTest
//
//  Created by winbei on 16/9/6.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *imageArray = @[@"tabbar_mainframe",@"tabbar_contacts",@"tabbar_discover",@"tabbar_me"];
    NSArray *selectedImageArray = @[@"tabbar_mainframeHL",@"tabbar_contactsHL",@"tabbar_discoverHL",@"tabbar_meHL"];
    NSArray *titleArray = @[@"消息",@"联系人",@"发现",@"我"];
    NSArray *classArray = @[@"MessageViewController",@"AddressViewController",@"FindViewController",@"FindViewController"];
    NSMutableArray *vcArr = [NSMutableArray array];
    for (int i = 0; i<classArray.count; i++) {
      UIViewController *vc = [[NSClassFromString(classArray[i]) alloc] init];
        vc.title = titleArray[i];
        vc.tabBarItem.image = [UIImage imageNamed:imageArray[i]];
        vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageArray[i]];
        [vcArr addObject:vc];
    }
    self.viewControllers = [NSArray arrayWithArray:vcArr];
}

@end