//
//  Settings1ViewController.h
//  DatingApp
//
//  Created by CrayonLabs on 8/13/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Settings1ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *m_;
@property (nonatomic,strong)IBOutlet UIBarButtonItem *leftBarButton;
@property (nonatomic,strong)IBOutlet UIBarButtonItem *rightBarButton;
@property (strong, nonatomic) IBOutlet UILabel *m_LabelCoinValues;
@property (strong, nonatomic) IBOutlet UILabel *m_LabelShowMe;

- (IBAction)buttonSearchSC:(id)sender;

- (IBAction)sliderCoinValue:(UISlider *)sender;

- (IBAction)buttonMyImages:(id)sender;

- (IBAction)switchRechange:(UISwitch *)sender;

- (IBAction)switchStranger:(UISwitch *)sender;
- (IBAction)switchFriendsOfFriends:(UISwitch *)sender;

@end
