//
//  WeChatViewController.m
//  HXXmppTest
//
//  Created by winbei on 16/9/14.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "WeChatViewController.h"
#import "ChatToolView.h"
#define kToolHeight 40
@interface WeChatViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) ChatToolView *chatToolView;
@end

@implementation WeChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


/**
 *  设置tableview
 */

- (void)setUpTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - kToolHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

/**
 *  设置下方工具条
 */
- (void)setUpBottomToolView
{
    self.chatToolView = [[ChatToolView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), kScreenWidth, kToolHeight)];
    [self.view addSubview:_chatToolView];
}


#pragma mark ---UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


@end
