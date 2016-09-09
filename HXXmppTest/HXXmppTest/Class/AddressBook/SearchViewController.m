//
//  SearchViewController.m
//  HXXmppTest
//
//  Created by winbei on 16/9/8.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "SearchViewController.h"
#import "MBProgressHUD.h"
@interface SearchViewController ()<UITextFieldDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray.count == 0) {
        return 1;
    }
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString static *cellId = @"resultCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.backgroundColor = [UIColor cyanColor];
        cell.imageView.image = [UIImage imageNamed:@"AlbumHeaderBackgrounImage"];
    }
    if (!self.dataArray.count) {
        cell.textLabel.text = @"没有查找到相应内容";
        cell.imageView.image = nil;
    }else{
        cell.textLabel.text = self.dataArray[indexPath.row];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.dataArray.count<=0)return;
    //不能添加自己为好友
    if ([_dataArray[indexPath.row] isEqualToString:[EMClient sharedClient].currentUsername]) {
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"不能添加自己为好友！" preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertView animated:YES completion:nil];
    }else{
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"说点什么吧~" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"说点什么吧~";
            textField.delegate = self;
        }];
        [alertView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertView addAction:[UIAlertAction actionWithTitle:@"发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //请求
            UITextField *saySomeThingTextField = alertView.textFields.firstObject;
            NSString *saySomeThingStr = saySomeThingTextField.text;
            //发送加好友请求
            EMError *error = [[EMClient sharedClient].contactManager addContact:_dataArray[indexPath.row] message:saySomeThingStr];
            if (!error) {
                 MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.label.text = @"发送成功";
                [hud hideAnimated:YES afterDelay:kDelayTime];
            }
    
        }]];
        [self presentViewController:alertView animated:YES completion:nil];
    }
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

@end
