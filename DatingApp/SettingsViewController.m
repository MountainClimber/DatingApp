//
//  SettingsViewController.m
//  DatingApp
//
//  Created by CrayonLabs on 16/07/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import "SettingsViewController.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import "MBProgressHUD.h"
#import "ProfileViewController.h"
#import "BuyCoinsViewController.h"
#import "ImageViewController.h"
#import "HomeViewController.h"
#import "FindUserViewController.h"

enum {
    kSection1 = 0,
    kSection2
};

@interface SettingsViewController ()

{
    NSTimer*_timer;
}

@property (strong,nonatomic) UILabel * RechargeOn;
@property (strong,nonatomic) UILabel * RechargeOff;
@property (strong,nonatomic)NSString * userID;
@property (strong,nonatomic) NSMutableArray *m_ArrFriends;
@property (strong,nonatomic) NSString * RechangeCoins;
@property (strong,nonatomic) NSString * ShowMe;
@property (strong,nonatomic) NSString * Strangers;
@property (strong,nonatomic) NSString * FriendsOfFriends;
@property (strong,nonatomic) NSString * setGender;
@property (strong,nonatomic) NSString * HighSC;
@property (strong,nonatomic) NSString * url1;
@property (strong,nonatomic) NSString * SchoolCollege;
@property (strong,nonatomic) NSString * userSchoolCollage;
@property (strong,nonatomic) NSString * MyImages;
@property (strong ,nonatomic) PFFile  * imageFile;
@property (strong ,nonatomic) PFFile  * userImage;
@property (strong,nonatomic) NSString * m_RechangeCoins;
@property (strong,nonatomic) NSString * m_distance;
@property (strong,nonatomic) NSString * m_age;



@end

static int progress1,progress2;
static NSString *CoinValue;
@implementation SettingsViewController
@synthesize m_username;
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
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Settings";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"red srtripe.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
    [NSDictionary dictionaryWithObjectsAndKeys:
    [UIFont fontWithName:@"Verdana" size:20],
    NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
    UIImage* image3 = [UIImage imageNamed:@"settings bar.png"];
    CGRect frameimg = CGRectMake(0, 0, image3.size.width, image3.size.height);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(pressedLeftBarButton:)
         forControlEvents:UIControlEventTouchUpInside];
    someButton.layer.cornerRadius=5.0f;
    [someButton setShowsTouchWhenHighlighted:YES];
    _leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.leftBarButtonItem=_leftBarButton;
    
//    UIImage* image32 = [UIImage imageNamed:@"comment.png"];
//    CGRect frameimg2 = CGRectMake(0, 0, image32.size.width, image32.size.height);
//    UIButton *someButton2 = [[UIButton alloc] initWithFrame:frameimg2];
//    [someButton2 setBackgroundImage:image32 forState:UIControlStateNormal];
//    [someButton2 addTarget:self action:@selector(pressedRightBarButton:)
//          forControlEvents:UIControlEventTouchUpInside];
//    someButton2.layer.cornerRadius=5.0f;
//    [someButton2 setShowsTouchWhenHighlighted:YES];
    
