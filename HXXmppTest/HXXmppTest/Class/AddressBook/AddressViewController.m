//
//  AddressViewController.m
//  HXXmppTest
//
//  Created by winbei on 16/9/6.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "AddressViewController.h"
#import "AddFriendViewController.h"
#import "FriendsModel.h"
#import "MyFriendsTableViewCell.h"
@interface AddressViewController ()<EMContactManagerDelegate>

/**
 *  当前好友
 */
@property (nonatomic , strong) NSMutableArray *currentFriendsArray;
@property (nonatomic , strong) NSMutableArray *topArray;
@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self getTopContext];
    
    
    //注册好友回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getCurrentFriends];
    [self showFindFriendsAndTabBarBadge];
}

#pragma mark Lazy
- (NSArray *)topArray
{
    if (!_topArray) {
        _topArray = [NSMutableArray array];
    }
    return _topArray;
}

- (NSMutableArray *)currentFriendsArray
{
    if (!_currentFriendsArray) {
        _currentFriendsArray = [NSMutableArray array];
    }
    return _currentFriendsArray;
}


/**
 *  头部
 */
- (void)getTopContext
{
    NSDictionary *dic0 = @{@"title":@"申请与通知",@"icon":@"plugins_FriendNotify"};
    NSDictionary *dic1 = @{@"title":@"群组",@"icon":@"add_friend_icon_addgroup"};
    NSDictionary *dic2 = @{@"title":@"聊天室列表",@"icon":@"Contact_icon_ContactTag"};
    NSDictionary *dic3 = @{@"title":@"环信助手",@"icon":@"add_friend_icon_offical"};
    NSArray *tempArr = [NSArray arrayWithObjects:dic0,dic1,dic2,dic3, nil];
    
    for (NSDictionary *dic in tempArr) {
        FriendsModel *model = [[FriendsModel alloc] init];
        model.type = friendTypeAdd;
        [model modelForDictionary:dic];
        [self.topArray addObject:model];
    }
}

/**
 *  获得当前好友
 * 1)从服务器获取所有的好友
 * 2)从数据库获取所有的好友
 */
- (void)getCurrentFriends
{
    //清除原来的列表
    [self.currentFriendsArray removeAllObjects];
        //服务器
        [[EMClient sharedClient].contactManager getContactsFromServerWithCompletion:^(NSArray *aList, EMError *aError) {
            if (!aError) {
                for (NSString *obj in aList) {
                    FriendsModel *model = [[FriendsModel alloc] init];
                    model.type = friendTypeAdd;
                    model.title = obj;
                    model.icon = @"Action_Chat1";
                    [self.currentFriendsArray addObject:model];
                }
                [self.tableView reloadData];
            }else{
                //本地好友
                NSArray *userList = [[EMClient sharedClient].contactManager getContacts];
                for (NSString *obj in userList) {
                    FriendsModel *model = [[FriendsModel alloc] init];
                    model.type = friendTypeAdd;
                    model.title = obj;
                    model.icon = @"Action_Chat1";
                    [self.currentFriendsArray addObject:model];
                }
                [self.tableView reloadData];
            }
        }];
    
    }


/**
 *  更新申请好友信息数量
 */
- (void)showFindFriendsAndTabBarBadge
{
    self.tabBarItem.badgeValue = @"11";
}


/**
 *  导航条处理
 */
- (void)setUpNav
{
    UIImage *image = [UIImage imageNamed:@"barbuttonicon_add_cube"];
    //渲染
    //   image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(addFriend)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionIndexColor = [UIColor lightGrayColor];
//        self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    self.tableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = 50.f;
}

/**
 *  添加好友
 */
- (void)addFriend
{
    AddFriendViewController *addFriendVC = [[AddFriendViewController alloc] init];
    [self.navigationController pushViewController:addFriendVC animated:YES];
}


#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.topArray.count;
    }
    return self.currentFriendsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyFriendsTableViewCell *cell = [MyFriendsTableViewCell cellWithTableView:tableView];
    if (indexPath.section == 0) {
        cell.friendModel = self.topArray[indexPath.row];
        return cell;
    }else{
        MyFriendsTableViewCell *cell = [MyFriendsTableViewCell cellWithTableView:tableView];
        cell.friendModel = self.currentFriendsArray[indexPath.row];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section > 0) {
        
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

#pragma mark EMContactManagerDelegate

/*!
 *  \~chinese
 *  用户B同意用户A的加好友请求后，用户A会收到这个回调
 *
 *  @param aUsername   用户B
 */
- (void)friendRequestDidApproveByUser:(NSString *)aUsername{
    NSLog(@"同意了");
}

/*!
 *  \~chinese
 *  用户B拒绝用户A的加好友请求后，用户A会收到这个回调
 *
 *  @param aUsername   用户B
 */
- (void)friendRequestDidDeclineByUser:(NSString *)aUsername{
    NSLog(@"我被%@拒绝了",aUsername);
}

/*!
 *  \~chinese
 *  用户B删除与用户A的好友关系后，用户A会收到这个回调
 *
 *  @param aUsername   用户B
 */
- (void)friendshipDidRemoveByUser:(NSString *)aUsername{
    NSLog(@"这%@小婊砸竟然把我删除了",aUsername);
}

/*!
 *  \~chinese
 *  用户B同意用户A的好友申请后，用户A和用户B都会收到这个回调
 *
 *  @param aUsername   用户好友关系的另一方
 */
- (void)friendshipDidAddByUser:(NSString *)aUsername{
    NSLog(@"互为好友了");
    //重新获得好友信息
    [self getCurrentFriends];
}

/*!
 *  \~chinese
 *  用户B申请加A为好友后，用户A会收到这个回调
 *
 *  @param aUsername   用户B
 *  @param aMessage    好友邀请信息
 */
- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername
                                message:(NSString *)aMessage
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"用户%@想添加您为好友",aUsername] preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //同意加好友申请
        EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:aUsername];
        if (!error) {
            NSLog(@"发送同意成功");
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //拒绝加好友申请
        EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:aUsername];
        if (!error) {
            NSLog(@"发送拒绝成功");
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)dealloc
{
    //移除好友回调
    [[EMClient sharedClient].contactManager removeDelegate:self];
}

@end
