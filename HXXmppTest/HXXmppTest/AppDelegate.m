//
//  AppDelegate.m
//  HXXmppTest
//
//  Created by winbei on 16/8/31.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "AppDelegate.h"
//#import "EMSDK.h"
@interface AppDelegate ()

#define HXAppKey @"hzm123#myxmpp"
#define HXClientId @"YXA6q0YrcFJREea9aaWeNX-5Vw"
#define HXClientSecret @"YXA6P-nUTnS6JA0Z5ueSU6yr5oVA5PM"
#define HXApnsCertName @""//推送证书名（不需要加后缀），详细见下面注释。
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
