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
@property (nonatomic , strong) NSMutableArray *dataMessageArray;
@end

@implementation WeChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    [self setUpBottomToolView];
    [self keyBoardNotification];
    
}

/**
 *  获取当前聊天列表
 */
- (void)getCurrentChatMessages
{
    
}

/**
 *键盘通知
 */
- (void)keyBoardNotification
{//_chatToolView.textView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

/**
 *  设置tableview
 */

- (void)setUpTableView
{
    self.title = _chatFriendName;
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
    
    //点击发送按钮发送消息
    NSString *to = _chatFriendName;
    _chatToolView.textViewSendBlock = ^(UITextView *textView,SendMessageType type){
        if (type == SendMessageTypeMessage) {
            EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:textView.text];
            NSString *from = [[EMClient sharedClient] currentUsername];
            //生成MessageEMMessageBody
            EMMessage *message = [[EMMessage alloc] initWithConversationID:to from:from to:to body:body ext:nil];
            message.chatType = EMChatTypeChat;// 设置为单聊消息
            //message.chatType = EMChatTypeGroupChat;// 设置为群聊消息
            //message.chatType = EMChatTypeChatRoom;// 设置为聊天室消息
//            [[EMClient sharedClient].chatManager sendMessageReadAck:message completion:^(EMMessage *aMessage, EMError *aError) {
//                NSLog(@"发送完成");
//                NSLog(@"message = %@",aMessage);
//            }];
            [[EMClient sharedClient].chatManager sendMessage:message progress:^(int progress) {
                
            } completion:^(EMMessage *message, EMError *error) {
                NSLog(@"发送完成");
                NSLog(@"message = %@",message);
            }];
        }
    };
}

/**
 *  键盘通知
 */
- (void)keyBoardFrameChange:(NSNotification *)notification
{
//    NSLog(@"=====notify.object = %@,notify.userInfo = %@,notify = %@",notify.object,notify.userInfo,notify);
    //时间
//    UIKeyboardAnimationDurationUserInfoKey
    //最终frame
//    UIKeyboardFrameEndUserInfoKey
    //开始frame
//    UIKeyboardFrameBeginUserInfoKey
    
    NSLog(@"notify = %@",notification.userInfo);
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;
    
    CGRect inputFieldRect = self.chatToolView.frame;
    
    inputFieldRect.origin.y += yOffset;
    
    [UIView animateWithDuration:duration animations:^{
        self.chatToolView.frame = inputFieldRect;
    }];
}
#pragma mark ---lazy
- (NSMutableArray *)dataMessageArray
{
    if (!_dataMessageArray) {
        _dataMessageArray = [NSMutableArray array];
    }
    return _dataMessageArray;
}

#pragma mark ---UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
