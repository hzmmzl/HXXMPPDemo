//
//  WeChatFrameModel.m
//  HXXmppTest
//
//  Created by winbei on 16/9/27.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "WeChatFrameModel.h"
#import "WeChatTableViewCell.h"
#import "NSString+Str.h"
#import "NSDate+MJ.h"
#define kIconH 30
#define kIconW 30
#define kPadding 20


@interface WeChatFrameModel()

@end
@implementation WeChatFrameModel

- (void)setMessage:(EMMessage *)message
{
    _message = message;
    // 收到的文字消息
    EMMessageBody *msgBody = message.body;
    EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
    NSString *contextStr = textBody.text;
    //时间
    //判断是否显示时间
    /*
        如果时间间隔在1分钟内不显示
        否则显示时间
     */
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:message.localTime];
    
    if ([date deltaWithNow].minute < 60) {
        _timeLabelF = CGRectMake(0, 0, kScreenWidth, 0);
    }else{
        _timeLabelF = CGRectMake(0, 0, kScreenWidth, 20);
    }
    
    //发送
//    EMMessageDirectionSend = 0,    /*! \~chinese 发送的消息 \~english Send */
//    EMMessageDirectionReceive,     /*! \~chinese 接收的消息 \~english Receive */
    CGFloat maxW = kScreenWidth * 0.5;
    CGSize contentSize = [contextStr getSize:kContentTextFont maxSize:CGSizeMake(maxW, MAXFLOAT)];
    CGFloat y = CGRectGetMaxY(_timeLabelF);
    if (message.direction == EMMessageDirectionSend) {//接受
        //头像
        _iconImageF = CGRectMake(kPadding*0.5,0 + CGRectGetMaxY(_timeLabelF), kIconW, kIconH);
        CGFloat x = CGRectGetMaxX(_iconImageF) + kPadding*0.5;
        _contentBtnF = CGRectMake(x, y, contentSize.width+kPadding, contentSize.height > kIconH ? contentSize.height : kIconH);
    }else{
        //发送
        CGFloat x = kScreenWidth - kPadding - kIconW;
        _iconImageF = CGRectMake(x, kPadding*0.5 + CGRectGetMaxY(_timeLabelF), kIconW, kIconH);
        _contentBtnF = CGRectMake(CGRectGetMinX(_iconImageF) + contentSize.width , y, contentSize.width+kPadding, contentSize.height > kIconH ? contentSize.height : kIconH);
    }
    
    //cell高度
    _cellHeight = MAX(CGRectGetMaxY(_contentBtnF), CGRectGetMaxY(_iconImageF));
}
@end