// _rightBarButton =[[UIBarButtonItem alloc] initWithCustomView:someButton2];
    self.navigationItem.rightBarButtonItem=_rightBarButton;
    self.m_Label_Distance.text = @"50";
    self.m_Label_Ages.text=@"18";
    self.m_LabelCoinValue.text=@"$ 1";
    self.m_ScrollView.contentSize=CGSizeMake(320,1100);
    self.m_ScrollView.showsVerticalScrollIndicator=YES;
    [self   methodSaveParseValues];
    
    UIImage *myimage=[UIImage imageNamed:@"green_cross.png"];
    [self.m_buttonMale setImage:myimage forState:UIControlStateNormal];
    
    UIImage *myimage2=[UIImage imageNamed:@"green_cross.png"];
    [self.m_ButtonFemale setImage:myimage2 forState:UIControlStateNormal];
    
    UITapGestureRecognizer  *tapGesture = [[UITapGestureRecognizer   alloc] initWithTarget:self action:@selector(tapGestureCalled:)];
    tapGesture.numberOfTapsRequired = 1;
    
    [self.view   addGestureRecognizer:tapGesture];
   // FBRequest *request =[FBRequest  requestForCustomAudienceThirdPartyID:[PFFacebookUtils session]];
    [[FBRequest requestForMe]    startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error)
     {
    if (!error)
    {
    MBProgressHUD *view =[MBProgressHUD  showHUDAddedTo:self.view animated:YES];
    [view  setLabelText:@"Getting Settings"];
    NSDictionary *userData = (NSDictionary *)result;
    _userID = userData[@"id"];
   // NSLog(@"%@ user id",_userID);
    PFQuery *query = [PFQuery queryWithClassName:@"userData"];
    [query whereKey:@"facebookID" equalTo:_userID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    if (!error)
    {
    for (PFObject *userInfo in objects)
    {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
   
        NSString *userSetGender=[userInfo objectForKey:@"setGender"];
    NSString *userSearchDistance = [userInfo objectForKey:@"SearchDistance"];
        _m_distance=userSearchDistance;
    NSString *userShowAges = [userInfo objectForKey:@"ShowAges"];
        _m_age=userShowAges;
    NSString *userEthnicities = [userInfo objectForKey:@"Ethnicities"];
    _userSchoolCollage=[userInfo objectForKey:@"SchoolCollege"];
    NSString *userCoinValue = [userInfo objectForKey:@"CoinValue"];
    NSString *userRechargeCoins = [userInfo objectForKey:@"RechangeCoin"];
    NSString *userShowme = [userInfo objectForKey:@"showme"];
    NSString *userStranger = [userInfo objectForKey:@"Stranger"];
    NSString *userFriendesOfFriendes=[userInfo objectForKey:@"FriendsOfFriends"];
    _userImage=[userInfo objectForKey:@"upLoadImage"];
    _imageFile=[userInfo objectForKey:@"upLoadImage"];
        _m_age=userShowAges;
        _m_distance=userSearchDistance;
    [_userImage getDataInBackgroundWithBlock:^(NSData *result, NSError *error)
    {
    if (!error)
    {
    UIImage *image = [UIImage imageWithData:result];
   // _m_ImageViewMyImages.image=image;
    _imageFile=_userImage;
    }
    }];
    _m_Label_Distance.text=userSearchDistance;
        //SearchDistance set value of slider
    [_m_SliderSearchDistance setValue:[userSearchDistance floatValue] animated:YES];
    _m_Label_Ages.text=userShowAges;
    //Showages set value of slider
    [_m_SliderShowAges setValue:[userShowAges floatValue] animated:YES];
    _m_LabelEthnicities.text=userEthnicities;
    _m_LabelHighSC.text=_userSchoolCollage;
    _SchoolCollege=_userSchoolCollage;
 //   NSLog(@"school %@",_m_TextfieldCancel);
    _m_LabelCoinValue.text=userCoinValue;
    [_m_SliderCoinValue setValue:[userCoinValue floatValue] animated:YES];
 //   NSLog(@"%@ %@ %@ %@ %@ hghjg",userInfo,userRechargeCoins,userSetGender,userEthnicities,userCoinValue);
    if ([userSetGender isEqualToString: @"Male"]) {
    UIImage *myimage3=[UIImage imageNamed:@"success.png"];
    UIImage *myimage4=[UIImage imageNamed:@"green_cross.png"];
    [self.m_buttonMale setImage:myimage3 forState:UIControlStateNormal];
    [self.m_ButtonFemale setImage:myimage4 forState:UIControlStateNormal];
    _m_male.selected=YES;
    _m_femae.selected=NO;
    }
    else if([userSetGender isEqualToString:@"Female"])
    {
    UIImage *myimage3=[UIImage imageNamed:@"green_cross.png"];
    UIImage *myimage4=[UIImage imageNamed:@"success.png"];
    [self.m_ButtonFemale setImage:myimage4 forState:UIControlStateNormal];
    [self.m_buttonMale setImage:myimage3 forState:UIControlStateNormal];
    _m_femae.selected=YES;
    _m_male.selected=NO;
    }
    // set Recharger coins
    if ([userRechargeCoins isEqualToString:@"NO"])
    {
    [_m_SwitchRechargeCoin setOn:NO];
    }
    else
                     {
                         _m_labelRecharge.hidden=NO;
                         _m_labelRecharge.text=userRechargeCoins;
                     [_m_SwitchRechargeCoin setOn:NO];
                     }
                     //set show me
                     if ([userShowme isEqualToString:@"NO"]) {
                         [_m_SwitchShowme setOn:NO];
                     }
                     else if([userShowme isEqualToString:@"YES"])
                     {
                         [_m_SwitchShowme setOn:YES];
                     }
                     // set stranger
                     if ([userStranger isEqualToString:@"NO"]) {
                         [_m_SwitchStanger setOn:NO];
                     }
                     else if([userStranger isEqualToString:@"YES"])
                     {
                         [_m_SwitchStanger setOn:YES];
                     }
                     //set friends of friends
                     if ([userFriendesOfFriendes isEqualToString:@"NO"]) {
                         [_m_SwitchFriendsOfFriends setOn:NO];
                     }
                     else if([userFriendesOfFriendes isEqualToString:@"YES"])
                     {
                         [_m_SwitchFriendsOfFriends setOn:YES];
                     }
                 }
                     
                 }
                 else
                 {
                   //  NSLog(@"error %@",error);
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error found" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                     [alert show];
                 }
             }];
         }
     }];
