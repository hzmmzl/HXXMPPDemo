//
//  AppDelegate.h
//  HXXmppTest
//
//  Created by winbei on 16/8/31.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/**
 *  登录成功
 */
- (void)logInSuccess;

/**
 *  退出登录
 */
- (void)logOutSuccess;

@end

