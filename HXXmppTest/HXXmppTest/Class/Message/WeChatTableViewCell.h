//
//  WeChatTableViewCell.h
//  HXXmppTest
//
//  Created by winbei on 16/9/27.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeChatFrameModel;
@interface WeChatTableViewCell : UITableViewCell
@property (nonatomic , strong) WeChatFrameModel *frameModel;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
