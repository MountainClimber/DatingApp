//
//  messageListTableViewCell.h
//  DatingApp
//
//  Created by CrayonLabs on 8/29/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol messageListTableViewCellDelegate;

@interface messageListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *m_ImageView_Messangerpic;
@property (strong, nonatomic) IBOutlet UILabel *m_LabelChatTime;
@property (strong, nonatomic) IBOutlet UILabel *m_LabelMessangerName;
@property (strong, nonatomic) IBOutlet UILabel *m_LabelID;

@property (assign, nonatomic)id<messageListTableViewCellDelegate>theDelegate;

@end
@protocol YourFriendTableViewCellDelegate

-(void)methodAskCalledFromCell:(messageListTableViewCell*)cell withSender:(UIButton*)sender;

@end