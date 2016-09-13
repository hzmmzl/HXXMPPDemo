//
//  MyFriendsTableViewCell.m
//  HXXmppTest
//
//  Created by winbei on 16/9/12.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "MyFriendsTableViewCell.h"
#import "FriendsModel.h"
@interface MyFriendsTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *friendNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end
@implementation MyFriendsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    if (self.type == friendTypeAdd) {
//        _addButton.hidden = NO;
//    }else{
//        _addButton.hidden = YES;
//    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellId = @"MyFriendsTableViewCellId";
    MyFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyFriendsTableViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setFriendModel:(FriendsModel *)friendModel
{
    _friendModel = friendModel;
    _iconImageView.image = [UIImage imageNamed:friendModel.icon];
    _friendNameLabel.text = friendModel.title;
}

@end