//     Switch fiends of friends
    if ([_m_SwitchFriendsOfFriends isOn]) {
//        NSLog(@"Lation switch on");
        self.FriendsOfFriends=@"YES";
    }
    else
    {
//        NSLog(@"Lation switch off");
        self.FriendsOfFriends=@"NO";
    }
    
//     switch Stranger
    if ([_m_SwitchStanger isOn]) {
//        NSLog(@"Lation switch on");
        self.Strangers=@"YES";
    }
    else
    {
//        NSLog(@"Lation switch off");
        self.Strangers=@"NO";
    }
//     Switch Showme
    if ([_m_SwitchShowme isOn]) {
//       NSLog(@"Show mw on");
        self.ShowMe=@"YES";
    }
    else
    {
//        NSLog(@"Lation switch off");
        self.ShowMe=@"NO";
    }
//     Switch Recharge
    if ([_m_SwitchRechargeCoin isOn]) {
//        NSLog(@"Lation switch on");
        self.RechangeCoins=@"Yes";
        
    }
    else
    {
//        NSLog(@"Lation switch off");
        self.RechangeCoins=@"NO";
    }
//      Button gender
    
    if ([_m_ButtonGender_Male tag] == 1 ) // Male
    {
        UIImage *myimage3=[UIImage imageNamed:@"success.png"];
        [self.m_buttonMale setImage:myimage3 forState:UIControlStateNormal];
        UIImage *myimage4=[UIImage imageNamed:@"green_cross.png"];
        [self.m_ButtonFemale setImage:myimage4 forState:UIControlStateNormal];
        self.setGender=@"Male";
    }
    else if ([_m_ButtonGender_Female tag] == 2) // FeMale
    {
        UIImage *myimage4=[UIImage imageNamed:@"success.png"];
        [self.m_ButtonFemale setImage:myimage4 forState:UIControlStateNormal];
        
        UIImage *myimage3=[UIImage imageNamed:@"green_cross.png"];
        [self.m_buttonMale setImage:myimage3 forState:UIControlStateNormal];
        self.setGender=@"Female";
    }
    
    
  _timer=  [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(saveData)
                                   userInfo:nil
                                    repeats:YES];
}


-(void)facebookGetFriends
{
    
    
    
}

- (IBAction)b_gender:(id)sender {
    if ([sender tag] == 1 ) // Male
    {
        if (_m_male.selected==YES) {
            UIImage *myimage4=[UIImage imageNamed:@"success.png"];
            [self.m_ButtonFemale setImage:myimage4 forState:UIControlStateNormal];
            
            UIImage *myimage3=[UIImage imageNamed:@"green_cross.png"];
            [self.m_buttonMale setImage:myimage3 forState:UIControlStateNormal];
            self.setGender=@"Female";
//            NSLog(@"female");
            _m_femae.selected=YES;
            _m_male.selected=NO;
        }
        else if(_m_male.selected==NO)
        {
            UIImage *myimage3=[UIImage imageNamed:@"success.png"];
            [self.m_buttonMale setImage:myimage3 forState:UIControlStateNormal];
            UIImage *myimage4=[UIImage imageNamed:@"green_cross.png"];
            [self.m_ButtonFemale setImage:myimage4 forState:UIControlStateNormal];
            self.setGender=@"Male";
//             NSLog(@"male");
            _m_femae.selected=NO;
            _m_male.selected=YES;
        }
    }
    else if ([sender tag] == 2) // FeMale
    {
        if (_m_femae.selected==NO) {
            UIImage *myimage3=[UIImage imageNamed:@"green_cross.png"];
            [self.m_buttonMale setImage:myimage3 forState:UIControlStateNormal];
            UIImage *myimage4=[UIImage imageNamed:@"success.png"];
            [self.m_ButtonFemale setImage:myimage4 forState:UIControlStateNormal];
            self.setGender=@"Female";
//             NSLog(@"Female");
            _m_femae.selected=YES;
            _m_male.selected=NO;

        }
        else if(_m_femae.selected==YES)
        {
            
        
        UIImage *myimage4=[UIImage imageNamed:@"green_cross.png"];
        [self.m_ButtonFemale setImage:myimage4 forState:UIControlStateNormal];
        
        UIImage *myimage3=[UIImage imageNamed:@"success.png"];
        [self.m_buttonMale setImage:myimage3 forState:UIControlStateNormal];
        self.setGender=@"Male";
//             NSLog(@"Male");
            _m_femae.selected=NO;
            _m_male.selected=YES;
        }
    }

    
}

