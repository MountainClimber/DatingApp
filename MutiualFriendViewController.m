//
//  MutiualFriendViewController.m
//  DatingApp
//
//  Created by CrayonLabs on 8/15/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import <Foundation/Foundation.h>
#import "MutiualFriendViewController.h"
#import "YourFriendTableViewCell.h"
#import "FriendOfFriendViewController.h"
#import "MessagesListViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import "SPHViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "SettingsViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "ProfileViewController.h"
#import "ImageViewController.h"
#import "AppDelegate.h"
#import "YourFriendViewController.h"
// _m_iduser = receiver ID
//_mainUseId = current Logged User

//testing app
@interface MutiualFriendViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic,retain) NSURL         * pictureURL;
@property (strong,nonatomic) NSArray       * m_ArrFriends;
@property (strong,nonatomic) NSMutableData * imageData;
@property (strong,nonatomic) NSMutableData * birthDateData;
@property (strong,nonatomic) NSString * mainUserID;
@property(assign,nonatomic) NSMutableArray *m_Stranger;
@property (strong ,nonatomic)                   NSString *messangerID;
@property (strong,nonatomic) NSString *mainID;
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *m_DeviceID;

@end

@implementation MutiualFriendViewController


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
    self.navigationItem.title = @"Mutual Friends";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"red srtripe.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Verdana" size:20],
      NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
        UIImage* image3 = [UIImage imageNamed:@"arrow.png"];
        CGRect frameimg = CGRectMake(0, 0, image3.size.width, image3.size.height);
        UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
        [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
        [someButton addTarget:self action:@selector(pressedLeftBarButton:)
             forControlEvents:UIControlEventTouchUpInside];
        someButton.layer.cornerRadius=5.0f;
        [someButton setShowsTouchWhenHighlighted:YES];
    
        _leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    _mainUserID=[defaults objectForKey:@"mainUserID"];
    
    
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
    self.m_LabelFriendName.text=_m_nameFriend;
    self.m_BirthdayFriend.text=_m_DOBFriend;
    NSLog(@"iduser %@",_m_iduser);
    _imageData = [[NSMutableData alloc] init];
 
    NSLog(@"%@ %@",_mainUserID,_m_iduser);
   _pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", _m_iduser]];
       NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:_pictureURL
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:2.0f];
    // Run network request asynchronously
    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    NSLog(@"%@",_m_iduser);
    _m_userProfile.hidden=YES;
    PFQuery *quer=[PFQuery queryWithClassName:@"userData"];
    [quer whereKey:@"facebookID" equalTo:_m_iduser];
    [quer whereKey:@"showme" equalTo:@"YES"];
    [quer findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
         NSLog(@"%@",objects);
        if (objects.count!=0) {
            _m_userProfile.hidden=NO;
        }
    }];
    YourFriendViewController *lvc=[[YourFriendViewController alloc] init];
   
    
}
-(IBAction)pressedLeftBarButton:(id)sender
{
        CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
        if (screenRect.size.height == 548 ||screenRect.size.height == 568)
        {
         [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
         [self.navigationController popViewControllerAnimated:YES];
        }
    
    
}

-(void)pressedRightBarButton:(id)sender
{
    SettingsViewController *svc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"settingsView"];
    [self.navigationController pushViewController:svc animated:YES];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_imageData appendData:data]; // Build the image
}

// Called when the entire image is finished downloading
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // Set the image in the header imageView
    _m_ImageFriends.image = [UIImage imageWithData:_imageData];
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

- (IBAction)buttonFriendsOfFriends:(id)sender
{
    FriendOfFriendViewController *svc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"FriendOfFriendView"];
    [self.navigationController pushViewController:svc animated:YES];
}

- (IBAction)ButtonLikes:(id)sender
{
    [sender setTitle:@"8" forState:UIControlStateNormal];
}

- (IBAction)buttonRequestChat:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"CHAT REQUEST" message:@"Would you like to send a request?" delegate:self cancelButtonTitle:@"Cancel request" otherButtonTitles:@"Send request",nil ];
    [alert show];
}

- (IBAction)buttonFaceBook:(id)sender
{
    NSString *requestPath = @"me/friends/?fields=name,location,gender,birthday,relationship_status,picture,email,id";
    FBRequest *request = [[FBRequest    alloc] initWithSession:[PFFacebookUtils session] graphPath:requestPath];
    if (request.session.isOpen)
    {
        MBProgressHUD *view =[MBProgressHUD  showHUDAddedTo:self.view animated:YES];
        [view  setLabelText:@"Getting Friends"];
        [request    startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error)
         {
             NSLog(@"%@ os request",result);
             [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSMutableArray *data = [[NSMutableArray alloc] initWithArray:[result    objectForKey:@"data"]];
             _m_ArrFriends=[result objectForKey:@"id"];
             NSLog(@"%@",_m_ArrFriends);
         }];
    }
    PFQuery *queryShowMe=[PFQuery queryWithClassName:@"userData"];
    [queryShowMe whereKey:@"Stranger" equalTo:@"NO"];
    [queryShowMe findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"%@",objects);
        _m_Stranger=[objects valueForKey:@"facebookID"];
        NSLog(@"%@",_m_Stranger);
        for (int i=0;i<objects.count; i++) {
            if ([_m_Stranger[i] isEqualToString:_m_iduser]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Warning" message:@"User Secure There Profile" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            break;
        }
        else{
            NSString *go2=[NSString stringWithFormat:@"http://www.facebook.com/%@",_m_iduser];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:go2]];
        }
        }
    }];
}

