//
//  AppDelegate.m
//  HXXmppTest
//
//  Created by winbei on 16/8/31.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "AppDelegate.h"
#import "LogAndRegistViewController.h"
#import "MainTabBarController.h"
#import "UserInfo.h"
#import "MBProgressHUD.h"
@interface AppDelegate ()<EMClientDelegate>

#define HXAppKey @"hzm123#myxmpp"
#define HXClientId @"YXA6q0YrcFJREea9aaWeNX-5Vw"
#define HXClientSecret @"YXA6P-nUTnS6JA0Z5ueSU6yr5oVA5PM"
#define HXApnsCertName @""//推送证书名（不需要加后缀），详细见下面注释。
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self logOutSuccess];
    [self.window makeKeyAndVisible];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOutSuccess) name:kLogOutSuccess object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logInSuccess) name:kLogInSuccess object:nil];
    
    EMOptions *options = [EMOptions optionsWithAppkey:HXAppKey];
//    options.apnsCertName = @"";//推送
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    //添加代理（自动登录）
    [[EMClient sharedClient] addDelegate:self];
//    BOOL isAutoLog = [EMClient sharedClient].options.isAutoLogin;//是否自动登录
//    if (isAutoLog) {
//      MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
//        hud.label.text = @"正在登陆";
//    }
    
    return YES;
}


- (void)logInSuccess
{
    MainTabBarController *tabBarVc = [[MainTabBarController alloc] init];
    self.window.rootViewController = tabBarVc;
}

- (void)logOutSuccess
{
    [UserTool saveUserInfo:nil];//取消保存用户信息
    [EMClient sharedClient].options.isAutoLogin = NO;//取消自动登录
    LogAndRegistViewController *lginAndRegistVC = [[LogAndRegistViewController alloc] init];
    self.window.rootViewController = lginAndRegistVC;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}


#pragma mark <EMClientDelegate>
/*
 *  SDK连接服务器的状态变化时会接收到该回调
 *
 *  有以下几种情况, 会引起该方法的调用:
 *  1. 登录成功后, 手机无法上网时, 会调用该回调
 *  2. 登录成功后, 网络状态变化时, 会调用该回调
 *  @param aConnectionState 当前状态
 */
- (void)connectionStateDidChange:(EMConnectionState)aConnectionState
{
    NSLog(@"网络状态%d",aConnectionState);
}

/*
 *  自动登录时的回调
 *  @param aError 错误信息
 */
- (void)autoLoginDidCompleteWithError:(EMError *)aError
{
    if (aError) {
        NSLog(@"登录失败--%@",aError);
    }else{
        [self logInSuccess];
    }
}

/*
 *  当前登录账号在其它设备登录时会接收到此回调
 */
- (void)userAccountDidLoginFromOtherDevice
{
    //退出登录
    [self logOutSuccess];
}

/*
 *  当前登录账号已经被从服务器端删除时会收到该回调
 */
- (void)userAccountDidRemoveFromServer
{
    //退出登录
    [self logOutSuccess];
}


@end