- (IBAction)buttonShowAll:(id)sender {
    FindUserViewController *hvc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"FindUserViewController"];
    hvc.isShowAll=YES;
    hvc.isNearBy=NO;
    [self.navigationController pushViewController:hvc animated:YES];
}

- (IBAction)buttonAdd:(id)sender {
    
    
//    NSLog(@"new %@",_userSchoolCollage);
//    NSLog(@"old %@",_m_LabelHighSC.text);
    if([_m_LabelHighSC.text isEqualToString:_userSchoolCollage ])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ADD" message:@"ADD new School or Collage" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
         _SchoolCollege=[NSString stringWithFormat:@"%@",_m_LabelHighSC.text];
        }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"ADD" message:@"New School or Collage upload" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        _SchoolCollege=[NSString stringWithFormat:@"%@",_m_LabelHighSC.text];
//        if (_m_ButtonADD.selected==NO) {
//            
//            _SchoolCollege=_m_LabelHighSC.text;
//            NSLog(@"school  %@",_SchoolCollege);
//            _m_ButtonADD.selected=YES;
//            
//        }
//        else if((_m_ButtonADD.selected==YES))
//        {
//            
//            _SchoolCollege=[NSString stringWithFormat:@"%@",_userSchoolCollage];
//            NSLog(@"school  %@",_SchoolCollege);
//            _m_ButtonADD.selected=NO;
//        }

    }
}


-(IBAction)pressedRightBarButton:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Help" message:@"Set your Profile" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil ];
    [alert show];
}

-(void)tapGestureCalled:(id)sender
{
    [self.m_TextfieldCancel resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



- (IBAction)CheckButtonGender:(UIButton *)sender {
//    if ([sender tag] == 1 ) // Male
//    {
//        if (_m_male.selected==YES) {
//            UIImage *myimage4=[UIImage imageNamed:@"female 2.png"];
//            [self.m_ButtonFemale setImage:myimage4 forState:UIControlStateNormal];
//            
//            UIImage *myimage3=[UIImage imageNamed:@"male.png"];
//            [self.m_buttonMale setImage:myimage3 forState:UIControlStateNormal];
//            self.Gender=@"Female";
//            _m_male.selected=NO;
//        }
//        else if(_m_male.selected==NO)
//        {
//        UIImage *myimage3=[UIImage imageNamed:@"male 2.png"];
//        [self.m_buttonMale setImage:myimage3 forState:UIControlStateNormal];
//        UIImage *myimage4=[UIImage imageNamed:@"female.png"];
//        [self.m_ButtonFemale setImage:myimage4 forState:UIControlStateNormal];
//        self.Gender=@"Male";
//        }
//    }
//    else if ([sender tag] == 2) // FeMale
//    {
//        UIImage *myimage4=[UIImage imageNamed:@"female 2.png"];
//        [self.m_ButtonFemale setImage:myimage4 forState:UIControlStateNormal];
//        
//        UIImage *myimage3=[UIImage imageNamed:@"male.png"];
//        [self.m_buttonMale setImage:myimage3 forState:UIControlStateNormal];
//        self.Gender=@"Female";
//    }
//
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_m_LabelHighSC resignFirstResponder];
    
    return YES;
}

- (IBAction)sliderdistance:(UISlider *)sender {
     progress1 = lroundf(sender.value);
    self.m_Label_Distance.text = [NSString stringWithFormat:@"%d", progress1];
    
//      NSLog(@"search distance %d",progress1);
    _m_distance=[NSString stringWithFormat:@"%d", progress1];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * mainUserLocation=[defaults objectForKey:@"location"];
//    NSLog(@"%@",mainUserLocation);
    
    PFQuery *query = [PFQuery queryWithClassName:@"userData"];
    [query whereKey:@"facebookID" equalTo:_userID];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        NSString *UserSetDistance=[object objectForKey:@"SearchDistance"];
//        NSLog(@"%@",UserSetDistance);
       
    }];
    
}

