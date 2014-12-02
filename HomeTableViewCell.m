//
//  HomeTableViewCell.m
//  DatingApp
//
//  Created by CrayonLabs on 8/13/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super   initWithFrame:frame];
    
    if (self)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:self options:nil];
        self = [nib objectAtIndex:0];
    }
    
    return self;
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
