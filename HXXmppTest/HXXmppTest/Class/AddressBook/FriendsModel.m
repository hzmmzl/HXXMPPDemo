//
//  FriendsModel.m
//  HXXmppTest
//
//  Created by winbei on 16/9/12.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "FriendsModel.h"

@implementation FriendsModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}


- (instancetype)modelForDictionary:(NSDictionary *)dic
{
    [self setValuesForKeysWithDictionary:dic];
    return self;
}
@end