- (IBAction)sliderAges:(UISlider *)sender {
    
     progress2 = lroundf(sender.value);
    self.m_Label_Ages.text = [NSString stringWithFormat:@"%d", progress2];
//    NSLog(@"search distance %d",progress2);
    _m_age=[NSString stringWithFormat:@"%d", progress2];;
}

- (IBAction)switch_Caucasian:(id)sender {
    
    
    
}

- (IBAction)switch_Lation:(id)sender {
    if ([sender isOn]) {
//        NSLog(@"Lation switch on");
    }
    else
    {
//        NSLog(@"Lation switch off");
    }
}

- (IBAction)sliderCoinValue:(UISlider *)sender {
    
    progress2 = lroundf(sender.value);
    self.m_LabelCoinValue.text = [NSString stringWithFormat:@"$ %d", progress2];
//    NSLog(@"search distance %d",progress2);
    CoinValue=_m_LabelCoinValue.text;
//    NSLog(@"cion values %@",CoinValue);
    
}

- (IBAction)switchRechangeCoins:(UISwitch *)sender {
    if([sender isOn])
    {
        
        _m_labelRecharge.hidden=NO;
//        UIActionSheet *actionSheet1 = [[UIActionSheet alloc] initWithTitle:@"Pick Package:"
//                                                                 delegate:self
//                                                        cancelButtonTitle:nil
//                                                   destructiveButtonTitle:nil
//                                                        otherButtonTitles:@"1 Coin", @"5 Coins", @"10 Coins", @"20 Coins",@"30 Coins",@"50 Coins", @"75 Coins", @"85 Coins",@"None", nil];
//        
//        
//        [actionSheet1 showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
//        
//        [actionSheet1 showInView:self.view];
//        actionSheet1.tag=2;
        
        BuyCoinsViewController *ivc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"BuyCoinsView"];
                [self.navigationController pushViewController:ivc animated:YES];

        
    }
    else{
        _m_labelRecharge.hidden=YES;
        _RechangeCoins=@"NO";
    }
    
}



- (IBAction)switchStrangers:(UISwitch *)sender {
    if([sender isOn])
    {
        _Strangers=@"YES";
    }
    else{
        _Strangers=@"NO";
    }

}

- (IBAction)switchFriendsOfFriends:(UISwitch *)sender {
    if([sender isOn])
    {
        _FriendsOfFriends=@"YES";
    }
    else{
        _FriendsOfFriends=@"NO";
    }
}

-(void)methodSaveParseValues
{
    
    
    
}

- (IBAction)backgroundTap:(id)sender
{
    [self.m_LabelHighSC resignFirstResponder];
   
}


- (IBAction)buttonShowMe:(id)sender {
    if([sender isOn])
    {
        _ShowMe=@"YES";
    }
    else{
        _ShowMe=@"NO";
    }

}

- (IBAction)buttonCancel:(id)sender {
    
     [self.m_ButtonCancel resignFirstResponder];
}
- (IBAction)buttonSelectImage:(id)sender {
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
//    imagePickerController = [[UIImagePickerController alloc] init];
//    imagePickerController.delegate = self;
//    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
//    
//    [self presentModalViewController:imagePickerController animated:YES];
//   
//    
//    NSLog(@"image %@",imagePickerController);
  
    // Calling ECL image picker
     [_timer invalidate];
    
    
    ELCImagePickerController *elcPicker ;
    ELCAlbumPickerController *albumController;
    
    albumController= [[ELCAlbumPickerController alloc] initWithNibName: nil bundle: nil];
    elcPicker= [[ELCImagePickerController alloc] initWithRootViewController:albumController];
    
    elcPicker.maximumImagesCount = 10;
    [albumController setParent:elcPicker];
    // [elcPicker setDelegate:self];
    elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
   

}
//- (void)imagePickerController:(UIImagePickerController *)picker
//        didFinishPickingImage:(UIImage *)image
//                  editingInfo:(NSDictionary *)editingInfo
//
//{
//    
//    // Dismiss the image selection, hide the picker and
//    
//    //show the image view with the picked image
//    
//    [picker dismissModalViewControllerAnimated:YES];
//    UIImage *newImage = image;
//    _m_ImageViewMyImages.image=newImage;
//    NSData *imageData = UIImageJPEGRepresentation(newImage, 1.0);
//    _imageFile = [PFFile fileWithName:_MyImages data:imageData];
//    NSLog(@"%@  kjfc %@",_MyImages,_imageFile);
//    
//    NSDate *date = [NSDate date];
//    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
//    timeFormatter.dateFormat = @"HH:mm:ss";
//    NSString *timeString = [timeFormatter stringFromDate:date];
//    
//    
//    PFObject *recipe=[PFObject objectWithClassName:@"images"];
//    {
//        [recipe setObject:_userID forKey:@"facebookID"];
//        [recipe setObject:_imageFile forKey:@"imagess"];
//        [recipe setObject:timeString forKey:@"addTime"];
//        [recipe saveInBackground];
//    }
//    
//}

