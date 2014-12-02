//
//  ProfileViewController.m
//  DatingApp
//
//  Created by CrayonLabs on 16/07/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import "ProfileViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MBProgressHUD.h"
#import <Parse/Parse.h>
#import "SettingsViewController.h"
#import "LoginViewController.h"
#import "ImageViewController.h"
#import "HomeViewController.h"
@interface ProfileViewController ()

@property(assign,nonatomic) NSMutableArray *m_ArrFriends;
@property (assign,nonatomic) NSString *num;
@property (strong,nonatomic) NSNumber *num2;
@property(retain,nonatomic) NSNumber *total;
@property(assign,nonatomic) NSArray *postArray;
@property (strong,nonatomic) NSNumber *numr;
@property (strong,nonatomic) NSString *userNumber;
@property (strong ,nonatomic) UIImage * imageFile;
@property(strong,nonatomic) NSString * m_id;
@end

@implementation ProfileViewController
//@synthesize m_userID;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad

{
    [super viewDidLoad];
    
    _imageViewProfile.layer.cornerRadius= _imageViewProfile.frame.size.height/ 1.2;
    _imageViewProfile.layer.cornerRadius= _imageViewProfile.frame.size.width/ 1.2;
    _imageViewProfile.layer.cornerRadius= 90;
    _imageViewProfile.clipsToBounds = YES;
    self.navigationItem.title = @"Profile";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"red srtripe.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
    [NSDictionary dictionaryWithObjectsAndKeys:
    [UIFont fontWithName:@"Verdana" size:20],
    NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    
//    UIImage* image3 = [UIImage imageNamed:@"arrow.png"];
//    CGRect frameimg = CGRectMake(0, 0, image3.size.width, image3.size.height);
//    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
//    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
//    [someButton addTarget:self action:@selector(pressedLeftBarButton:)
//         forControlEvents:UIControlEventTouchUpInside];
//    someButton.layer.cornerRadius=5.0f;
//    [someButton setShowsTouchWhenHighlighted:YES];
//    _leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
//    self.navigationItem.leftBarButtonItem=_leftBarButton;
    
    UIImage* image32 = [UIImage imageNamed:@"settingsButton.png"];
    CGRect frameimg2 = CGRectMake(0, 0, image32.size.width, image32.size.height);
    UIButton *someButton2 = [[UIButton alloc] initWithFrame:frameimg2];
    [someButton2 setBackgroundImage:image32 forState:UIControlStateNormal];
    [someButton2 addTarget:self action:@selector(pressedRightBarButton:)
          forControlEvents:UIControlEventTouchUpInside];
    someButton2.layer.cornerRadius=5.0f;
    [someButton2 setShowsTouchWhenHighlighted:YES];
    _rightBarButton =[[UIBarButtonItem alloc] initWithCustomView:someButton2];
    self.navigationItem.rightBarButtonItem=_rightBarButton;
    _strFBid=[[NSString alloc]init];
    _strFBuserName=[[NSString alloc]init];
    _strUserAge=[[NSString alloc]init];
    
    if ([_strFBid length]==0)
    {
        if (_isMutualView==NO) {
            
        
        
        // FBRequest *request =[FBRequest  requestForCustomAudienceThirdPartyID:[PFFacebookUtils session]];
        MBProgressHUD *view =[MBProgressHUD  showHUDAddedTo:self.view animated:YES];
        [view  setLabelText:@"Getting Profile"];
        NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
        NSString *userID=[defaults objectForKey:@"mainUserID"];
// _currentUserFbID = userID;
        NSLog(@"first try for user ID %@",_currentUserFbID);
            
            _m_id=userID;
            
        PFQuery *query = [PFQuery queryWithClassName:@"userData"];
        [query whereKey:@"facebookID" equalTo:userID];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
        for (PFObject * userInfo in objects)
        {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSString *username = [userInfo objectForKey:@"name"];
        NSString *userbirthday = [userInfo objectForKey:@"age"];
        // NSString *userlike = [userInfo objectForKey:@"nooflikesonpic"];
        NSString *userfriendsList = [userInfo objectForKey:@"nooffriend"];
        NSString *userimage=[userInfo objectForKey:@"profilepic"];
        NSString *CoinValue=[userInfo objectForKey:@"CoinValue"];
//                             PFFile *userImage=[userInfo objectForKey:@"upLoadImage"];
//                             
//                             [userImage getDataInBackgroundWithBlock:^(NSData *result, NSError *error) {
//                                 if (!error) {
//                                     UIImage *image = [UIImage imageWithData:result];
//                                     
//                                     _imageFile=image;
//                                 }
//                             }];
        NSString *userCoins=[userInfo objectForKey:@"noOfcoins"];
        UIImage *im = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:userimage]]];
        // NSURL *url = [[NSURL alloc] initWithString:userimage];
        NSLog(@"%@ friends list",userfriendsList);
        _lableName.text=username;
        _labelLike.text=[NSString stringWithFormat:@"%@",userfriendsList];
        _labelFriends.text=CoinValue;
        _imageViewProfile.image=im;
        _labelPhotos.text=userCoins;
        NSLog(@"%@hfg",userbirthday);
        NSString *birthDate = userbirthday;
        NSDate *todayDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:birthDate]];
        int allDays = (((time/60)/60)/24);
        int days = allDays%365;
        int years = (allDays-days)/365;
        NSLog(@"You live since %i years and %i days",years,days);
            if (years<=18) {
                _lableAge.text=[NSString stringWithFormat:@" Private"];
            }
            else
            {
                _lableAge.text=[NSString stringWithFormat:@"   %i years",years];
            }

        }
        }
        }];
        
          //[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    }
    else if(_isHomeView==NO )
    {
        MBProgressHUD *view =[MBProgressHUD  showHUDAddedTo:self.view animated:YES];
        [view  setLabelText:@"Getting Profile"];

//        NSLog(@"%@",_m_userMutualID);
        _m_id=_m_userMutualID;
        PFQuery *query = [PFQuery queryWithClassName:@"userData"];
        [query whereKey:@"facebookID" equalTo:_m_userMutualID];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error)
            {
                for (PFObject * userInfo in objects)
                {
                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    NSString *username = [userInfo objectForKey:@"name"];
                    NSString *userbirthday = [userInfo objectForKey:@"age"];
                    // NSString *userlike = [userInfo objectForKey:@"nooflikesonpic"];
                    NSString *userfriendsList = [userInfo objectForKey:@"nooffriend"];
                    NSString *userimage=[userInfo objectForKey:@"profilepic"];
                    NSString *CoinValue=[userInfo objectForKey:@"CoinValue"];
                    //                             PFFile *userImage=[userInfo objectForKey:@"upLoadImage"];
                    //
                    //                             [userImage getDataInBackgroundWithBlock:^(NSData *result, NSError *error) {
                    //                                 if (!error) {
                    //                                     UIImage *image = [UIImage imageWithData:result];
                    //
                    //                                     _imageFile=image;
                    //                                 }
                    //                             }];
                    NSString *userCoins=[userInfo objectForKey:@"noOfcoins"];
                    UIImage *im = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:userimage]]];
                    // NSURL *url = [[NSURL alloc] initWithString:userimage];
                    NSLog(@"%@ friends list",userfriendsList);
                    _lableName.text=username;
                    _labelLike.text=[NSString stringWithFormat:@"%@",userfriendsList];
                    _labelFriends.text=CoinValue;
                    _imageViewProfile.image=im;
                    _labelPhotos.text=userCoins;
                    NSLog(@"%@hfg",userbirthday);
                    NSString *birthDate = userbirthday;
                    NSDate *todayDate = [NSDate date];
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
                    int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:birthDate]];
                    int allDays = (((time/60)/60)/24);
                    int days = allDays%365;
                    int years = (allDays-days)/365;
                    NSLog(@"You live since %i years and %i days",years,days);
                    if (years<=18) {
                        
                    }
                    else
                    {
                    _lableAge.text=[NSString stringWithFormat:@"   %i years",years];
                    }
                    }
            }
        }];
    }
    }
