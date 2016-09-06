//
//  LogAndRegistViewController.m
//  HXXmppTest
//
//  Created by winbei on 16/9/1.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "LogAndRegistViewController.h"
#import "MBProgressHUD.h"
#import "MainTabBarController.h"
@interface LogAndRegistViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWardTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation LogAndRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _userNameTextField.text = @"hzmmzl";
    _passWardTextField.text = @"111111";
}

/**
 *  登录
 *
 *  @param sender <#sender description#>
 */
- (IBAction)loginButtonClicked:(UIButton *)sender {
    [[EMClient sharedClient] loginWithUsername:_userNameTextField.text password:_passWardTextField.text completion:^(NSString *aUsername, EMError *aError) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if (aError) {//失败
            hud.label.text = @"登录失败";
        }else{//成功
            hud.label.text = @"登录成功";
            KEYWindow.rootViewController = [[MainTabBarController alloc] init];
        }
        [hud hideAnimated:YES afterDelay:kDelayTime];
    }];
    
    
}

/**
 *  注册
 *
 *  @param sender <#sender description#>
 */
- (IBAction)registerButtonClicked:(UIButton *)sender {
    if (!_userNameTextField.text.length || !_passWardTextField.text.length) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.text = @"请输入用户名或密码";
        [hud hideAnimated:YES afterDelay:kDelayTime];
        return;
    }
    
   EMError *error = [[EMClient sharedClient] registerWithUsername:_userNameTextField.text password:_passWardTextField.text];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (error) {
        hud.label.text = @"注册失败";
        NSLog(@"%@",error.errorDescription);
    }else{
        hud.label.text = @"注册成功";
    }
    [hud hideAnimated:YES afterDelay:kDelayTime];
}

@end