// ELC Picker Delegate Methods

-(void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    // Dismiss the image selection, hide the picker and
    
    //show the image view with the picked image
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    for (int i = info.count - 1 ; i >=0 ; i--)
    {
        //        NSLog(@"%@ IS INFO ",info);
        
        UIImage *image = [[info objectAtIndex:i] objectForKey:UIImagePickerControllerOriginalImage];
        image =[UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationUp];
        
        
        _m_ImageViewMyImages.image=image;
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        _imageFile = [PFFile fileWithName:_MyImages data:imageData];
//        NSLog(@"%@  kjfc %@",_MyImages,_imageFile);
        
        NSDate *date = [NSDate date];
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        timeFormatter.dateFormat = @"HH:mm:ss";
        NSString *timeString = [timeFormatter stringFromDate:date];
        
        
        PFObject *recipe=[PFObject objectWithClassName:@"images"];
        {
            [recipe setObject:_userID forKey:@"facebookID"];
            [recipe setObject:_imageFile forKey:@"imagess"];
            [recipe setObject:timeString forKey:@"addTime"];
            [recipe saveInBackground];
        }
        
        
    }
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(saveData)
                                   userInfo:nil
                                    repeats:YES];
}


-(void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buttonSearch:(id)sender {
    
    
    
    NSString * Search=_m_TextfieldCancel.text;
    _url1 = [[NSString alloc] initWithFormat:@"https://www.google.co.in/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=%@",Search];
   _m_TextfieldCancel.text=[NSString stringWithFormat:@"%@",_url1];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_url1]];
     NSString* url=[[NSString alloc] initWithFormat:@"%@/?fields=name,location,gender,birthday,relationship_status,picture,email,id,age_range,context/mutual_likes/mutual_friends",_url1];

    NSString *requestPath = url;
    
    FBRequest *request = [[FBRequest    alloc] initWithSession:[PFFacebookUtils session] graphPath:requestPath];
    
    if (request.session.isOpen)
    {
        
        
        [request    startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error)
         {
             
             NSLog(@"%@ os request",result);
             
             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
             
             // self.m_ArrFriends = [[NSMutableArray alloc] initWithArray:[result    objectForKey:@"data"]];
             
         }];
        
    }

}

- (IBAction)FindUser:(id)sender {
    FindUserViewController *hvc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"FindUserViewController"];
    hvc.setAge=_m_age;
    hvc.setDistance=_m_distance;
    hvc.setGender=_setGender;
    hvc.isNearBy=YES;
    hvc.isShowAll=NO;
    [self.navigationController pushViewController:hvc animated:YES];
    
}
- (IBAction)buttondropdown:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Pick Ethnicities:"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Caucasian", @"Black", @"Hispanic", @"Other", nil];
    
    
    [actionSheet showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
    actionSheet.tag=1;
    [actionSheet showInView:self.view];
    
    
    
}


