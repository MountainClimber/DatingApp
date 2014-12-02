//
//  YourFriendTableViewCell.h
//  DatingApp
//
//  Created by CrayonLabs on 8/13/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YourFriendTableViewCellDelegate;

@interface YourFriendTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *m_LabelTitleName;
@property (strong, nonatomic) IBOutlet UILabel *m_LabelTitleDes;
@property (strong, nonatomic) IBOutlet UIButton *m_ButtonAsk;
@property (strong, nonatomic) IBOutlet UIImageView *m_ImageView;

@property (assign, nonatomic)id<YourFriendTableViewCellDelegate>theDelegate;

- (IBAction)actionAskPress:(id)sender;

@end

@protocol YourFriendTableViewCellDelegate

-(void)methodAskCalledFromCell:(YourFriendTableViewCell*)cell withSender:(UIButton*)sender;

@end

