//
//  ProfileViewController.h
//  DatingApp
//
//  Created by CrayonLabs on 16/07/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ProfileViewController : UIViewController
{
    
    int intAge;
}
@property (strong,nonatomic) NSString * m_userMutualID;
@property (strong,nonatomic) NSString * m_userID;
@property (strong,nonatomic) NSString * username;
@property (nonatomic,strong)IBOutlet UIBarButtonItem *leftBarButton;
@property (nonatomic,strong)IBOutlet UIBarButtonItem *rightBarButton;
@property (nonatomic,strong)IBOutlet UIImageView *imageViewProfile;
@property (nonatomic,strong)IBOutlet UIImageView *imageViewBckGround;
@property (nonatomic,strong)NSString *strFBid;
@property (nonatomic,strong)NSString *strFBuserName;
@property (nonatomic,strong)NSString *strUserAge;
@property (nonatomic,strong)IBOutlet UILabel *lableName;
@property (nonatomic,strong)IBOutlet UILabel *lableAge;
@property(strong,nonatomic)NSString * imagest;
@property (strong, nonatomic) IBOutlet UILabel *labelLike;
@property (strong, nonatomic) IBOutlet UILabel *labelFriends;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *labelPhotos;
@property (strong , nonatomic) UIImageView *selectedImage;
@property (strong, nonatomic) IBOutlet UIButton *m_ImageView;
@property (assign, nonatomic) BOOL*isHomeView;
@property (assign, nonatomic) BOOL*isMutualView;
@property (assign,nonatomic) BOOL isDeleteView;

@property(strong,nonatomic) NSString * currentUserFbID;
- (IBAction)buttonLikeME:(id)sender;
- (IBAction)coinButton:(id)sender;
- (IBAction)ShowFriendsButton:(id)sender;

- (IBAction)b_ImageView:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *buttonLike;

@property (strong, nonatomic) IBOutlet UITextView *view_comment;
@property (strong,nonatomic) NSString *viewComment;
@property (strong,nonatomic) NSString *noofcomment;
@property NSInteger *inits;

@end
