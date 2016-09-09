//
//  AddressViewController.m
//  HXXmppTest
//
//  Created by winbei on 16/9/6.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "AddressViewController.h"
#import "AddFriendViewController.h"
@interface AddressViewController ()

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"barbuttonicon_add_cube"];
    //渲染
//   image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(addFriend)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

/**
 *  添加好友
 */
- (void)addFriend
{
//    NSLog(@"添加好友");
    AddFriendViewController *addFriendVC = [[AddFriendViewController alloc] init];
    [self.navigationController pushViewController:addFriendVC animated:YES];
}
@end
