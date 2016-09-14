//
//  ChatToolView.m
//  HXXmppTest
//
//  Created by winbei on 16/9/13.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "ChatToolView.h"
#define kPadding 10
#define kTopPadding 5
#define kImageH 30
#define kImageW 30
@interface ChatToolView()
@property (nonatomic , weak) UIButton *yuYinImageView;
@property (nonatomic , weak) UIButton *biaoQinImageView;
@property (nonatomic , weak) UIButton *pictureImageView;
@property (nonatomic , weak) UITextView *textView;
@end
@implementation ChatToolView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"chatBar_recordBg"]];
        UIButton *yuYin = [[UIButton alloc] init];
        [yuYin setImage:[UIImage imageNamed:@"chatBar_keyboard"] forState:UIControlStateNormal];
        [yuYin setImage:[UIImage imageNamed:@"chatBar_keyboardSelected"] forState:UIControlStateHighlighted];
        [yuYin addTarget:self action:@selector(yuYinClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:yuYin];
        self.yuYinImageView = yuYin;
        
        UITextView *textView = [[UITextView alloc] init];
        textView.backgroundColor = kColorWithRBG(247, 247, 247);
        textView.layer.borderColor = kColorWithRBG(216, 216, 216).CGColor;
        textView.layer.borderWidth = 1;
        [self addSubview:textView];
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
        
    }
    return self;
}

- (void)yuYinClicked:(UIButton *)bun
{
    if (bun.selected == YES) {
        [_yuYinImageView setImage:[UIImage imageNamed:@"chatBar_record"] forState:UIControlStateNormal];
        [_yuYinImageView setImage:[UIImage imageNamed:@"chatBar_recordSelected"] forState:UIControlStateHighlighted];
    }else{
        [_yuYinImageView setImage:[UIImage imageNamed:@"chatBar_keyboard"] forState:UIControlStateNormal];
        [_yuYinImageView setImage:[UIImage imageNamed:@"chatBar_keyboardSelected"] forState:UIControlStateHighlighted];
    }
}

- (void)biaoQinClicked:(UIButton *)bun
{}

- (void)pictureClicked:(UIButton *)bun
{}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _yuYinImageView.frame = CGRectMake(kPadding, kTopPadding, kImageW, kImageH);
    _pictureImageView.frame = CGRectMake(self.width - kPadding-kImageW, kTopPadding, kImageW, kImageH);
    _biaoQinImageView.frame = CGRectMake(self.width - kImageW*2 - 3*kPadding, kTopPadding, kImageW, kImageH);
    _textView.frame = CGRectMake(CGRectGetMaxX(_yuYinImageView.frame) + kPadding, kTopPadding, CGRectGetMinX(_biaoQinImageView.frame) - kPadding, kImageH);
}

@end
