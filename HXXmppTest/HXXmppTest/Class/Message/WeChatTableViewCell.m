//
//  WeChatTableViewCell.m
//  HXXmppTest
//
//  Created by winbei on 16/9/27.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "WeChatTableViewCell.h"
#import "WeChatFrameModel.h"
#import "UIImage+Size.h"
@interface WeChatTableViewCell()
@property (nonatomic , strong) UILabel *timeLabel;
@property (nonatomic , strong) UIImageView *iconImage;
@property (nonatomic , strong) UIButton *contentBtn;
@end

@implementation WeChatTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
   static NSString *cellId = @"WeChatTableViewCell";
    WeChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[WeChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = kSystemFontSize(11);
        [self.contentView addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        //头像
        UIImageView *iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ff_IconLocationService"]];
        [self.contentView addSubview:iconImage];
        self.iconImage = iconImage;
        
        //内容
        UIButton *contentBtn = [[UIButton alloc] init];
        contentBtn.titleLabel.numberOfLines = 0;
        contentBtn.titleLabel.font = kContentTextFont;
        [contentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.contentView addSubview:contentBtn];
//        contentBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
//        contentBtn.backgroundColor = [UIColor redColor];
        
        self.contentBtn = contentBtn;
    }
    return self;
}

- (void)setFrameModel:(WeChatFrameModel *)frameModel
{
    _frameModel = frameModel;
    //设置数据
    [self setUpData];
    //设置frame
    [self setUpFrame];
}

- (void)setUpData
{
    EMMessage *message = self.frameModel.message;
    //时间
    self.timeLabel.text = [self conversationTime:message.localTime];
    //内容
    EMMessageBody *msgBody = message.body;
    EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
    NSString *contextStr = textBody.text;
    [self.contentBtn setTitle:contextStr forState:UIControlStateNormal];
    
    if (message.direction == EMMessageDirectionReceive) {
        //        接收
        [_contentBtn setBackgroundImage:[UIImage resizedImageWithName:@"SenderAppCardNodeBkg"] forState:UIControlStateNormal];
        [_contentBtn setBackgroundImage:[UIImage resizedImageWithName:@"SenderAppCardNodeBkg_HL"] forState:UIControlStateHighlighted];
    }else{
        //        发送
        [_contentBtn setBackgroundImage:[UIImage resizedImageWithName:@"ReceiverAppNodeBkg"] forState:UIControlStateNormal];
        [_contentBtn setBackgroundImage:[UIImage resizedImageWithName:@"ReceiverAppNodeBkg_HL"] forState:UIControlStateHighlighted];
    }
}

- (void)setUpFrame
{
    self.timeLabel.frame = self.frameModel.timeLabelF;
    self.contentBtn.frame = self.frameModel.contentBtnF;
    self.iconImage.frame = self.frameModel.iconImageF;
}


// 时间的转换
- (NSString *)conversationTime:(long long)time
{
    // 今天 11:20
    // 昨天 23:23
    // 前天以前 11:11
    // 1. 创建一个日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 2. 获取当前时间
    NSDate *currentDate = [NSDate date];
    // 3. 获取当前时间的年月日
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:currentDate];
    NSInteger currentYear = components.year;
    NSInteger currentMonth = components.month;
    NSInteger currentDay = components.day;
    // 4. 获取发送时间
    NSDate *sendDate = [NSDate dateWithTimeIntervalSince1970:time/1000];
    // 5. 获取发送时间的年月日
    NSDateComponents *sendComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:sendDate];
    NSInteger sendYear = sendComponents.year;
    NSInteger sendMonth =  sendComponents.month;
    NSInteger sendDay = sendComponents.day;
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    // 6. 当前时间与发送时间的比较
    if (currentYear == sendYear &&
        currentMonth == sendMonth &&
        currentDay == sendDay) {// 今天
        fmt.dateFormat = @"今天 HH:mm";
    }else if(currentYear == sendYear &&
             currentMonth == sendMonth &&
             currentDay == sendDay + 1){
        fmt.dateFormat = @"昨天 HH:mm";
    }else{
        fmt.dateFormat = @"昨天以前 HH:mm";
    }
    
    return  [fmt stringFromDate:sendDate];
}

@end