//    else
//    {
//        NSLog(@"jkhxbckjv");
//    }
    PFQuery *querye = [PFQuery queryWithClassName:@"userData"];
    [querye findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            _userNumber=[NSString stringWithFormat:@"%lu",(unsigned long)objects.count];
            NSLog(@"%@",_userNumber);
        }
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(getData)
                                   userInfo:nil
                                    repeats:YES];
    

    }
    
-(void)getData
{
    
    
    if ([_strFBid length]==0)
    {
        if (_isMutualView==NO) {
            
            
            
            // FBRequest *request =[FBRequest  requestForCustomAudienceThirdPartyID:[PFFacebookUtils session]];
           
            NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
            NSString *userID=[defaults objectForKey:@"mainUserID"];
            // _currentUserFbID = userID;
            
            _m_id=userID;
            
            PFQuery *query = [PFQuery queryWithClassName:@"userData"];
            [query whereKey:@"facebookID" equalTo:userID];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error)
                {
                    for (PFObject * userInfo in objects)
                    {
                                               NSString *username = [userInfo objectForKey:@"name"];
                        NSString *userbirthday = [userInfo objectForKey:@"age"];
                        // NSString *userlike = [userInfo objectForKey:@"nooflikesonpic"];
                        NSString *userfriendsList = [userInfo objectForKey:@"nooffriend"];
                        NSString *userimage=[userInfo objectForKey:@"profilepic"];
                        NSString *CoinValue=[userInfo objectForKey:@"CoinValue"];
                        //                             PFFile *userImage=[userInfo objectForKey:@"upLoadImage"];
                        //
                        //                             [userImage getDataInBackgroundWithBlock:^(NSData *result, NSError *error) {
                        //                                 if (!error) {
                        //                                     UIImage *image = [UIImage imageWithData:result];
                        //
                        //                                     _imageFile=image;
                        //                                 }
                        //                             }];
                        NSString *userCoins=[userInfo objectForKey:@"noOfcoins"];
                        UIImage *im = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:userimage]]];
                        // NSURL *url = [[NSURL alloc] initWithString:userimage];
                       
                        _lableName.text=username;
                        _labelLike.text=[NSString stringWithFormat:@"%@",userfriendsList];
                        _labelFriends.text=CoinValue;
                        _imageViewProfile.image=im;
                        _labelPhotos.text=userCoins;
                       
                        NSString *birthDate = userbirthday;
                        NSDate *todayDate = [NSDate date];
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
                        int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:birthDate]];
                        int allDays = (((time/60)/60)/24);
                        int days = allDays%365;
                        int years = (allDays-days)/365;
                      
                        if (years<=18) {
                            _lableAge.text=[NSString stringWithFormat:@" Private"];
                        }
                        else
                        {
                            _lableAge.text=[NSString stringWithFormat:@"   %i years",years];
                        }
                        
                    }
                }
            }];
            
            //[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
        }
        else if(_isHomeView==NO )
        {
            
           
            _m_id=_m_userMutualID;
            PFQuery *query = [PFQuery queryWithClassName:@"userData"];
            [query whereKey:@"facebookID" equalTo:_m_userMutualID];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error)
                {
                    for (PFObject * userInfo in objects)
                    {
                        NSString *username = [userInfo objectForKey:@"name"];
                        NSString *userbirthday = [userInfo objectForKey:@"age"];
                        // NSString *userlike = [userInfo objectForKey:@"nooflikesonpic"];
                        NSString *userfriendsList = [userInfo objectForKey:@"nooffriend"];
                        NSString *userimage=[userInfo objectForKey:@"profilepic"];
                        NSString *CoinValue=[userInfo objectForKey:@"CoinValue"];
                        //                             PFFile *userImage=[userInfo objectForKey:@"upLoadImage"];
                        //
                        //                             [userImage getDataInBackgroundWithBlock:^(NSData *result, NSError *error) {
                        //                                 if (!error) {
                        //                                     UIImage *image = [UIImage imageWithData:result];
                        //
                        //                                     _imageFile=image;
                        //                                 }
                        //                             }];
                        NSString *userCoins=[userInfo objectForKey:@"noOfcoins"];
                        UIImage *im = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:userimage]]];
                        // NSURL *url = [[NSURL alloc] initWithString:userimage];
                       
                        _lableName.text=username;
                        _labelLike.text=[NSString stringWithFormat:@"%@",userfriendsList];
                        _labelFriends.text=CoinValue;
                        _imageViewProfile.image=im;
                        _labelPhotos.text=userCoins;
                    
                        NSString *birthDate = userbirthday;
                        NSDate *todayDate = [NSDate date];
                        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
                        int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:birthDate]];
                        int allDays = (((time/60)/60)/24);
                        int days = allDays%365;
                        int years = (allDays-days)/365;
                     
                        if (years<=18) {
                            
                        }
                        else
                        {
                            _lableAge.text=[NSString stringWithFormat:@"   %i years",years];
                        }
                    }
                }
            }];
        }
    }

}

