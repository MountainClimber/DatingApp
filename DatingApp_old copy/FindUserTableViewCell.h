//
//  FindUserTableViewCell.h
//  DatingApp
//
//  Created by CrayonLabs on 11/1/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@protocol FindUserTableViewCellDelegate;

@interface FindUserTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *m_labelName;
@property (strong, nonatomic) IBOutlet UILabel *m_labelGender;
@property (strong, nonatomic) IBOutlet UIImageView *m_ImageUse;
@property (assign, nonatomic)id<FindUserTableViewCellDelegate>theDelegate;

@end
@protocol YourFriendTableViewCellDelegate

-(void)methodAskCalledFromCell:(FindUserTableViewCell*)cell withSender:(UIButton*)sender;

@end

