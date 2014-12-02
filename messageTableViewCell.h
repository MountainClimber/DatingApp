//
//  messageTableViewCell.h
//  DatingApp
//
//  Created by CrayonLabs on 8/20/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface messageTableViewCell : UITableViewCell
{
    UILabel *senderAndTimeLabel;
    UITextView *messageContentView;
    UIImageView *bgImageView;
}

@property (nonatomic,assign) UILabel *senderAndTimeLabel1;
@property (nonatomic,assign) UITextView *messageContentView1;
@property (nonatomic,assign) UIImageView *bgImageView1;


@end
