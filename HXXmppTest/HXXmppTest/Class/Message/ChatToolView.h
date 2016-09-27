//
//  ChatToolView.h
//  HXXmppTest
//
//  Created by winbei on 16/9/13.
//  Copyright © 2016年 winbei. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    ButtonTypeKeyBoard,
    ButtonTypeYuYin,
    ButtonTypePhoto,
    ButtonTypeBiaoQin
}ButtonType;

/**
 *  发送的数据类型，文本，录音，视频，图片
 */
typedef enum{
    SendMessageTypeMessage,
    SendMessageTypeVoice,
    SendMessageTypeVido,
    SendMessageTypePhoto,
}SendMessageType;

typedef void (^ToolButtonClickBlock)(UIButton *,ButtonType type);
typedef void (^ToolTextViewSend)(UITextView *textView,SendMessageType type);
@interface ChatToolView : UIView
@property (nonatomic , assign) ButtonType buttonType;
@property (nonatomic , assign) SendMessageType sendMessageType;
//block
@property (nonatomic , copy)  ToolButtonClickBlock toolButtonBlock;
@property (nonatomic , copy) ToolTextViewSend textViewSendBlock;
@end
