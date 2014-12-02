//
//  HomeViewController.m
//  DatingApp
//
//  Created by CrayonLabs on 16/07/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "ProfileViewController.h"
#import "MessagesListViewController.h"
#import "SettingsViewController.h"
#import "YourFriendViewController.h"
#import "HomeTableViewCell.h"
#import "BuyCoinsViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>
#import "SPHViewController.h"
#import "MBProgressHUD.h"

static NSString *cellIdentifier=@"HomeTableViewCell";

@interface HomeViewController ()
@property (strong,nonatomic) NSString * mainUseID;
@property (strong ,nonatomic)                   NSString *messangerID;
@property (strong,nonatomic) NSString *mainID;
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *m_iduser;
@property (strong,nonatomic) NSString *m_nameFriend;

@end

@implementation HomeViewController
@synthesize m_Label_Array,m_Image_Array;
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
    if (!m_Label_Array)
    {
     m_Label_Array=[[NSMutableArray alloc]initWithObjects:@"Profile",@"Message",@"Settings",@"Invite",@"Buy Coins", nil];
     m_Image_Array=[[NSMutableArray alloc]initWithObjects:@"icon_profile.png",@"icon_message.png",@"icon_settings.png",@"icon_heart.png",@"coin 2.png",nil];
    }
    [self.m_TableViewHome registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:cellIdentifier];
    self.m_TableViewHome.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navigationItem.title = @"Home";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"red srtripe.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
    [NSDictionary dictionaryWithObjectsAndKeys:
    [UIFont fontWithName:@"Verdana" size:20],
    NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
   // UIImage* image3 = [UIImage imageNamed:@"arrow.png"];
    CGRect frameimg = CGRectMake(0, 0, 75, 75);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    //[someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton setTitle:@"LOGOUT" forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(pressedLeftBarButton:)
         forControlEvents:UIControlEventTouchUpInside];
    someButton.layer.cornerRadius=5.0f;
    [someButton setShowsTouchWhenHighlighted:YES];
    _leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.leftBarButtonItem=_leftBarButton;
    
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
    
    
    //show chat request
    [self   showRequest];
    
     //   [self performSelector:@selector(showRequest)];
}


