//
//  AccountInfo.h
//  HXXmppTest
//
//  Created by winbei on 16/9/6.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property (nonatomic , copy) NSString *userName;
@property (nonatomic , copy) NSString *passWord;
@end

@interface UserTool : NSObject
+ (void)saveUserInfo:(UserInfo *)info;
+ (UserInfo *)getUserInfo;
@end

