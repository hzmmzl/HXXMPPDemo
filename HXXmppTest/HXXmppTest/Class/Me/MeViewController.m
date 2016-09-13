//
//  MeViewController.m
//  HXXmppTest
//
//  Created by winbei on 16/9/6.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "MeViewController.h"
#import "WBGragView.h"
#import "UserInfo.h"
@interface MeViewController ()
@property (nonatomic , strong) WBGragView *imageView;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView = [[WBGragView alloc] initWithImage:[UIImage imageNamed:@"Action_qzone"]];
    [self.view addSubview:_imageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked)];
    [self.imageView addGestureRecognizer:tap];
    UserInfo *info = [UserTool getUserInfo];
    self.navigationItem.title = info.userName;
}


/**
 *  退出
 */
- (void)clicked
{
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        NSLog(@"退出成功");
        [[NSNotificationCenter defaultCenter] postNotificationName:kLogOutSuccess object:self];
    }
}

@end
