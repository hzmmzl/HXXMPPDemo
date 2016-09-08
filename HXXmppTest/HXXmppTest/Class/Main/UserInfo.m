//
//  AccountInfo.m
//  HXXmppTest
//
//  Created by winbei on 16/9/6.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

//- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
@end


@implementation UserTool

+ (void)saveUserInfo:(UserInfo *)info
{
    if (info) {
        NSUserDefaults *userDefo = [NSUserDefaults standardUserDefaults];
        [userDefo setObject:info.userName forKey:@"username"];
        [userDefo setObject:info.passWord forKey:@"password"];
        [userDefo synchronize];
    }
}
+ (UserInfo *)getUserInfo
{
    NSUserDefaults *userDefo = [NSUserDefaults standardUserDefaults];
    UserInfo *info = [[UserInfo alloc] init];
    info.userName = [userDefo objectForKey:@"username"];
    info.passWord = [userDefo objectForKey:@"password"];
    return info;
}
@end