//
//  ViewController.h
//  DatingApp
//
//  Created by CrayonLabs on 16/07/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>


@interface LoginViewController : UIViewController <FBLoginViewDelegate>
{
}

@property (nonatomic,strong)IBOutlet UIButton *buttonFacebookLogin;
@property (strong, nonatomic) IBOutlet UIButton *b_backToHome;
- (IBAction)backToHome:(id)sender;

-(IBAction)facebookLoginTapped:(id)sender;
- (IBAction)facebookLogoutTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *m_buttonSignOut;
@property (strong, nonatomic) IBOutlet UIButton *m_buttonLogin;
@property (assign, nonatomic) BOOL isHomeView;
@property (strong, nonatomic) NSString *latitudeLabel;
@property (strong, nonatomic) NSString *longitudeLabel;
@property (strong, nonatomic) NSString *addressLabel;
- (IBAction)getCurrentLocation:(id)sender;

@end
