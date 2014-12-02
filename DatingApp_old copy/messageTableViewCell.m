//
//  messageTableViewCell.m
//  DatingApp
//
//  Created by CrayonLabs on 8/20/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import "messageTableViewCell.h"

@implementation messageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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
