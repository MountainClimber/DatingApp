//
//  AppDelegate.h
//  DatingApp
//
//  Created by CrayonLabs on 16/07/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MutiualFriendViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MutiualFriendViewController *MutiualFriendViewController;
@property (strong,nonatomic) NSString* m_deviceToken;
@property (strong, nonatomic) NSDictionary *refererAppLink;
@end