-(IBAction)backgroundTap:(id)sender
{
    [_view_comment resignFirstResponder];
    //[self.erField resignFirstResponder];
}

-(void)getFacebookUserInfo
{
    
}

//-(IBAction)pressedLeftBarButton:(id)sender
//{
//    HomeViewController *hvc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
//    [self.navigationController pushViewController:hvc animated:YES];
//    
//}
-(IBAction)pressedRightBarButton:(id)sender
{
        SettingsViewController *svc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"settingsView"];
        [self.navigationController pushViewController:svc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonLikeME:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Help" message:@"Number Of Friends on Facebook" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)coinButton:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Help" message:@"Number Of Coins I Have" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)ShowFriendsButton:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Help" message:@"My Coin Value" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)b_ImageView:(id)sender {
    ImageViewController *ivc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil]
                              instantiateViewControllerWithIdentifier:@"ImageViewController"];
    ivc.isHomeView=YES;
    ivc.isMutualView=NO;
    ivc.isSettingView=NO;
    ivc.isMutHomeView=NO;
    ivc.isDeleteView=_isDeleteView;
    ivc.m_userMutualID=_m_id;
    [self.navigationController pushViewController:ivc animated:YES];
    
    
    
   // _imageViewProfile.image=_selectedImage.image;
    
    
}
 @end
