//
//  ChatToolView.m
//  HXXmppTest
//
//  Created by winbei on 16/9/13.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "ChatToolView.h"
#import "UIImage+Size.h"
#define kPadding 10
#define kTopPadding 5
#define kImageH 30
#define kImageW 30
@interface ChatToolView()<UITextViewDelegate>
@property (nonatomic , weak) UIButton *yuYinImageView;
@property (nonatomic , weak) UIButton *biaoQinImageView;
@property (nonatomic , weak) UIButton *pictureImageView;
@property (nonatomic , weak) UITextView *textView;
@property (nonatomic , weak) UIButton *pressButton;
@end
@implementation ChatToolView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = kGrayColor(230);
        UIButton *yuYin = [[UIButton alloc] init];
        [yuYin setImage:[UIImage imageNamed:@"chatBar_keyboard"] forState:UIControlStateNormal];
        [yuYin setImage:[UIImage imageNamed:@"chatBar_keyboardSelected"] forState:UIControlStateHighlighted];
        [yuYin addTarget:self action:@selector(yuYinClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:yuYin];
        self.yuYinImageView = yuYin;
        
        UITextView *textView = [[UITextView alloc] init];
        textView.backgroundColor = kGrayColor(247);//kColorWithRBG(247, 247, 247);
        textView.layer.borderColor = kColorWithRBG(216, 216, 216).CGColor;
        textView.layer.borderWidth = 1;
        [self addSubview:textView];
        textView.delegate = self;
        self.textView = textView;
        
        UIButton *biaoQin = [[UIButton alloc] init];
        [biaoQin setImage:[UIImage imageNamed:@"chatBar_face"] forState:UIControlStateNormal];
        [biaoQin setImage:[UIImage imageNamed:@"chatBar_faceSelected"] forState:UIControlStateHighlighted];
        [yuYin addTarget:self action:@selector(biaoQinClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:biaoQin];
        self.biaoQinImageView = biaoQin;
        
        UIButton *picture = [[UIButton alloc] init];
        [picture setImage:[UIImage imageNamed:@"chatBar_more"] forState:UIControlStateNormal];
        [picture setImage:[UIImage imageNamed:@"chatBar_moreSelected"] forState:UIControlStateHighlighted];
        [yuYin addTarget:self action:@selector(pictureClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:picture];
        self.pictureImageView = picture;
        
        UIButton *pressBtn = [[UIButton alloc] init];
        [pressBtn setTitle:@"按住录音" forState:UIControlStateNormal];
        [pressBtn setTitle:@"松开发送" forState:UIControlStateHighlighted];
        [pressBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [pressBtn setBackgroundImage:[UIImage resizedImageWithName:@"MassSend_SendAgain"] forState:UIControlStateNormal];
        [pressBtn setBackgroundImage:[UIImage resizedImageWithName:@"MassSend_SendAgainHL"] forState:UIControlStateHighlighted];
        [self addSubview:pressBtn];
        pressBtn.hidden = YES;
        self.pressButton = pressBtn;
        
    }
    return self;
}

- (void)yuYinClicked:(UIButton *)bun
{
    bun.selected = !bun.selected;
    if (bun.selected == YES) {//语言
        [_yuYinImageView setImage:[UIImage imageNamed:@"chatBar_record"] forState:UIControlStateNormal];
        [_yuYinImageView setImage:[UIImage imageNamed:@"chatBar_recordSelected"] forState:UIControlStateHighlighted];
        _textView.hidden = YES;
        _pressButton.hidden = NO;
    }else{//键盘
        [_yuYinImageView setImage:[UIImage imageNamed:@"chatBar_keyboard"] forState:UIControlStateNormal];
        [_yuYinImageView setImage:[UIImage imageNamed:@"chatBar_keyboardSelected"] forState:UIControlStateHighlighted];
        _textView.hidden = NO;
        _pressButton.hidden = YES;
    }
}

- (void)biaoQinClicked:(UIButton *)bun
{
//    if (_toolButtonBlock) {
//        _toolButtonBlock(bun,ButtonTypeBiaoQin);
//    }
}

- (void)pictureClicked:(UIButton *)bun
{
//    if (_toolButtonBlock) {
//        _toolButtonBlock(bun,ButtonTypeBiaoQin);
//    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _yuYinImageView.frame = CGRectMake(kPadding, kTopPadding, kImageW, kImageH);
    _pictureImageView.frame = CGRectMake(self.width - kPadding-kImageW, kTopPadding, kImageW, kImageH);
    _biaoQinImageView.frame = CGRectMake(self.width - kImageW*2 - 2*kPadding, kTopPadding, kImageW, kImageH);
    _textView.frame = CGRectMake(CGRectGetMaxX(_yuYinImageView.frame) + kPadding, kTopPadding, CGRectGetMinX(_biaoQinImageView.frame) - 3*kPadding - kImageW, kImageH);
    _pressButton.frame = _textView.frame;
}


#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (!textView.text.length ) return;
    if ([textView.text hasSuffix:@"\n"]) {
        //发送信息
        if (self.textViewSendBlock) {
            _textViewSendBlock(textView,SendMessageTypeMessage);
        }
        [self.textView resignFirstResponder];
    }
}


@end
