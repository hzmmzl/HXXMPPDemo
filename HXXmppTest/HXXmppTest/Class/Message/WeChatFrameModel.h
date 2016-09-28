//
//  WeChatFrameModel.h
//  HXXmppTest
//
//  Created by winbei on 16/9/27.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kContentTextFont kSystemFontSize(13)
@class WeChatTableViewCell;
@interface WeChatFrameModel : NSObject
@property (nonatomic , strong) EMMessage *message;
@property (nonatomic , assign) CGRect timeLabelF;
@property (nonatomic , assign) CGRect contentBtnF;
@property (nonatomic , assign) CGRect iconImageF;
//cell高度
@property (nonatomic , assign) CGFloat cellHeight;
@end
