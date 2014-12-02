//
//  SPHBubbleCell.m
//  ChatBubble
//
//  Created by ivmac on 10/2/13.
//  Copyright (c) 2013 Conciergist. All rights reserved.
//

#import "SPHBubbleCell.h"

@implementation SPHBubbleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (IBAction)findMessanger:(id)sender {
//    
////    if (_findMessangepic.selected==YES) {
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Find Messanger" message:@"To Find Messanger You Have To Spend 3 coins " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
//        [alert show];
////    }
//    
//}
@end
