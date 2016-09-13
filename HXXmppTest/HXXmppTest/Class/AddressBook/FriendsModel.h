//
//  FriendsModel.h
//  HXXmppTest
//
//  Created by winbei on 16/9/12.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    friendTypeAdd,
    friendTypeSearch
}friendType;
@interface FriendsModel : NSObject
/*
 *  组头部标题
 */
@property (nonatomic, strong) NSString *headerTitle;

/*
 *  组尾部说明
 */
@property (nonatomic, strong) NSString *footerTitle;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *icon;
@property (nonatomic , assign) friendType type;

- (instancetype)modelForDictionary:(NSDictionary *)dic;
@end
