                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   //
//  ViewController.m
//  DatingApp
//
//  Created by CrayonLabs on 16/07/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "ProfileViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MBProgressHUD.h"
#import <Parse/Parse.h>
#import "SettingsViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>



@interface LoginViewController ()<CLLocationManagerDelegate>
{
    //AVPlayer *player;
    CLLocationManager *locationManager;

}

@property (strong,nonatomic) NSString *objectID;
@property (strong,nonatomic) NSString *userID;
@property (strong,nonatomic) NSString *numberoff;
@property (strong,nonatomic) NSString *numberoffiends;
@property (strong,nonatomic) NSString *facebookID;
@property (strong,nonatomic) AVPlayer *player;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    
    NSString *str=[[NSBundle mainBundle] pathForResource:@"041057182-friends-being-silly-street" ofType:@"mp4"];
    NSURL *url=[NSURL fileURLWithPath:str];
    _player= [[AVPlayer alloc] init];
    _player = [_player initWithURL:url];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    [playerLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    [[[self view] layer] insertSublayer:playerLayer atIndex:3];
    [playerLayer setFrame:self.view.bounds];
    [_player play];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:[_player currentItem]];

    
    self.navigationItem.title = @"Log Out";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"red srtripe.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
    [NSDictionary dictionaryWithObjectsAndKeys:
    [UIFont fontWithName:@"Verdana" size:20],
    NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    [super viewDidLoad];
    // Check if user is cached and linked to Facebook, if so, bypass login
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]])
    {
        HomeViewController *m_HomeViewController;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            m_HomeViewController = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil]instantiateViewControllerWithIdentifier:@"HomeViewController"];
        }
        else
        {
            m_HomeViewController = [[UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil]instantiateViewControllerWithIdentifier:@"HomeViewController"];
        }
        [self.navigationController pushViewController:m_HomeViewController animated:NO];
    }
    FBLoginView *loginview = [[FBLoginView alloc] init];
    
    loginview.frame = CGRectOffset(loginview.frame, 5, 5);
#ifdef __IPHONE_7_0
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        loginview.frame = CGRectOffset(loginview.frame, 50, 25);
    }
#endif
#endif
#endif
    loginview.delegate = self;
    [self.view addSubview:loginview];
    [loginview sizeToFit];
   // self.navigationController.navigationBar.backgroundColor=[UIColor redColor];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    //[self performSelector:@selector(getCurrentLocation:)];
    
    // longitude and latitude
    
   // [self performSelector:@selector(getCurrentLocation)];
    
    
   
    [self.view  bringSubviewToFront:self.b_backToHome];
    
    
    
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    }
-(void)playerItemDidReachEnd:(NSNotification *)notification
{
  //  NSLog(@"%@ is obj",notification.object);
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];

    if (_player)
    {
        [_player    play];
    }
    
}

#pragma mark - CLLocationManagerDelegate
- (void)getCurrentLocation
{
    locationManager = [[CLLocationManager alloc] init];
    
    //Make this controller the delegate for the location manager.
    [locationManager setDelegate:self];
    
    //Set some parameters for the location object.
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
//    [locationManager    requestAlwaysAuthorization];
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    
    [locationManager startUpdatingLocation];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
     [self performSelector:@selector(loginViewShowingLoggedInUser:)];
    
}

