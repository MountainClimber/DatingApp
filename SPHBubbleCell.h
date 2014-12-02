//
//  SPHBubbleCell.h
//  ChatBubble
//
//  Created by ivmac on 10/2/13.
//  Copyright (c) 2013 Conciergist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPHBubbleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *Avatar_Image;

@property (weak, nonatomic) IBOutlet UILabel *time_Label;
//- (IBAction)findMessanger:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *findMessangepic;
@property (strong, nonatomic) IBOutlet UILabel *m_messangerName;

@end