- (IBAction)userProfile:(id)sender {
    ProfileViewController *ivc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"profileView"];
    ivc.isHomeView=NO;
    ivc.isMutualView=YES;
    ivc.isDeleteView=NO;
    
   ivc.m_userMutualID=_m_iduser;
    [self.navigationController pushViewController:ivc animated:YES];
//    ImageViewController *iivc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"ImageViewController"];
//    iivc.isSettingView=NO;
//    iivc.isMutualView=YES;
//    iivc.m_userMutualID=_m_iduser;
//    iivc.isHomeView=NO;
}

- (IBAction)m_userProfile:(id)sender {
}
- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val = [[kv objectAtIndex:1]
                         stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [params setObject:val forKey:[kv objectAtIndex:0]];
    }
    return params;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Send request"])
    {
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"facebookID==%@",_m_iduser];
        PFQuery *query=[PFQuery queryWithClassName:@"userData" predicate:predicate];
        [query whereKey:@"facebookID" equalTo:_m_iduser];
        NSLog(@"%@",_m_iduser);
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
        {
            
            if (objects.count==0)
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Uh Oh! They Don’t have the App" message:@"Invite them to use the app!" delegate:self cancelButtonTitle:@"Naa Cold Feet" otherButtonTitles:@"Send App Request", nil];
                [alert show];
            }
            else
            {
                UIAlertView *alert1=[[UIAlertView alloc] initWithTitle:@"Uh Oh! They Don’t have the App" message:@"Invite them to use the app!" delegate:self cancelButtonTitle:@"Naa Cold Feet" otherButtonTitles:@"Send App Request", nil];
                
                NSString *msgStr=[NSString stringWithFormat:@"You Have Friend request from Someone"];
                NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                                               msgStr, @"alert",
                                               @"Increment", @"badge",
                                               @"cheering.caf", @"sound",
                                               nil];
                NSLog(@"%@------%@",_mainUserID,_m_iduser);
                PFQuery *uery=[PFQuery queryWithClassName:@"Message"];
                [uery whereKey:@"senderID" equalTo:_mainUserID];
                [uery whereKey:@"ReceiverID" equalTo:_m_iduser];
                
                
                [uery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                    
                    NSDate *date = [NSDate date];
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    [formatter setDateFormat:@"hh:mm a"];
                    NSString* response=[object objectForKey:@"response"];
                                       
                    
                    
                    if ([response length]!=0 && object)
                    {
                        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Unsuccess" message:@"You have already sent request to this use" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                        
                        [alert show];
                    }
                    else
                    {
                        PFObject * newObject = [PFObject    objectWithClassName:@"Message"];
                        
                        NSLog(@"%@ is obj", newObject.objectId);
                        
                        newObject[@"senderID"] = _mainUserID;
                        newObject [@"ReceiverID"]= _m_iduser;
                        newObject [@"response"] = @"NO";
                        newObject [@"messageSend"]= @"Sent Request";
                        newObject [@"chatTime_Sender"] = [formatter stringFromDate:date];
                        newObject [@"status"]=@"GET";
                        [newObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            
                            PFQuery *getObject = [PFQuery   queryWithClassName:@"Message"];
                            
                            [getObject  getObjectInBackgroundWithId:newObject.objectId block:^(PFObject *object, NSError *error) {
                                
                                object [@"messageRecive"] = newObject.objectId;
                                object [@"objectID"] = newObject.objectId;
                                
                                [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                    
                                    if (succeeded == YES)
                                    {
                                        PFQuery *pushQuery = [PFInstallation query];
                                        [pushQuery whereKey:@"user" equalTo:_m_iduser];
                                        
                                        // Send push notification to query
                                        PFPush *push = [[PFPush alloc] init];
                                        [push setQuery:pushQuery];
                                        [push   setData:data];
                                        
//                                        [push setChannel:@"global"];// Set our Installation query
                                        [push sendPushInBackground];
                                        
                                        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Request sent .Wait for response" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                                        
                                        [alert show];
                                    }
                                    
                                }];
                            }];
                            
                        }];
                        
                     
                        
                    }
                   
                }];
                
                
                // Notify table view to reload the recipes from Parse cloud
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
                // Dismiss the controller
                
                [self dismissViewControllerAnimated:YES completion:nil];
                //                SPHViewController * vc=[[SPHViewController alloc] initWithNibName:@"SPHViewController" bundle:nil];
                //
                //
                //                [self.navigationController pushViewController:vc animated:YES];
                //                vc.isAssignView=NO;
                //                vc.isMessageView=YES;
                //
                //                                        vc.isAssignView=YES;
                //                        vc.isMessageView=NO;
                //
                //        vc.user_ID=_mainUseID;
                //        vc.messangername=_m_nameFriend;
                //      //  vc.message_image=_pictureURL;
                //        vc.messangerID=_m_iduser;
                
                
            }
        }];
    }
    else if([title isEqualToString:@"Cancel request"])
    {
        NSLog(@"Button 2 was selected.");
    }
    if ([title isEqualToString:@"ok"])
    {
        NSLog(@"dsfd");
    }
    if ([title isEqualToString:@"Send App Request"])
    {
        
        //                  Send App Request ........
        NSArray *suggestedFriends = [[NSArray alloc] initWithObjects:
                                     _mainID,
                                     nil];
        
        
        
        // Create a dictionary of key/value pairs which are the parameters of the dialog
        
        // 1. No additional parameters provided - enables generic Multi-friend selector
        NSMutableDictionary* params =   [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         // 2. Optionally provide a 'to' param to direct the request at a specific user
                                         _mainID, @"to", // Ali
                                         // 3. Suggest friends the user may want to request, could be game context specific?
                                         //[suggestedFriends componentsJoinedByString:@","], @"suggestions",
                                         @"data",
                                         nil];
        
        [FBWebDialogs presentRequestsDialogModallyWithSession:nil
                                                      message:[NSString stringWithFormat:@"I just smashed  friends! Can you beat it?"]
                                                        title:@"Smashing!"
                                                   parameters:params
                                                      handler:^(FBWebDialogResult result,
                                                                NSURL *resultURL,
                                                                NSError *error) {
                                                          if (error) {
                                                              // Case A: Error launching the dialog or sending request.
                                                              NSLog(@"Error sending request.");
                                                          } else {
                                                              if (result == FBWebDialogResultDialogNotCompleted) {
                                                                  // Case B: User clicked the "x" icon
                                                                  NSLog(@"User canceled request.");
                                                              } else {
                                                                  NSLog(@"Request Sent.");
                                                              }
                                                          }
                                                          
                                                      }];
        //        [FBWebDialogs
        //         presentRequestsDialogModallyWithSession:nil
        //         message:@"Your friend is on DatingApp"
        //         title:@"DatingApp"
        //         parameters:nil
        //         handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
        //             if (error) {
        //                 // Error launching the dialog or sending the request.
        //                 NSLog(@"Error sending request.");
        //                 UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Message" message:@"App Request is not Completed. Try Again... " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //                 [alert show];
        //             } else {
        //                 if (result == FBWebDialogResultDialogNotCompleted) {
        //                     // User clicked the "x" icon
        //                     NSLog(@"User canceled request.");
        //                     UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Message" message:@"App Request Canceled " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //                     [alert show];
        //                 } else {
        //                     // Handle the send request callback
        //                    NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
        //                     if (![urlParams valueForKey:@"request"]) {
        //                         // User clicked the Cancel button
        //                         NSLog(@"User canceled request.");
        //                         UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Message" message:@"App Request Canceled " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //                         [alert show];
        //                     } else {
        //                         // User clicked the Send button
        //                       NSString *requestID = [urlParams valueForKey:@"request"];
        //                         NSLog(@"Request ID: %@", resultURL);
        //                         UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Message" message:@"App Request send to your Friend " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //                         [alert show];
        //                   }
        //                 }
        //             }
        //         }];
        //
    }
    
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    //                                      Chat Try                                                      //
    
    if (alertView.tag == 4)
    {
        NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
        PFQuery *query = [PFQuery queryWithClassName:@"userData"];
        [query selectKeys:@[@"facebookID"]];
        [query whereKey:@"facebookID" equalTo:_m_iduser];
        
        
        if ([title isEqualToString:@"Send Chat Request"])
        {
            
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
             
             
             {
                 
                 if(!error)
                 {
                     if(objects.count == 0)
                         
                     {
                         
                         NSLog(@"send App reuest");
                         
                     }
                     else
                     {// code for sending message
                         PFObject *chatRequest=[PFObject objectWithClassName:@"Inbox"];
                         //  [recipe setObject:_mainUseID forKey:@"facebookID"];
                         [chatRequest setObject:[NSString stringWithFormat:@"%@",_mainUserID] forKey:@"Sender_FBID"];
                         [chatRequest setObject:[NSString stringWithFormat:@"%@",_m_iduser] forKey:@"Receiver_FBID"
                          ];
                         [chatRequest setObject:[NSString stringWithFormat:@"Hi"] forKey:@"Sent_Message"];
                         [chatRequest saveInBackground];
                         NSLog(@"control Reaching ");
                         
                         
                         
                         
                         
                     }
                 }
                 else
                 {
                     NSLog(@"no result found");
                 }
                 
                 
             }
             ];
            
        }
        else
        {
            NSLog(@"Cancel");
        }
    }
    
}


- (NSString *) timeStamp
{
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
}




#pragma Chat Try

- (IBAction)requestButtonClicked:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"CHAT REQUEST !" message:@"Would you like to send a request for Chat?" delegate:self cancelButtonTitle:@"Cancel Chat request" otherButtonTitles:@"Send Chat Request",nil ];
    
    alert.tag = 4;
    [alert show];
    
}

@end