-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag==1) {
    NSString *strn= [actionSheet buttonTitleAtIndex:buttonIndex];
    NSLog(@"selected button: %@",strn);
    _m_LabelEthnicities.text=[NSString stringWithFormat:@"%@",strn];
    NSLog(@"jdchkj:::%@",_m_LabelEthnicities.text);
    }
    if (actionSheet.tag==2) {
        if (buttonIndex==0) {
            
        
    NSString *strn1= [actionSheet buttonTitleAtIndex:buttonIndex];
    NSLog(@"selected button: %@",strn1);
    _RechangeCoins=[NSString stringWithFormat:@"%@",strn1];
    NSLog(@"%@",_RechangeCoins);
        _m_labelRecharge.text=_RechangeCoins;
        BuyCoinsViewController *ivc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"BuyCoinsView"];
        ivc.numberOfCoins=_RechangeCoins;
        ivc.isSettingView=YES;
        ivc.isHomeView=NO;
            ivc.CoinsPrice=1;
        [self.navigationController pushViewController:ivc animated:YES];
            NSLog(@"1");
        }
        else if (buttonIndex==1) {
            
            
            NSString *strn1= [actionSheet buttonTitleAtIndex:buttonIndex];
            NSLog(@"selected button: %@",strn1);
            _RechangeCoins=[NSString stringWithFormat:@"%@",strn1];
            NSLog(@"%@",_RechangeCoins);
            _m_labelRecharge.text=_RechangeCoins;
            BuyCoinsViewController *ivc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"BuyCoinsView"];
            ivc.numberOfCoins=_RechangeCoins;
            ivc.isSettingView=YES;
            ivc.isHomeView=NO;
            ivc.CoinsPrice=5;

            [self.navigationController pushViewController:ivc animated:YES];
            NSLog(@"5");
        }
        else if (buttonIndex==2) {
            
            
            NSString *strn1= [actionSheet buttonTitleAtIndex:buttonIndex];
            NSLog(@"selected button: %@",strn1);
            _RechangeCoins=[NSString stringWithFormat:@"%@",strn1];
            NSLog(@"%@",_RechangeCoins);
            _m_labelRecharge.text=_RechangeCoins;
            BuyCoinsViewController *ivc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"BuyCoinsView"];
            ivc.numberOfCoins=_RechangeCoins;
            ivc.isSettingView=YES;
            ivc.isHomeView=NO;
            ivc.CoinsPrice=10;

            [self.navigationController pushViewController:ivc animated:YES];
            NSLog(@"10");
        }

        else if (buttonIndex==3) {
            
            
            NSString *strn1= [actionSheet buttonTitleAtIndex:buttonIndex];
            NSLog(@"selected button: %@",strn1);
            _RechangeCoins=[NSString stringWithFormat:@"%@",strn1];
            NSLog(@"%@",_RechangeCoins);
            _m_labelRecharge.text=_RechangeCoins;
            BuyCoinsViewController *ivc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"BuyCoinsView"];
            ivc.numberOfCoins=_RechangeCoins;
            ivc.isSettingView=YES;
            ivc.isHomeView=NO;
            ivc.CoinsPrice=20;

            [self.navigationController pushViewController:ivc animated:YES];
            NSLog(@"20");
        }
        else if (buttonIndex==4) {
            
            
            NSString *strn1= [actionSheet buttonTitleAtIndex:buttonIndex];
            NSLog(@"selected button: %@",strn1);
            _RechangeCoins=[NSString stringWithFormat:@"%@",strn1];
            NSLog(@"%@",_RechangeCoins);
            _m_labelRecharge.text=_RechangeCoins;
            BuyCoinsViewController *ivc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"BuyCoinsView"];
            ivc.numberOfCoins=_RechangeCoins;
            ivc.isSettingView=YES;
            ivc.isHomeView=NO;
            ivc.CoinsPrice=30;
            [self.navigationController pushViewController:ivc animated:YES];
            NSLog(@"30");
        }
        else if (buttonIndex==5) {
            
            
            NSString *strn1= [actionSheet buttonTitleAtIndex:buttonIndex];
            NSLog(@"selected button: %@",strn1);
            _RechangeCoins=[NSString stringWithFormat:@"%@",strn1];
            NSLog(@"%@",_RechangeCoins);
            _m_labelRecharge.text=_RechangeCoins;
            BuyCoinsViewController *ivc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"BuyCoinsView"];
            ivc.numberOfCoins=_RechangeCoins;
            ivc.isSettingView=YES;
            ivc.isHomeView=NO;
            ivc.CoinsPrice=50;
            [self.navigationController pushViewController:ivc animated:YES];
            NSLog(@"50");
        }
        else if (buttonIndex==6) {
            
            
            NSString *strn1= [actionSheet buttonTitleAtIndex:buttonIndex];
            NSLog(@"selected button: %@",strn1);
            _RechangeCoins=[NSString stringWithFormat:@"%@",strn1];
            NSLog(@"%@",_RechangeCoins);
            _m_labelRecharge.text=_RechangeCoins;
            BuyCoinsViewController *ivc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"BuyCoinsView"];
            ivc.numberOfCoins=_RechangeCoins;
            ivc.isSettingView=YES;
            ivc.isHomeView=NO;
            ivc.CoinsPrice=75;
            [self.navigationController pushViewController:ivc animated:YES];
            NSLog(@"75");
        }
        else if (buttonIndex==7) {
            
            
            NSString *strn1= [actionSheet buttonTitleAtIndex:buttonIndex];
            NSLog(@"selected button: %@",strn1);
            _RechangeCoins=[NSString stringWithFormat:@"%@",strn1];
            NSLog(@"%@",_RechangeCoins);
            _m_labelRecharge.text=_RechangeCoins;
            BuyCoinsViewController *ivc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"BuyCoinsView"];
            ivc.numberOfCoins=_RechangeCoins;
            ivc.isSettingView=YES;
            ivc.isHomeView=NO;
            ivc.CoinsPrice=100;
            [self.navigationController pushViewController:ivc animated:YES];
            NSLog(@"100");
        }



    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.m_ScrollView  setContentOffset:CGPointMake(0, textField.frame.origin.y-15 ) animated:YES];
    
    
    return YES;
}

