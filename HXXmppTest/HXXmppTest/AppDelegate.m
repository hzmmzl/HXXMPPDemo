//
//  AppDelegate.m
//  HXXmppTest
//
//  Created by winbei on 16/8/31.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "AppDelegate.h"
#import "LogAndRegistViewController.h"
@interface AppDelegate ()

#define HXAppKey @"hzm123#myxmpp"
#define HXClientId @"YXA6q0YrcFJREea9aaWeNX-5Vw"
#define HXClientSecret @"YXA6P-nUTnS6JA0Z5ueSU6yr5oVA5PM"
#define HXApnsCertName @""//推送证书名（不需要加后缀），详细见下面注释。
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    LogAndRegistViewController *lginAndRegistVC = [[LogAndRegistViewController alloc] init];
    self.window.rootViewController = lginAndRegistVC;
    [self.window makeKeyAndVisible];
    
    
    EMOptions *options = [EMOptions optionsWithAppkey:HXAppKey];
//    options.apnsCertName = @"";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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

@end
