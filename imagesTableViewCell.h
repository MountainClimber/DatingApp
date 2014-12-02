//
//  imagesTableViewCell.h
//  DatingApp
//
//  Created by CrayonLabs on 10/22/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol imagesTableViewCellDelegate;
@interface imagesTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *m_imageView;
- (IBAction)b_imageButton:(id)sender;

@property (assign, nonatomic)id<imagesTableViewCellDelegate>theDelegate;
@property (strong, nonatomic) IBOutlet UIButton *b;

@end
@protocol YourFriendTableViewCellDelegate

-(void)methodAskCalledFromCell:(imagesTableViewCell*)cell withSender:(UIButton*)sender;

@end