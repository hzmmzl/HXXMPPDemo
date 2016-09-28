//
//  WeChatViewController.m
//  HXXmppTest
//
//  Created by winbei on 16/9/14.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import "WeChatViewController.h"
#import "ChatToolView.h"
#import "WeChatFrameModel.h"
#import "WeChatTableViewCell.h"
#define kToolHeight 40
@interface WeChatViewController ()<UITableViewDelegate,UITableViewDataSource,EMClientDelegate,EMContactManagerDelegate,EMChatManagerDelegate>
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
    [self getCurrentChatMessages];
    
}

/**
 *  获取当前聊天列表
 */
- (void)getCurrentChatMessages
{
    //设置代理
    //消息，聊天
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    //联系人模块代理
    //    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    //消息，聊天
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
//    EMConversation
    NSArray *array = [conversations sortedArrayUsingComparator:
                          ^(EMConversation *obj1, EMConversation* obj2){
                              EMMessage *message1 = [obj1 latestMessage];
                              EMMessage *message2 = [obj2 latestMessage];
                              if(message1.timestamp > message2.timestamp) {
                                  return(NSComparisonResult)NSOrderedAscending;
                              }else {
                                  return(NSComparisonResult)NSOrderedDescending;
                              }
                          }];
    //转换成frame模型
    for (EMConversation *obj in array) {
        EMMessage *message = obj.latestMessage;
        WeChatFrameModel *frameModel = [[WeChatFrameModel alloc] init];
        frameModel.message = message;
        [self.dataMessageArray addObject:frameModel];
    }
    
    [self.tableView reloadData];

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
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    __block typeof(self)weakSelf = self;
    _chatToolView.textViewSendBlock = ^(UITextView *textView,SendMessageType type){
        if (type == SendMessageTypeMessage) {//文本
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
//                // 收到的文字消息
//                EMMessageBody *msgBody = message.body;
//                //转成这种消息
//                EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
//                NSString *txt = textBody.text;
//                NSLog(@"收到的文字是 txt -- %@",txt);
                WeChatFrameModel *frameModel = [[WeChatFrameModel alloc] init];
                frameModel.message = message;
                [weakSelf.dataMessageArray addObject:frameModel];
                [weakSelf.tableView reloadData];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataMessageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeChatTableViewCell *cell = [WeChatTableViewCell cellWithTableView:tableView];
    cell.frameModel = self.dataMessageArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((WeChatFrameModel *)self.dataMessageArray[indexPath.row]).cellHeight;
}

#pragma mark UIScrollView
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[EMClient sharedClient].chatManager removeDelegate:self];
    [[EMClient sharedClient] removeDelegate:self];
}

#pragma mark EMChatManagerDelegate
/*!
 *  \~chinese
 *  会话列表发生变化
 *  @param aConversationList  会话列表<EMConversation>
 *  @param aConversationList  Conversation list<EMConversation>
 */
- (void)conversationListDidUpdate:(NSArray *)aConversationList
{
    
}

@end