- (void)locationManager:(CLLocationManager *)manager
       didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = locations[[locations count] -1];
    CLLocation *currentLocation = newLocation;
    _longitudeLabel = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
    _latitudeLabel = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    
    if (currentLocation != nil) {
//        NSLog(@"latitude: %@", _latitudeLabel);
//        NSLog(@"longitude: %@", _longitudeLabel);
              }else {
                  UIAlertView *errorAlert = [[UIAlertView alloc]
                                             initWithTitle:@"Error" message:@"Failed to Get Your Location"
                                             delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
                  [errorAlert show];
              }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    // first get the buttons set for login mode
    // "Post Status" available when logged on and potentially when logged off.  Differentiate in the label.
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user
{
    NSLog(@"%@==============%@",_latitudeLabel,_longitudeLabel);
   
   // CLLocation *locA = [[CLLocation alloc] initWithLatitude:_latitudeLabel longitude:_longitudeLabel];
    
    MBProgressHUD *view =[MBProgressHUD  showHUDAddedTo:self.view animated:YES];
    [view  setLabelText:@"Getting Data"];
    NSString *birthday;
    NSString *facebookID;
    NSString *name;
    NSString *gender;
    NSString *userName;
    // NSString *userAge;
    NSString *userId;
    NSString *userImage;
    NSString *location;
    NSString *ageYear;
     NSString* deviceToken;
    
    NSString * Longitude1=[NSString stringWithFormat:@"%d",0000];
    NSString * Latitude1=[NSString stringWithFormat:@"%d",0000];
     NSString* deviceToken1=[NSString stringWithFormat:@"Hide"];
    NSString *location1=[NSString stringWithFormat:@"Hide"];
    NSString *facebookID1=[NSString stringWithFormat:@"Hide"];
    NSString *name1=[NSString stringWithFormat:@"Hide"];
    NSString *gender1=[NSString stringWithFormat:@"Hide"];
    NSString *birthday1 =[NSString stringWithFormat:@"01/01/2000"];
    NSString *userName1=[NSString stringWithFormat:@"Hide"];
    // NSString *userAge;
    NSString *userId1=[NSString stringWithFormat:@"Hide"];
    NSString *userImage1=[NSString stringWithFormat:@"Hide"];
    NSLog(@"ujh%@",user);
    NSLog(@"user name  %@",[NSString stringWithFormat:@"Hello %@!", user.first_name]);
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    deviceToken =[defaults objectForKey:@"deviceToken"];
    
    if (user)
    {
    NSLog(@"User with facebook signed up and logged in!");
    // result is a dictionary with the user's Facebook data
    facebookID = user.id;
    name = user.name;
    userId=facebookID;
    gender = [user objectForKey:@"gender"];
        
    birthday = user.birthday;
    userName=user.username;
            NSLog(@"%@",birthday);
        NSString *facebookLocation = [[user objectForKey:@"location"] objectForKey:@"id"];
        NSString *facebookLocationname = [[user objectForKey:@"location"] objectForKey:@"name"];

        
        double  lat1=30.900965000000000000;
        double long1= 75.857275800000020000;
        
        double lat2= 28.635308000000000000;
        double long2 = 77.224960000000010000;
        
        CLLocation *location1 = [[CLLocation alloc] initWithLatitude:lat1 longitude:long1];
        CLLocation *location2 = [[CLLocation alloc] initWithLatitude:lat2 longitude:long2];
        NSLog(@"%@",location1);
        
        NSLog(@"Distance i kilometers: %f", [location1 distanceFromLocation:location2]/1000);
        [[PFUser currentUser] setObject:facebookLocation forKey:@"location"];
        NSLog(@"%@=========%@",_longitudeLabel,_latitudeLabel);
//      userImage=[user objectForKey:@"profilepic"];
    
        
      CLLocation*  locat=[[CLLocation alloc] initWithLatitude:[_latitudeLabel floatValue] longitude:[_longitudeLabel floatValue]];
        location=[NSString stringWithFormat:@"%@",locat];
        NSLog(@"%@",location);
        
    NSLog(@"%@",userImage);
        if (_latitudeLabel==nil) {
            _latitudeLabel=Latitude1;
            NSLog(@"%@",_latitudeLabel);
        }
        if (_longitudeLabel==nil) {
            _longitudeLabel=Longitude1;
            NSLog(@"%@",_longitudeLabel);
        }

        if (location==nil) {
            location=location1;
            NSLog(@"%@",location);
        }
        if (deviceToken==nil) {
            deviceToken=deviceToken1;
            NSLog(@"%@",deviceToken);
        }
        if (birthday==nil) {
            birthday=birthday1;
            NSLog(@"%@",birthday);
        }
        
        if (name==nil) {
            name=name1;
            NSLog(@"%@",name);
        }
        if (facebookID==nil) {
            facebookID=facebookID1;
            NSLog(@"%@",facebookID);
            _facebookID=facebookID;
        }
        if (userId==nil) {
            userId=userId1;
            NSLog(@"%@",userId);
        }
        if (gender==nil) {
            gender=gender1;
            NSLog(@"%@",gender);
        }
        if (userName==nil) {
            userName=userName1;
            NSLog(@"%@",userName);
        }
        if (userImage==nil) {
            userImage=userImage1;
            NSLog(@"%@",userImage);
        }
        userImage= [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",facebookID];
    
        NSDate *todayDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:birthday]];
        int allDays = (((time/60)/60)/24);
        int days = allDays%365;
        int years = (allDays-days)/365;
        NSLog(@"You live since %i years and %i days",years,days);
        ageYear=[NSString stringWithFormat:@"   %i years",years];

        NSString *querym =@"SELECT friend_count FROM user WHERE uid = me()";
//  Set up the query parameter
    NSDictionary *queryParam =
    [NSDictionary dictionaryWithObjectsAndKeys:querym, @"q", nil];
//  Make the API request that uses FQL
    [FBRequestConnection startWithGraphPath:@"/fql"
                                     parameters:queryParam
                                     HTTPMethod:@"GET"
                              completionHandler:^(FBRequestConnection *connection,
                                                  id result,
                                                  NSError *error)
     {
    if (error)
    {
        NSLog(@"Error: %@", [error localizedDescription]);
    }
    else
    {
    NSLog(@"Result: %@", result);
                                      // show result
    NSArray *friendInfo = (NSArray *) [result objectForKey:@"data"];
    NSLog(@"result=%@",[friendInfo objectAtIndex:0]);
    NSDictionary *friend_count =[friendInfo objectAtIndex:0];
    _numberoff= [friend_count objectForKey:@"friend_count"];
    NSLog(@"Result2: %@", _numberoff);
    }
    }];
    NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
    NSLog(@"%@ is name",name);
    NSLog(@"%@ is gender",gender);
    NSLog(@"%@ is birthday",birthday);
    NSLog(@"%@ is id",facebookID);
    NSLog(@"%@ is picture",pictureURL);
    // Now add the data to the UI elements
    // ...
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:facebookID forKey:@"mainUserID"];
    [defaults setObject:_objectID forKey:@"objectID"];
        [defaults setObject:location forKey:@"location"];
        [defaults setObject:_longitudeLabel forKey:@"userLongitude"];
        [defaults setObject:_latitudeLabel forKey:@"userLatitude"];
    [defaults synchronize];
    PFQuery *query=[PFQuery queryWithClassName:@"userData"];
    [query whereKey:@"facebookID" equalTo:facebookID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (!error)
    {
    if (objects.count>0)
    {
        
      
        
     NSString * userGender;
          NSString * userSetGender;
     NSString * userSearchDistance;
     NSString *userShowAges;
     NSString *userEthnicities;
     NSString *userSchoolCollage;
     NSString *userCoinValue;
     NSString *userRechargeCoins;
     NSString *userShowme;
     NSString *userStranger;
     NSString *userFriendesOfFriendes;
     PFFile *myImage;
     NSString *userCoins;
     for (PFObject *object in objects) {
     NSLog(@"%@", object.objectId);
     userCoins = [object objectForKey:@"noOfcoins"];
     userGender = [object objectForKey:@"Gender"];
          userSetGender = [object objectForKey:@"setGender"];
     userSearchDistance = [object objectForKey:@"SearchDistance"];
     userShowAges = [object objectForKey:@"ShowAges"];
     userEthnicities = [object objectForKey:@"Ethnicities"];
     userSchoolCollage=[object objectForKey:@"SchoolCollege"];
     userCoinValue = [object objectForKey:@"CoinValue"];
     userRechargeCoins = [object objectForKey:@"RechangeCoin"];
     userShowme = [object objectForKey:@"showme"];
     userStranger = [object objectForKey:@"Stranger"];
     userFriendesOfFriendes=[object objectForKey:@"FriendsOfFriends"];
     myImage=[object objectForKey:@"upLoadImage"];
        
     NSLog(@"%@ Gender",userGender);
}
                                            // restore value
     PFQuery *query1=[PFQuery queryWithClassName:@"userData"];
     [query1 whereKey:@"facebookID" equalTo:facebookID];
     [query1 getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
     NSLog(@"%@",facebookID);
     int coin=[userCoins intValue];
     coin=coin+3;
     NSString *UserCoin=[NSString stringWithFormat:@"%d",coin];
     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     NSLog(@"%@",location);
         [object setObject:name forKey:@"name"];
         [object setObject:ageYear forKey:@"ageYear"];
         
         [object setObject:birthday forKey:@"age"];
         [object setObject:location forKey:@"location"];
         [object setObject:userName forKey:@"Username"];
         [object setObject:userId forKey:@"facebookID"];
         [object setObject:userImage forKey:@"profilepic"];
         [object setObject:gender forKey:@"Gender"];
           [object setObject:userSetGender forKey:@"setGender"];
         [object setObject:userSearchDistance forKey:@"SearchDistance"];
         [object setObject:userShowAges forKey:@"ShowAges"];
         [object setObject:userCoinValue forKey:@"CoinValue"];
         [object setObject:userRechargeCoins forKey:@"RechangeCoin"];
         [object setObject:userShowme forKey:@"showme"];
         [object setObject:userStranger forKey:@"Stranger"];
         [object setObject:userFriendesOfFriendes forKey:@"FriendsOfFriends"];
         [object setObject:userEthnicities forKey:@"Ethnicities"];
         [object setObject:userSchoolCollage forKey:@"SchoolCollege"];
         [object setObject:UserCoin forKey:@"noOfcoins"];
         [object setObject:_numberoff forKey:@"nooffriend"];
         [object setObject:_latitudeLabel forKey:@"latitude"];
         [object setObject:_longitudeLabel forKey:@"Longitude"];
          [object setObject:deviceToken forKey:@"deviceToken"];
         [object setObject:myImage forKey:@"upLoadImage"];
         [object saveInBackground];
   
    }];
        
        // PFInstallation code
        
        PFInstallation *currentInstallation = [PFInstallation currentInstallation];
        [currentInstallation setObject:facebookID forKey:@"user"];
        [currentInstallation saveInBackground];
        
     HomeViewController *m_HomeViewController;
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
     {
     m_HomeViewController = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil]instantiateViewControllerWithIdentifier:@"HomeViewController"];
     }
     else
     {
     m_HomeViewController = [[UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil]instantiateViewControllerWithIdentifier:@"HomeViewController"];
     }
     [self.navigationController pushViewController:m_HomeViewController animated:NO];
     }
     else if(objects.count==0)
     {
     PFObject *recipe=[PFObject objectWithClassName:@"userData"];
     {
         
         // PFInstallation code
         
         PFInstallation *currentInstallation = [PFInstallation currentInstallation];
         [currentInstallation setObject:facebookID forKey:@"user"];
         [currentInstallation saveInBackground];
         
     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     [recipe setObject:name forKey:@"name"];
         [recipe setObject:ageYear forKey:@"ageYear"];

         [recipe setObject:_latitudeLabel forKey:@"latitude"];
         [recipe setObject:_longitudeLabel forKey:@"Longitude"];

     [recipe setObject:birthday forKey:@"age"];
         [recipe setObject:location forKey:@"location"];
     [recipe setObject:userName forKey:@"Username"];
     [recipe setObject:userId forKey:@"facebookID"];
     [recipe setObject:userImage forKey:@"profilepic"];
     [recipe setObject:gender forKey:@"Gender"];
     [recipe setObject:@"0" forKey:@"SearchDistance"];
         [recipe setObject:@"Male" forKey:@"setGender"];
     [recipe setObject:@"18" forKey:@"ShowAges"];
     [recipe setObject:@"$ 0" forKey:@"CoinValue"];
     [recipe setObject:@"Yes" forKey:@"RechangeCoin"];
     [recipe setObject:@"NO" forKey:@"showme"];
     [recipe setObject:@"Yes" forKey:@"Stranger"];
     [recipe setObject:@"Yes" forKey:@"FriendsOfFriends"];
     [recipe setObject:@"Other" forKey:@"Ethnicities"];
     [recipe setObject:@"NON" forKey:@"SchoolCollege"];
     [recipe setObject:@"3" forKey:@"noOfcoins"];
     [recipe setObject:_numberoff forKey:@"nooffriend"];
         [recipe setObject:deviceToken forKey:@"deviceToken"];

         UIImage *myImage=[UIImage imageNamed:@"profile1@2x.png"];
         
     NSData *imageData = UIImageJPEGRepresentation(myImage, 1.0);
     PFFile *imageFile = [PFFile fileWithName:@"profile1@2x.png" data:imageData];
     [recipe setObject:imageFile forKey:@"upLoadImage"];
     [recipe save];
     }
     }
     HomeViewController *m_HomeViewController;
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
     {
     m_HomeViewController = [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil]instantiateViewControllerWithIdentifier:@"HomeViewController"];
     }
     else
     {
     m_HomeViewController = [[UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil]instantiateViewControllerWithIdentifier:@"HomeViewController"];
     }
     [self.navigationController pushViewController:m_HomeViewController animated:NO];
     }
     else if(error)
     {
     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"MESSAGE" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil ,nil];
     [alert show];
     }
     }];
    }
}

- (void)loginView:(FBLoginView *)loginView
      handleError:(NSError *)error;
{
    


}
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    [PFFacebookUtils.session closeAndClearTokenInformation];
    [PFUser logOut];
    _b_backToHome.hidden=YES;
}

- (IBAction)backToHome:(id)sender
{
    HomeViewController *svc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
    [self.navigationController pushViewController:svc animated:YES];
}
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current Installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation setObject:_facebookID forKey:@"user"];
    NSLog(@"%@",_facebookID);

    [currentInstallation saveInBackground];
}
-(IBAction)facebookLoginTapped:(id)sender
{
    
}

- (IBAction)facebookLogoutTapped:(id)sender
{
    [PFFacebookUtils.session closeAndClearTokenInformation];
    [PFUser logOut];
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sign out" message:@"User Signed out" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
//  exit(0);
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = @"Sign in";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"red srtripe.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
    [NSDictionary dictionaryWithObjectsAndKeys:
    [UIFont fontWithName:@"Verdana" size:20],
    NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    if (self.isHomeView==NO)
    {
        _b_backToHome.hidden=NO;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