-(void)showRequest
{
    //show chat request
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:_m_iduser forKey:@"messangerID"];
    _mainUseID=[defaults objectForKey:@"mainUserID"];
    [defaults synchronize];
    NSLog(@"%@",_mainUseID);
    
    PFQuery *query=[PFQuery queryWithClassName:@"Message"];
    [query whereKey:@"ReceiverID" equalTo:_mainUseID];
    [query  whereKey:@"status" equalTo:@"GET"];
    [query whereKey:@"response" equalTo:@"NO"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if(!error)
        {
             // NSLog(@"%@",objects);
             //  int num=objects.count;
             for (PFObject *object in objects)
             {
                 if (objects!=0)
                 {
                     NSString *response=[object objectForKey:@"response"];
                     _messangerID=[object objectForKey:@"ReceiverID"];
                     _mainID=[object objectForKey:@"senderID" ];
                     
                     //   NSString *messangerName=[object objectForKey:@"messangerName"];
                     if ([response isEqualToString:@"NO"])
                     {
                         NSString *str=[NSString stringWithFormat:@"YOU HAVE REQUEST FOR CHAT"];
                         UIAlertView *alert=[[UIAlertView alloc ] initWithTitle:@"Chat Request" message:str delegate:self cancelButtonTitle:@"Reject" otherButtonTitles:@"CHAT", nil];
                         [alert show];
                         
                     }
                     else
                     {
                         
                     }
                     break;
                 }
             }
         }
         else
         {
             NSLog(@"%@",error);
             UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"There is a error" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alert show];
         }
     }];
   

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];

    if([title isEqualToString:@"CHAT"])
    {
        //       NSLog(@"%@ %@",_messangerID,_mainID);
        // push notification.........
        
        PFQuery *query = [PFQuery queryWithClassName:@"Message"];
        [query whereKey:@"ReceiverID" equalTo:_messangerID];
        [query whereKey:@"senderID" equalTo:_mainID  ];
        [query whereKey:@"status" equalTo:@"GET"];
        [query orderByDescending:@"primaryKey"];
        
        [query  getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            NSString *primaryKey=[object objectForKey:@"primaryKey"];
            NSLog(@"%@",primaryKey);
            [object setObject:@"YES" forKey:@"response"];
            [object setObject:@"Request Accpeted!!" forKey:@"messageSend"];
            
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
            {
                PFObject * newObject = [PFObject    objectWithClassName:@"Message"];
                NSDate *date = [NSDate date];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"hh:mm a"];
                
                NSLog(@"%@ is obj", newObject.objectId);
                
                newObject[@"senderID"] = _mainID;
                newObject [@"ReceiverID"]= _messangerID;
                newObject [@"response"] = @"YES";
                newObject [@"messageSend"]= @"Hi, There!!";
                newObject [@"chatTime_Sender"] = [formatter stringFromDate:date];
                newObject [@"status"]=@"START";
                
                [newObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    
                    if (succeeded) {
                        
                        PFQuery *query = [PFQuery queryWithClassName:@"Message"];
                        
                        [query getObjectInBackgroundWithId:newObject.objectId block:^(PFObject *object, NSError *error) {
                            
                            object[@"messageRecive"] = newObject.objectId;
                            object[@"objectID"] = newObject.objectId;
                            int n=1+[primaryKey intValue];
                            newObject [@"primaryKey"]=[NSString stringWithFormat:@"%d",n];

                            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                
                                if (succeeded)
                                {
                                    SPHViewController * vc=[[SPHViewController alloc] initWithNibName:@"SPHViewController" bundle:nil];
                                    [self.navigationController pushViewController:vc animated:YES];
                                    vc.isAssignView=NO;
                                    vc.isMessageView=YES;
                                    vc.isAssignView=YES;
                                    vc.isMessageView=NO;
                                    vc.user_ID=_mainID;
                                    NSLog(@"%@,%@,%@",_userName,_messangerID,_mainID);
                                    vc.messangername=_userName;
                                    //  vc.message_image=_pictureURL;
                                    vc.messangerID=_messangerID;
                                    
                                }
                                
                            }];
                            
                        }];
                        
                    }
                    
                }];
                
             
            }];
            
        }];
        
     
    }
    else if ([title isEqualToString:@"Reject"])
    {
        PFQuery *query = [PFQuery queryWithClassName:@"NetworkTest"];
        [query whereKey:@"messangerID" equalTo:_messangerID];
        [query whereKey:@"facebookID" equalTo:_mainID  ];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                for (PFObject *object in objects) {
                    
                    [object deleteInBackground];
                }
            }
            else
            {
                NSLog(@"dfjkl");
            }
        }];
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.m_Label_Array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.tag = indexPath.row;
    cell.m_Image_profile_logo.image=[UIImage imageNamed:[m_Image_Array objectAtIndex:indexPath.row]];
    cell.m_Label_Profile.text=[m_Label_Array objectAtIndex:indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:self options:nil];
    if (nib)
    {
        HomeTableViewCell  * cell = [nib objectAtIndex:0];
        return cell.frame.size.height + 25.0f;
    }
    return 74.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0)
    {
     ProfileViewController *pvc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"profileView"];
        pvc.isHomeView=YES;
        pvc.isMutualView=NO;
     [self.navigationController pushViewController:pvc animated:YES];
    }
    else if (indexPath.row == 1)
    {
     MessagesListViewController *mvc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"messagesVc"];
     [self.navigationController pushViewController:mvc animated:YES];
    }
     else if (indexPath.row == 2)
    {
     SettingsViewController *svc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"settingsView"];
     [self.navigationController pushViewController:svc animated:YES];
    }
    else if (indexPath.row == 3)
    {
     YourFriendViewController *ivc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"YourFriendView"];
     [self.navigationController pushViewController:ivc animated:YES];
     }
    else if (indexPath.row == 4)
    {
     BuyCoinsViewController *ivc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"BuyCoinsView"];
     [self.navigationController pushViewController:ivc animated:YES];
     }
     else
     {
       // [self.navigationController  pushViewController:self.m_SupportVC animated:YES];
    }
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
    
}


-(IBAction)pressedLeftBarButton:(id)sender
{
//    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
//    if (screenRect.size.height == 548 ||screenRect.size.height == 568)
//    {
//     [self.navigationController popViewControllerAnimated:YES];
//    }
//    else
//    {
//     [self.navigationController popViewControllerAnimated:YES];
//    }
    LoginViewController *lvc=[[LoginViewController alloc]init];
    lvc.isHomeView=YES;
    LoginViewController *llvc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"loginView"];
    [self.navigationController pushViewController:llvc animated:YES];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{

}

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

@end
