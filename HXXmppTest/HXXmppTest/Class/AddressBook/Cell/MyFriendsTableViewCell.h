//
//  MyFriendsTableViewCell.h
//  HXXmppTest
//
//  Created by winbei on 16/9/12.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FriendsModel;


@interface MyFriendsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (nonatomic , strong) FriendsModel *friendModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