-(IBAction)pressedLeftBarButton:(id)sender
{
    if (_userID.length>0) {
        
        if (_isSettingView==NO) {
//            HomeViewController *hvc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
//                        [self.navigationController pushViewController:hvc animated:YES];
            CGRect screenRect=[[UIScreen mainScreen] applicationFrame];
            
            if (screenRect.size.height == 548 ||screenRect.size.height == 568)
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }

        }
            
      else
      {
    CGRect screenRect=[[UIScreen mainScreen] applicationFrame];
    
    if (screenRect.size.height == 548 ||screenRect.size.height == 568)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
      }
    PFQuery *query = [PFQuery queryWithClassName:@"userData"];
    [query whereKey:@"facebookID" equalTo:_userID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            for (PFObject *object in objects) {
                
                UIImage *img=_m_ImageViewMyImages.image;
                
                
                [object setObject:_m_Label_Ages.text forKey:@"ShowAges"];
                [object setObject:_m_Label_Distance.text forKey:@"SearchDistance"];
                [object setObject:_m_LabelCoinValue.text forKey:@"CoinValue"];
                [object setObject:_RechangeCoins forKey:@"RechangeCoin"];
                [object setObject:_ShowMe forKey:@"showme"];
                [object setObject:_Strangers forKey:@"Stranger"];
                [object setObject:_setGender forKey:@"setGender"];
                [object setObject:_FriendsOfFriends forKey:@"FriendsOfFriends"];
                [object setObject:_imageFile forKey:@"upLoadImage"];
                NSLog(@"%@",_SchoolCollege);
                
                [object setObject:_SchoolCollege forKey:@"SchoolCollege"];
                [object setObject:_m_LabelEthnicities.text forKey:@"Ethnicities"];
                [object saveInBackground];
            }
            // Notify table view to reload the recipes from Parse cloud
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
            // Dismiss the controller
            [self dismissViewControllerAnimated:YES completion:nil];
            // Did not find any UserStats for the curre
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Failure" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
        
        
    }
    else
    {
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"You Did Not Update Setting" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
        CGRect screenRect=[[UIScreen mainScreen] applicationFrame];
        
        if (screenRect.size.height == 548 ||screenRect.size.height == 568)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
    }
}
-(void)saveData
{
    if (_userID.length>0) {
        
               PFQuery *query = [PFQuery queryWithClassName:@"userData"];
        [query whereKey:@"facebookID" equalTo:_userID];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                
                
                
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                for (PFObject *object in objects) {
                    
                    UIImage *img=_m_ImageViewMyImages.image;
                    
                    
                    [object setObject:_m_Label_Ages.text forKey:@"ShowAges"];
                    [object setObject:_m_Label_Distance.text forKey:@"SearchDistance"];
                    [object setObject:_m_LabelCoinValue.text forKey:@"CoinValue"];
                    [object setObject:_RechangeCoins forKey:@"RechangeCoin"];
                    [object setObject:_ShowMe forKey:@"showme"];
                    [object setObject:_Strangers forKey:@"Stranger"];
                    [object setObject:_setGender forKey:@"setGender"];
                    [object setObject:_FriendsOfFriends forKey:@"FriendsOfFriends"];
                    [object setObject:_imageFile forKey:@"upLoadImage"];
             
                    
                    [object setObject:_SchoolCollege forKey:@"SchoolCollege"];
                    [object setObject:_m_LabelEthnicities.text forKey:@"Ethnicities"];
                    [object saveInBackground];
                }
                // Notify table view to reload the recipes from Parse cloud
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
                // Dismiss the controller
                [self dismissViewControllerAnimated:YES completion:nil];
                // Did not find any UserStats for the curre
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Failure" message:[error localizedDescription] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        }];
        
        
    }
   
}

- (IBAction)b_ImageView:(id)sender {
    
    ImageViewController *ivc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"ImageViewController"];
    ivc.isSettingView=YES;
    ivc.isMutualView=NO;
    ivc.isHomeView=NO;
    [self.navigationController pushViewController:ivc animated:YES];
    
    
}
@end
