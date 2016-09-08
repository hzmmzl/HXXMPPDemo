//
//  MeViewController.m
//  HXXmppTest
//
//  Created by winbei on 16/9/6.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "MeViewController.h"
#import "WBGragView.h"
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
}


- (void)clicked
{
    NSLog(@"=========");
}

@end
