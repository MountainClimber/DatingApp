//
//  MutiualFriendViewController.h
//  DatingApp
//
//  Created by CrayonLabs on 8/15/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MutiualFriendViewController : UIViewController
@property (assign, nonatomic) IBOutlet UIImageView *m_ImageFriends;
@property (strong, nonatomic) IBOutlet UILabel *m_LabelFriendName;
@property (strong, nonatomic) NSObject * friendsRelation;
@property (strong, nonatomic) IBOutlet UILabel *m_BirthdayFriend;
@property (strong, nonatomic) IBOutlet UILabel *m_mutualFriendsList;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *leftBarButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *rightBarButton;
- (IBAction)buttonFriendsOfFriends:(id)sender;
@property (strong,nonatomic) NSString * m_iduser;
@property (strong,nonatomic) NSString * m_nameFriend;
@property (strong,nonatomic) NSString *m_DOBFriend;
@property (strong,nonatomic) UIImage *m_ImageFriend;
@property (strong, nonatomic) IBOutlet UIButton *m_ButtonLike;
@property (strong,nonatomic) NSObject *m_ObjectDate;
- (IBAction)ButtonLikes:(id)sender;
- (IBAction)buttonRequestChat:(id)sender;
- (IBAction)buttonFaceBook:(id)sender;
- (IBAction)userProfile:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *m_userProfile;

@property (assign,nonatomic) BOOL isAssignView;
@property (assign,nonatomic) BOOL isDeleteView;

- (IBAction)requestButtonClicked:(id)sender;

@end
