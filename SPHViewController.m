//
//  SPHViewController.m
//  SPHChatBubble
//
//  Created by Siba Prasad Hota  on 10/18/13.
//  Copyright (c) 2013 Wemakeappz. All rights reserved.
//
#import "MutiualFriendViewController.h"
#import "SPHViewController.h"
#import "SPHChatData.h"
#import "WebViewController.h"
#import "SPHChatData.h"
#import "SPHBubbleCell.h"
#import "SPHBubbleCellImage.h"
#import "SPHBubbleCellImageOther.h"
#import "SPHBubbleCellOther.h"
#import <QuartzCore/QuartzCore.h>
#import "AsyncImageView.h"
#import "MHFacebookImageViewer.h"
#import "QBPopupMenu.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "SPHAppDelegate.h"
#import <Parse/Parse.h>
#import "YCameraViewController.h"
#import "BuyCoinsViewController.h"
#import "ProfileViewController.h"
#define messageWidth 260

@interface SPHViewController ()

@property (strong,nonatomic) UIImageView * userImage;
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString * sendMessage;
@property (strong,nonatomic) NSString * sendTime;
@property (strong,nonatomic) NSString * reciveMessage;
@property (strong,nonatomic) NSString * reciveTime;

@property (strong,nonatomic) NSString *parse_Receiver;
@property (strong,nonatomic) NSString *parse_Sender;

@property (strong,nonatomic) NSString *device_Receiver;
@property (strong,nonatomic) NSString *device_Sender;
@property (strong,nonatomic) NSString *object_ID;

@property (strong,nonatomic) UIImage*image_send;
@property (strong,nonatomic) UIImage*image_recive;
@property (strong,nonatomic) UIImage*image_send1;
@property (strong,nonatomic) UIImage*image_recive1;
@end

@implementation SPHViewController

@synthesize pullToRefreshManager = pullToRefreshManager_;
@synthesize reloads = reloads_;

@synthesize imgPicker;
@synthesize Uploadedimage;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
 isLoading = NO;
    
  //  SPHAppDelegate *MyWatcher = [[UIApplication sharedApplication] delegate];
  //  MyWatcher.currentViewController = self;
    self.navigationItem.title = @"Chatting";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"red srtripe.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Verdana" size:20],
      NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName, nil]];
        UIImage* image32 = [UIImage imageNamed:@"heart_fof.png"];
        CGRect frameimg2 = CGRectMake(0, 0, 25, 25);
        UIButton *someButton2 = [[UIButton alloc] initWithFrame:frameimg2];
        [someButton2 setBackgroundImage:image32 forState:UIControlStateNormal];
        [someButton2 addTarget:self action:@selector(pressedRightBarButton:)
              forControlEvents:UIControlEventTouchUpInside];
        someButton2.layer.cornerRadius=5.0f;
        [someButton2 setShowsTouchWhenHighlighted:YES];
     _rightBarButton =[[UIBarButtonItem alloc] initWithCustomView:someButton2];
     self.navigationItem.rightBarButtonItem=_rightBarButton;
    sphBubbledata=[[NSMutableArray alloc]init];
    [self setUpTextFieldforIphone];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    pullToRefreshManager_ = [[MNMPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f
                                                                                   tableView:self.sphChatTable
                                                                                  withClient:self];
//    [self setUpDummyMessages];
    
//    _userImage.image=[UIImage imageNamed:@"my_icon.png"];
	// Do any additional setup after loading the view, typically from a nib.
    PFQuery *query=[PFQuery queryWithClassName:@"userData"];
    [query whereKey:@"facebookID" equalTo:_messangerID];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        
            _notShowMEView=YES;
            _isShowMeView=NO;
            someButton2.hidden=NO;
        
    }];
    if(!timer)
    {
   // timer=[NSTimer scheduledTimerWithTimeInterval:0.6 target:self selector:@selector(handleRefresh:) userInfo:nil repeats:YES];
    }
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
   // [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.sphChatTable addSubview:refreshControl];
}
- (IBAction)stopTimer:(id)sender {
    if ([timer isValid]) {
        [timer invalidate];
    }
    timer = nil;
}
-(IBAction)pressedRightBarButton:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Find Messanger" message:@"You Have to spend 3 coins to find MESSANGEER" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Find", nil];
    [alert show];
}

- (void)handleRefresh:(id)sender
{


//    PFQuery * quertSort=[PFQuery queryWithClassName:@"Message"];
//    [quertSort whereKey:@"messangerID" equalTo:_messangerID];
//    [quertSort whereKey:@"userID" equalTo:_user_ID];
//    [quertSort orderByAscending:@"createdAt"];
//    {
//        PFQuery *query=[PFQuery queryWithClassName:@"Message"];
//        [query whereKey:@"reciverID" equalTo:_user_ID];
//        [query whereKey:@"senderID" equalTo:_messangerID];
//        NSLog(@"%@=",_user_ID);
//        NSLog(@"%@===",_messangerID);
//        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            //   NSString * rowNumber=[NSString stringWithFormat:@"%d",objects.count];
//             [sphBubbledata removeAllObjects];
//            
//            
//            for (PFObject * object in objects) {
//                NSString * message=[object objectForKey:@"messageRecive" ];
//                NSString * message1=[object objectForKey:@"messagesSend" ];
//                NSString * time=[object objectForKey:@"ChatTime"];
//                
//                NSLog(@"%@",time);
//                
////                if (message.length) {
//                    [self adddBubbledata:@"textByme" mtext:message mtime:time mimage:Uploadedimage.image msgstatus:@"Sending"];
////                }
////                else if (message1.length)
////                {
//                    [self adddBubbledata:@"textbyother" mtext:message1 mtime:time mimage:Uploadedimage.image msgstatus:@"Sending"];
////                }
//                
//                
//                
//                //[self performSelector:@selector(messageSent:) withObject:rowNumber afterDelay:2.0];
//            }
//        }];
//    UITableViewController *tableViewController = [[UITableViewController alloc] init];
//    tableViewController.tableView = self.sphChatTable;
//       
//   // [self.sphChatTable reloadData];
//   // [tableViewController.refreshControl endRefreshing];
//    
//}
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
     NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
       PFQuery *query=[PFQuery queryWithClassName:@"userData"];
    [query whereKey:@"facebookID" equalTo:_user_ID];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        NSString *userImage=[object objectForKey:@"profilepic"];
        NSString *coin=[object objectForKey:@"noOfcoins"];
        int nocoin=[coin intValue];
//        NSLog(@"%d",nocoin);
        if([title isEqualToString:@"Find"])
        {
            if (nocoin!=0) {
            PFQuery *query1=[PFQuery queryWithClassName:@"Message"];
            [query1 whereKey:@"senderID" equalTo:_user_ID];
            [query1 whereKey:@"reciverID" equalTo:_messangerID];
            [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                UIImage *im = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:userImage]]];
                NSString * str;
                _userImage.image=im;
                for (PFObject * object in objects) {
                    _userName=[object objectForKey:@"chatWith"];
                  // str=[NSString stringWithFormat:];
                }
            }];
            PFQuery *queryCoin = [PFQuery queryWithClassName:@"userData"];
//            NSLog(@"%@    %@",_user_ID,_messangerID);
            [queryCoin whereKey:@"facebookID" equalTo:_user_ID];
            [queryCoin getFirstObjectInBackgroundWithBlock:^(PFObject *objects, NSError *error){
                if (!error) {
//                    NSLog(@"%@",objects);
                    NSString *strCoin=[NSString stringWithFormat:@"%d",nocoin-3];
                    objects [@"noOfcoins"]=strCoin;
//                    NSLog(@"%@",strCoin);
                    [objects saveInBackground];
                UIAlertView * alert=[[UIAlertView alloc] initWithTitle:@"Message" message:_userName delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"View Profile", nil];
                [alert show];
                }
            }];
        }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"you have no coin in you account" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Buy Coins", nil];
                [alert show];
            }
        }
        else
        {
            _userImage.image=[UIImage imageNamed:@"my_icon.png"];
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults setObject:_userImage forKey:@"messangerImage"];
            [defaults synchronize];
        }
           }];
    if ([title isEqualToString:@"Buy Coins"]) {
        BuyCoinsViewController *pvc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"BuyCoinsView"];
//        pvc.m_nameFriend=_userName;
//        pvc.m_iduser=_messangerID;
        [self.navigationController pushViewController:pvc animated:YES];
    }
    if ([title isEqualToString:@"View Profile"]) {
        ProfileViewController *ivc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"profileView"];
        ivc.isHomeView=NO;
        ivc.isMutualView=YES;
        ivc.isDeleteView=NO;
        
        ivc.m_userMutualID=_messangerID;
        [self.navigationController pushViewController:ivc animated:YES];
    }
}

- (void)handleURL:(NSURL*)url
{
    WebViewController *controller = [[[WebViewController alloc] initWithURL:url] autorelease];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

//-(void)setUpDummyMessages
//{
//    if (_isAssignView==YES) {
//        PFQuery *query=[PFQuery queryWithClassName:@"userData"];
//        //    [query whereKey:@"showme" equalTo:@"NO"];
//        [query whereKey:@"facebookID" equalTo:_messangerID];
//        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//            NSString *showme=[object objectForKey:@"showme"];
//            if ([showme isEqualToString:@"NO"]) {
//                _notShowMEView=YES;
//                _isShowMeView=NO;
//                NSDate *date = [NSDate date];
//                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                [formatter setDateFormat:@"hh:mm a"];
//                NSString *rowNumber=[NSString stringWithFormat:@"%d",sphBubbledata.count];
//                [self adddBubbledata:@"textByme" mtext:@"Hi!!!!!!!" mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sending" ];
//                [self performSelector:@selector(messageSent:) withObject:rowNumber afterDelay:1.0];
//                [self adddBubbledata:@"textbyother" mtext:@"Heloo!!!!!" mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sent"];
//                rowNumber=[NSString stringWithFormat:@"%d",sphBubbledata.count];
//                [self adddBubbledata:@"textByme" mtext:@"How are you doing today?" mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sending"];
//                
//                [self performSelector:@selector(messageSent:) withObject:rowNumber afterDelay:1.5];
//                
//                [self adddBubbledata:@"textbyother" mtext:@"I'm doing great! what abt you?" mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sent"];
//                PFObject *ObjectSave=[PFObject objectWithClassName:@"Message"];
//                {
//                    ObjectSave[@"message"]=@"Start Chat";
//                    ObjectSave[@"messagesSend"]=@"Start Chat";
//                    ObjectSave[@"userID"]=_user_ID;
//                    ObjectSave[@"messangeID"]=_messangerID;
//                    ObjectSave[@"chatWith"]=_messangername;
//                    // ObjectSave[@"primaryKey"]=date;
//                    ObjectSave[@"ChatTime"]=[formatter stringFromDate:date];
//                    ObjectSave[@"senderID"]=_user_ID;
//                    ObjectSave[@"reciverID"]=_messangerID;
//                    
//                    [ObjectSave saveInBackground];
//                }
//            }
//            else if([showme isEqualToString:@"YES"])
//            {
//                _isShowMeView=YES;
//                _notShowMEView=NO;
//                PFQuery *query=[PFQuery queryWithClassName:@"userData"];
//                [query whereKey:@"facebookID" equalTo:_messangerID];
//                [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
//                    NSString *userImage=[object objectForKey:@"profilepic"];
//                    //    UIImage *im = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:userImage]]];
//                    _userImage.image=[UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:userImage]]];
//                    
//                    //                    NSLog(@"%@",_userImage.image);
//                    
//                    NSDate *date = [NSDate date];
//                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                    [formatter setDateFormat:@"hh:mm a"];
//                    NSString *rowNumber=[NSString stringWithFormat:@"%d",sphBubbledata.count];
//                    [self adddBubbledata:@"textByme" mtext:@"Hi!!!!!!!" mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sending"];
//                    [self performSelector:@selector(messageSent:) withObject:rowNumber afterDelay:1.0];
//                    [self adddBubbledata:@"textbyother" mtext:@"Heloo!!!!!" mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sent"];
//                    rowNumber=[NSString stringWithFormat:@"%d",sphBubbledata.count];
//                    [self adddBubbledata:@"textByme" mtext:@"How are you doing today?" mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sending"];
//                    [self performSelector:@selector(messageSent:) withObject:rowNumber afterDelay:1.5];
//                    [self adddBubbledata:@"textbyother" mtext:@"I'm doing great! what abt you?" mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sent"];
//                    
//                    PFObject *ObjectSave=[PFObject objectWithClassName:@"Message"];
//                    {
//                        ObjectSave[@"message"]=@"Start Chat";
//                        ObjectSave[@"messagesSend"]=@"Start Chat";
//                        ObjectSave[@"userID"]=_user_ID;
//                        ObjectSave[@"messangeID"]=_messangerID;
//                        
//                        ObjectSave[@"chatWith"]=_messangername;
//                        // ObjectSave[@"primaryKey"]=date;
//                        ObjectSave[@"ChatTime"]=[formatter stringFromDate:date];
//                        ObjectSave[@"senderID"]=_user_ID;
//                        ObjectSave[@"reciverID"]=_messangerID;
//                        
//                        [ObjectSave saveInBackground];
//                    }
//                    PFObject *ObjectSave1=[PFObject objectWithClassName:@"Message"];
//                    {
//                        ObjectSave1[@"message"]=@"Start Chat";
//                        ObjectSave1[@"messagesSend"]=@"Start Chat";
//                        ObjectSave1[@"userID"]=_messangerID;
//                        ObjectSave1[@"messangeID"]=_user_ID;
//                        
//                        ObjectSave1[@"chatWith"]=_messangername;
//                        // ObjectSave1[@"primaryKey"]=date;
//                        ObjectSave1[@"ChatTime"]=[formatter stringFromDate:date];
//                        ObjectSave1[@"senderID"]=_user_ID;
//                        ObjectSave1[@"reciverID"]=_messangerID;
//                        
//                        [ObjectSave1 saveInBackground];
//                    }
//                    
//                }];
//                // Do any additional setup after loading the view, typically from a nib.
//            }
//        }];
//    }
//    else if (_isMessageView==YES) {
//        //        PFQuery * quertSort=[PFQuery queryWithClassName:@"Message"];
//        //        [quertSort whereKey:@"messangerID" equalTo:_messangerID];
//        //        [quertSort whereKey:@"userID" equalTo:_user_ID];
//        //        [quertSort orderByAscending:@"createdAt"];
//        //        {
//        //        PFQuery *query=[PFQuery queryWithClassName:@"Message"];
//        //        [query whereKey:@"reciverID" equalTo:_user_ID];
//        //            [query whereKey:@"senderID" equalTo:_messangerID];
//        //        NSLog(@"%@=",_user_ID);
//        //         NSLog(@"%@===",_messangerID);
//        //        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        //         //   NSString * rowNumber=[NSString stringWithFormat:@"%d",objects.count];
//        //            for (PFObject * object in objects) {
//        //                NSString * message=[object objectForKey:@"messageRecive" ];
//        //                    NSString * message1=[object objectForKey:@"messagesSend" ];
//        //                NSString * time=[object objectForKey:@"ChatTime"];
//        //
//        //                NSLog(@"%@",time);
//        //
//        //             //   if (message.length) {
//        //                      [self adddBubbledata:@"textByme" mtext:message mtime:time mimage:Uploadedimage.image msgstatus:@"Sending"];
//        //               // }
//        //               // else if (message1.length)
//        //              //  {
//        //                    [self adddBubbledata:@"textbyother" mtext:message1 mtime:time mimage:Uploadedimage.image msgstatus:@"Sending"];
//        //              //  }
//        //
//        //
//        //
//        //                //[self performSelector:@selector(messageSent:) withObject:rowNumber afterDelay:2.0];
//        //            }
//        //        }];
//        //        PFQuery *query1=[PFQuery queryWithClassName:@"Message"];
//        //        [query1 whereKey:@"senderID" equalTo:_user_ID];
//        //        [query1 whereKey:@"reciverID" equalTo:_messangerID];
//        //        [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        //            //NSString * rowNumber=[NSString stringWithFormat:@"%d",objects.count];
//        //            for (PFObject * object in objects) {
//        //                NSString * message=[object objectForKey:@"messagesSend" ];
//        //                NSString * time=[object objectForKey:@"ChatTime"];
//        //                [self adddBubbledata:@"textbyother" mtext:message mtime:time mimage:Uploadedimage.image msgstatus:@"Sending"];
//        //               // [self performSelector:@selector(messageSent:) withObject:rowNumber afterDelay:2.0];
//        //            }
//        //        }];
//        //        }
//    }
//}


#pragma mark MNMBottomPullToRefreshManagerClient

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [pullToRefreshManager_ tableViewScrolled];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y >=360.0f)
    {
    }
    else
        [pullToRefreshManager_ tableViewReleased];
}

- (void)pullToRefreshTriggered:(MNMPullToRefreshManager *)manager
{
    reloads_++;
    [self performSelector:@selector(getEarlierMessages) withObject:nil afterDelay:0.0f];
}

-(void)getEarlierMessages
{
//    NSLog(@"get Earlir Messages And Appand to Array");
     [self performSelector:@selector(loadfinished) withObject:nil afterDelay:1];
}

-(void)loadfinished
{
    [pullToRefreshManager_ tableViewReloadFinishedAnimated:YES];
    [self.sphChatTable reloadData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpTextFieldforIphone
{
    containerView = [[UIView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height-40, 320, 40)];
    textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(40, 3, 206, 40)];
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
	textView.minNumberOfLines = 1;
	textView.maxNumberOfLines = 6;
	textView.returnKeyType = UIReturnKeyDefault; //just as an example
	textView.font = [UIFont systemFontOfSize:15.0f];
	textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor whiteColor];
    // textView.text = @"test\n\ntest";
	// textView.animateHeightChange = NO; //turns off animation
    [self.view addSubview:containerView];
    UIImage *rawEntryBackground = [UIImage imageNamed:@"MessageEntryInputField.png"];
    UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *entryImageView = [[UIImageView alloc] initWithImage:entryBackground];
    entryImageView.frame = CGRectMake(40, 0,210, 40);
    entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    UIImage *rawBackground = [UIImage imageNamed:@"MessageEntryBackground.png"];
    UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:13 topCapHeight:22];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:background];
    imageView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    // view hierachy
    [containerView addSubview:imageView];
    [containerView addSubview:textView];
    [containerView addSubview:entryImageView];
    UIImage *sendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
    UIImage *camBtnBackground = [[UIImage imageNamed:@"cam.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    UIImage *selectedSendBtnBackground = [[UIImage imageNamed:@"MessageEntrySendButton.png"] stretchableImageWithLeftCapWidth:13 topCapHeight:0];
	UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	doneBtn.frame = CGRectMake(containerView.frame.size.width - 69, 8, 63, 27);
    doneBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
	[doneBtn setTitle:@"send" forState:UIControlStateNormal];
    [doneBtn setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
    doneBtn.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
    doneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[doneBtn addTarget:self action:@selector(resignTextView) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setBackgroundImage:sendBtnBackground forState:UIControlStateNormal];
    [doneBtn setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
	[containerView addSubview:doneBtn];
    UIButton *doneBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
	doneBtn2.frame = CGRectMake(containerView.frame.origin.x+1,2, 35,40);
    doneBtn2.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
	[doneBtn2 setTitle:@"" forState:UIControlStateNormal];
    [doneBtn2 setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.4] forState:UIControlStateNormal];
    doneBtn2.titleLabel.shadowOffset = CGSizeMake (0.0, -1.0);
    doneBtn2.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    [doneBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[doneBtn2 addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn2 setBackgroundImage:camBtnBackground forState:UIControlStateNormal];
    //[doneBtn2 setBackgroundImage:selectedSendBtnBackground forState:UIControlStateSelected];
	[containerView addSubview:doneBtn2];
    containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}

-(void)resignTextView
{
    if ([textView.text length]<1)
    {
        NSLog(@"jk");
    }
    else
    {
        NSString *chat_Message=textView.text;
        textView.text=@"";
        NSDate *date = [NSDate date];
//        NSLog(@"%@",date);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateFormat:@"hh:mm a"];

        
        if ([_device_Sender isEqualToString:_parse_Sender])
        {
            SPHChatData *data = [sphBubbledata  lastObject];
            
            NSString * senderMsg = [data.messageChatValues objectForKey:@"messageSend"];
            NSString * objectID = [data.messageChatValues objectForKey:@"objectID"];
            
//            if ([objectID isEqualToString: senderMsg])
//            {
//                
//                PFQuery *query = [PFQuery queryWithClassName:@"Message"];
//                
//                [query getObjectInBackgroundWithId:objectID block:^(PFObject *object, NSError *error) {
//                    
//                    object[@"messageSend"] = chat_Message;
//                    object[@"primaryKey"]=[NSString stringWithFormat:@"%@",_primaryKey];
//                    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                        
//                        if (succeeded)
//                        {
//                          //  [self adddBubbledata:@"textByme" mtext:chat_Message mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sending" withDic:object];
//                        }
//                        
//                    }];
//                }];
//                
//            }
//            else
//            {
                PFObject * newObject = [PFObject    objectWithClassName:@"Message"];
                NSDate *date = [NSDate date];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"hh:mm a"];
                
//                NSData* data = UIImageJPEGRepresentation(Uploadedimage.image, 0.5f);
//                PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
            
                NSLog(@"%@ is obj", newObject.objectId);
                
                newObject[@"senderID"] = _parse_Sender;
                newObject [@"ReceiverID"]= _parse_Receiver;
                newObject [@"response"] = @"YES";
                newObject [@"messageSend"]= chat_Message;
//                newObject[@"image_send"]=imageFile;
                newObject [@"chatTime_Sender"] = [formatter stringFromDate:date];
                newObject [@"status"]=@"START";
                
                [newObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    
                    if (succeeded) {
                        
                        PFQuery *query = [PFQuery queryWithClassName:@"Message"];
                        
                        [query getObjectInBackgroundWithId:newObject.objectId block:^(PFObject *object, NSError *error) {
                            
                            object[@"messageRecive"] = newObject.objectId;
                            object[@"objectID"] = newObject.objectId;
                            
                            object[@"primaryKey"]=[NSString stringWithFormat:@"%@",_primaryKey];
                            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                
                                if (succeeded)
                                {
                                 //   [self adddBubbledata:@"textByme" mtext:chat_Message mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sending" withDic:object] ;
                                }
                                
                            }];
                            
                        }];
                        
                    }
                    
                }];
                
                
            }
//        }
        else
        {
            SPHChatData *data = [sphBubbledata  lastObject];
            
            NSString * senderMsg = [data.messageChatValues objectForKey:@"messageRecive"];
            NSString * objectID = [data.messageChatValues objectForKey:@"objectID"];

//            if ([objectID isEqualToString: senderMsg])
//            {
//                
//                PFQuery *query = [PFQuery queryWithClassName:@"Message"];
//                
//                [query getObjectInBackgroundWithId:objectID block:^(PFObject *object, NSError *error) {
//                    
//                    NSData* data = UIImageJPEGRepresentation(Uploadedimage.image, 0.5f);
//                    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
//                    
//                    object[@"messageRecive"] = chat_Message;
//                    object[@"primaryKey"]=[NSString stringWithFormat:@"%@",_primaryKey];
//
//
//                    [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                        
//                        if (succeeded)
//                        {
//                          //  [self adddBubbledata:@"textByme" mtext:chat_Message mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sending" withDic:object];
//                        }
//                        
//                    }];
//                }];
//                
//            }
//            else
//            {
                PFObject * newObject = [PFObject    objectWithClassName:@"Message"];
                NSDate *date = [NSDate date];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"hh:mm a"];
                
//                NSData* data = UIImageJPEGRepresentation(Uploadedimage.image, 0.5f);
//                PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
            
                NSLog(@"%@ is obj", newObject.objectId);
                
                newObject[@"senderID"] = _parse_Sender;
                newObject [@"ReceiverID"]= _parse_Receiver;
                newObject [@"response"] = @"YES";
//                newObject [@"image_Receive"] = imageFile;

                newObject [@"messageRecive"]= chat_Message;
                newObject [@"chatTime_Receive"] = [formatter stringFromDate:date];
                newObject [@"status"]=@"START";
                
                [newObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    
                    if (succeeded) {
                        
                        PFQuery *query = [PFQuery queryWithClassName:@"Message"];
                        
                        [query getObjectInBackgroundWithId:newObject.objectId block:^(PFObject *object, NSError *error) {
                            
                            object[@"messageSend"] = newObject.objectId;
                            object[@"objectID"] = newObject.objectId;
                            object[@"primaryKey"]=[NSString stringWithFormat:@"%@",_primaryKey];

                            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                                
                                if (succeeded)
                                {
                                   // [self adddBubbledata:@"textByme" mtext:chat_Message mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sending" withDic:object] ;
                                }
                                
                            }];
                            
                        }];
                        
                    }
                    
                }];
                
                
            }
//        }
        
        
//        PFQuery *getObject  = [PFQuery queryWithClassName:@"Message"];
//        [getObject   whereKey:@"senderID" equalTo:_user_ID];
//        [getObject whereKey:@"ReceiverID" equalTo:_messangerID];
//        [getObject  whereKey:@"Response" equalTo:@"YES"];
//        [getObject orderByDescending:@"createdAt"];
//        
//        [getObject getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error)
//        {
//            
//            NSLog(@"%@ is object", object);
//            
//            
//            
//        }];
        
        
        // Create a pointer to an object of class UserStats with id dlkj83d
//        PFObject *userStats = [PFObject objectWithoutDataWithClassName:@"UserStats" objectId:@"dlkj83d"];
//        
//        // Set a new value on quantity
//        [userStats setObject:newScore forKey:@"latestScore"];
//        
//        // Save
//        [userStats save];
//        
//           PFObject *ObjectRecive=[PFObject objectWithClassName:@"Message"];
//           {
//               NSString *timeStamp = [self timeStamp];
//               
//               ObjectRecive [@"objectID"] = ObjectRecive.objectId;
//               ObjectRecive[@"messageRecive"]= ObjectRecive.objectId;
//               ObjectRecive[@"messageSend"]=chat_Message;
//               ObjectRecive[@"ReceiverID"]=_messangerID;
//               ObjectRecive[@"ChatTime_Sender"]  = timeStamp;
//               ObjectRecive[@"primaryKey"]  = timeStamp;
//               ObjectRecive[@"senderID"]=_user_ID;
//               
//               [ObjectRecive saveInBackground];
//           }
//        
//        [self performSelector:@selector(messageSent:) withObject:rowNumber afterDelay:2.0];
        
    }
}

- (NSString *) timeStamp
{
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
}

-(IBAction)messageSent:(id)sender
{
//    NSLog(@"row= %@", sender);
    SPHChatData *feed_data=[[SPHChatData alloc]init];
    feed_data=[sphBubbledata objectAtIndex:[sender intValue]];
    feed_data.messagestatus=@"Sent";
    [sphBubbledata  removeObjectAtIndex:[sender intValue]];
    [sphBubbledata insertObject:feed_data atIndex:[sender intValue]];
    [self.sphChatTable reloadData];
}

-(IBAction)uploadImage:(id)sender
{
//    YCameraViewController * vc=[[YCameraViewController alloc] initWithNibName:@"YCameraViewController" bundle:nil];
//    [self.navigationController pushViewController:vc animated:YES];
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imgPicker.mediaTypes = [NSArray arrayWithObjects:
                                (NSString *) kUTTypeImage,
                                nil];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
        newMedia = NO;
    }
}
//http://www.binarytribune.com/wp-content/uploads/2013/06/india_binary_options-274x300.png

-(void)imagePickerControllerDidCancel:
(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info
                          objectForKey:UIImagePickerControllerOriginalImage];
        Uploadedimage.image=image;
        if (newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
		// Code here to support video if enabled
	}
   [self performSelector:@selector(uploadToServer) withObject:nil afterDelay:0.0];
}

-(void)uploadToServer
{
    NSDate *date = [NSDate date];
    //        NSLog(@"%@",date);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"hh:mm a"];
    
    
    if ([_device_Sender isEqualToString:_parse_Sender])
    {
        SPHChatData *data = [sphBubbledata  lastObject];
        
        NSString * senderMsg = [data.messageChatValues objectForKey:@"messageSend"];
        NSString * objectID = [data.messageChatValues objectForKey:@"objectID"];
        
        if ([objectID isEqualToString: senderMsg])
        {
            
            PFQuery *query = [PFQuery queryWithClassName:@"Message"];
            
            [query getObjectInBackgroundWithId:objectID block:^(PFObject *object, NSError *error) {
                
                NSData* data = UIImageJPEGRepresentation(Uploadedimage.image, 0.5f);
                PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
                
                object[@"image_send"] = imageFile;
                
                [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    
                    if (succeeded)
                    {
                        //  [self adddBubbledata:@"textByme" mtext:chat_Message mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sending" withDic:object];
                    }
                    
                }];
            }];
            
        }
        else
        {
            PFObject * newObject = [PFObject    objectWithClassName:@"Message"];
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"hh:mm a"];
            
            NSData* data = UIImageJPEGRepresentation(Uploadedimage.image, 0.5f);
            PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
            
            NSLog(@"%@ is obj", newObject.objectId);
            
            newObject[@"senderID"] = _parse_Sender;
            newObject [@"ReceiverID"]= _parse_Receiver;
            newObject [@"response"] = @"YES";
           
            newObject[@"image_send"]=imageFile;
            newObject [@"chatTime_Sender"] = [formatter stringFromDate:date];
            newObject [@"status"]=@"START";
            
            [newObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (succeeded) {
                    
                    PFQuery *query = [PFQuery queryWithClassName:@"Message"];
                    
                    [query getObjectInBackgroundWithId:newObject.objectId block:^(PFObject *object, NSError *error) {
                        
                        object[@"messageRecive"] = newObject.objectId;
                        object[@"objectID"] = newObject.objectId;
                        
                        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            
                            if (succeeded)
                            {
                                //   [self adddBubbledata:@"textByme" mtext:chat_Message mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sending" withDic:object] ;
                            }
                            
                        }];
                        
                    }];
                    
                }
                
            }];
            
            
        }
    }
    else
    {
        SPHChatData *data = [sphBubbledata  lastObject];
        
        NSString * senderMsg = [data.messageChatValues objectForKey:@"messageRecive"];
        NSString * objectID = [data.messageChatValues objectForKey:@"objectID"];
        
        if ([objectID isEqualToString: senderMsg])
        {
            
            PFQuery *query = [PFQuery queryWithClassName:@"Message"];
            
            [query getObjectInBackgroundWithId:objectID block:^(PFObject *object, NSError *error) {
                
                NSData* data = UIImageJPEGRepresentation(Uploadedimage.image, 0.5f);
                PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
                
                object[@"image_recieve"] = imageFile;
                
                
                [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    
                    if (succeeded)
                    {
                        //  [self adddBubbledata:@"textByme" mtext:chat_Message mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sending" withDic:object];
                    }
                }];
            }];
            
        }
        else
        {
            PFObject * newObject = [PFObject    objectWithClassName:@"Message"];
            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"hh:mm a"];
            
            NSData* data = UIImageJPEGRepresentation(Uploadedimage.image, 0.5f);
            PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
            
            NSLog(@"%@ is obj", newObject.objectId);
            
            newObject[@"senderID"] = _parse_Sender;
            newObject [@"ReceiverID"]= _parse_Receiver;
            newObject [@"response"] = @"YES";
            newObject [@"image_Receive"] = imageFile;
            
            
            newObject [@"chatTime_Receive"] = [formatter stringFromDate:date];
            newObject [@"status"]=@"START";
            
            [newObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (succeeded) {
                    
                    PFQuery *query = [PFQuery queryWithClassName:@"Message"];
                    
                    [query getObjectInBackgroundWithId:newObject.objectId block:^(PFObject *object, NSError *error) {
                        
                        object[@"messageSend"] = newObject.objectId;
                        object[@"objectID"] = newObject.objectId;
                        
                        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            
                            if (succeeded)
                            {
                                // [self adddBubbledata:@"textByme" mtext:chat_Message mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sending" withDic:object] ;
                            }
                            
                        }];
                        
                    }];
                    
                }
                
            }];
            
            
        }
    }
    
//    NSString *chat_Message=textView.text;
//    textView.text=@"";
//    NSDate *date = [NSDate date];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"hh:mm a"];
//    NSString *rowNumber=[NSString stringWithFormat:@"%d",sphBubbledata.count];
//
//   // if (sphBubbledata.count%2==0) {
//        [self adddBubbledata:@"ImageByme" mtext:chat_Message mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sending" ];
//   // }else{
//       // [self adddBubbledata:@"ImageByother" mtext:chat_Message mtime:[formatter stringFromDate:date] mimage:Uploadedimage.image msgstatus:@"Sending"];
//   // }
//    [self performSelector:@selector(messageSent:) withObject:rowNumber afterDelay:1.0];
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"\
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return sphBubbledata.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPHChatData *feed_data=[[SPHChatData alloc]init];
    feed_data=[sphBubbledata objectAtIndex:indexPath.row];
    if ([feed_data.messageType isEqualToString:@"textByme"]||[feed_data.messageType isEqualToString:@"textbyother"])
    {
        float cellHeight;
        // text
        NSString *messageText = feed_data.messageText;
        //
        CGSize boundingSize = CGSizeMake(messageWidth-20, 10000000);
        CGSize itemTextSize = [messageText sizeWithFont:[UIFont systemFontOfSize:14]
                                      constrainedToSize:boundingSize
                                          lineBreakMode:NSLineBreakByWordWrapping];
        // plain text
        cellHeight = itemTextSize.height;
        if (cellHeight<25)
        {
            cellHeight=25;
        }
        return cellHeight+30;
    }
    else
    {
        return 140;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.sphChatTable deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPHChatData *feed_data=[[SPHChatData alloc]init];
    feed_data=[sphBubbledata objectAtIndex:indexPath.row];
    NSString *messageText = feed_data.messageText;
    static NSString *CellIdentifier1 = @"Cell1";
    static NSString *CellIdentifier2 = @"Cell2";
    static NSString *CellIdentifier3 = @"Cell3";
    static NSString *CellIdentifier4 = @"Cell4";
    CGSize boundingSize = CGSizeMake(messageWidth-20, 10000000);
    CGSize itemTextSize = [messageText sizeWithFont:[UIFont systemFontOfSize:14]
                                  constrainedToSize:boundingSize
                                      lineBreakMode:NSLineBreakByWordWrapping];
    float textHeight = itemTextSize.height+7;
    int x=0;
    if (textHeight>200)
    {
        x=65;
    }
    else
        if (textHeight>150)
        {
            x=50;
        }
        else if (textHeight>80)
        {
            x=30;
        }
        else
            if (textHeight>50)
            {
                x=20;
            }
            else
                if (textHeight>30)
                {
                    x=8;
                }
        // Types= ImageByme  , imageByOther  textByme  ,textbyother
        if ([feed_data.messageType isEqualToString:@"textByme"]) {
        SPHBubbleCellOther  *cell = (SPHBubbleCellOther *)[self.sphChatTable dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SPHBubbleCellOther" owner:self options:nil];
            cell = [topLevelObjects objectAtIndex:0];
        }
        else
        {
        }
        UIImageView *bubbleImage=[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"Bubbletyperight"] stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
        bubbleImage.tag=55;
        [cell.contentView addSubview:bubbleImage];
        [bubbleImage setFrame:CGRectMake(265-itemTextSize.width,5,itemTextSize.width+14,textHeight+4)];
        UITextView *messageTextview=[[UITextView alloc]initWithFrame:CGRectMake(260 - itemTextSize.width+5,2,itemTextSize.width+10, textHeight-2)];
        [cell.contentView addSubview:messageTextview];
        messageTextview.editable=NO;
        messageTextview.text = messageText;
        messageTextview.dataDetectorTypes=UIDataDetectorTypeAll;
        messageTextview.textAlignment=NSTextAlignmentJustified;
        messageTextview.font=[UIFont fontWithName:@"Helvetica Neue" size:12.0];
        messageTextview.backgroundColor=[UIColor clearColor];
        messageTextview.tag=indexPath.row;
        cell.Avatar_Image=_userImage;
        cell.time_Label.text=feed_data.messageTime;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        messageTextview.scrollEnabled=NO;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
        singleTap.numberOfTapsRequired = 1;
        [cell.Avatar_Image setUserInteractionEnabled:YES];
        [cell.Avatar_Image addGestureRecognizer:singleTap];
        [cell.Avatar_Image setupImageViewer];
        if ([feed_data.messagestatus isEqualToString:@"Sent"]) {
            cell.statusindicator.alpha=0.0;
            [cell.statusindicator stopAnimating];
            cell.statusImage.alpha=1.0;
            [cell.statusImage setImage:[UIImage imageNamed:@"success"]];
        }else  if ([feed_data.messagestatus isEqualToString:@"Sending"])
        {
            cell.statusImage.alpha=0.0;
            cell.statusindicator.alpha=1.0;
            [cell.statusindicator startAnimating];
        }
        else
        {
            cell.statusindicator.alpha=0.0;
            [cell.statusindicator stopAnimating];
            cell.statusImage.alpha=1.0;
            [cell.statusImage setImage:[UIImage imageNamed:@"failed"]];
        }
        cell.Avatar_Image.layer.cornerRadius = 20.0;
        cell.Avatar_Image.layer.masksToBounds = YES;
        cell.Avatar_Image.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.Avatar_Image.layer.borderWidth = 2.0;
//        UITapGestureRecognizer *singleFingerTap =
//        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
//        [messageTextview addGestureRecognizer:singleFingerTap];
//        singleFingerTap.delegate = self;
        return cell;
    }
    else
        if ([feed_data.messageType isEqualToString:@"textbyother"])
        {
            SPHBubbleCell  *cell = (SPHBubbleCell *)[self.sphChatTable dequeueReusableCellWithIdentifier:CellIdentifier2];
            if (cell == nil) {
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SPHBubbleCell" owner:self options:nil];
                cell = [topLevelObjects objectAtIndex:0];
            }
            else
            {
            }
            UIImageView *bubbleImage=[[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"Bubbletypeleft"] stretchableImageWithLeftCapWidth:21 topCapHeight:14]];
            [cell.contentView addSubview:bubbleImage];
            [bubbleImage setFrame:CGRectMake(50,5, itemTextSize.width+18, textHeight+4)];
            bubbleImage.tag=56;
            //CGRectMake(260 - itemTextSize.width+5,2,itemTextSize.width+10, textHeight-2)];
            UITextView *messageTextview=[[UITextView alloc]initWithFrame:CGRectMake(60,2,itemTextSize.width+10, textHeight-2)];
            [cell.contentView addSubview:messageTextview];
            messageTextview.editable=NO;
            messageTextview.text = messageText;
            messageTextview.dataDetectorTypes=UIDataDetectorTypeAll;
            messageTextview.textAlignment=NSTextAlignmentJustified;
            messageTextview.backgroundColor=[UIColor clearColor];
            messageTextview.font=[UIFont fontWithName:@"Helvetica Neue" size:12.0];
            messageTextview.scrollEnabled=NO;
            messageTextview.tag=indexPath.row;
            messageTextview.textColor=[UIColor blackColor];
            cell.Avatar_Image.layer.cornerRadius = 20.0;
            cell.Avatar_Image.layer.masksToBounds = YES;
            cell.Avatar_Image.layer.borderColor = [UIColor whiteColor].CGColor;
            cell.Avatar_Image.layer.borderWidth = 2.0;
            [cell.Avatar_Image setupImageViewer];
            cell.Avatar_Image=_userImage;
            cell.time_Label.text=feed_data.messageTime;
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
//            UITapGestureRecognizer *singleFingerTap =
//            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
//            [messageTextview addGestureRecognizer:singleFingerTap];
//            singleFingerTap.delegate = self;
            return cell;
        }
        else
            if ([feed_data.messageType isEqualToString:@"ImageByme"])
            {
                SPHBubbleCellImage  *cell = (SPHBubbleCellImage *)[self.sphChatTable dequeueReusableCellWithIdentifier:CellIdentifier3];
                if (cell == nil)
                {
                    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SPHBubbleCellImage" owner:self options:nil];
                    cell = [topLevelObjects objectAtIndex:0];
                }
                else
                {
                }
                if ([feed_data.messagestatus isEqualToString:@"Sent"])
                {
                    cell.statusindicator.alpha=0.0;
                    [cell.statusindicator stopAnimating];
                    cell.statusImage.alpha=1.0;
                    [cell.statusImage setImage:[UIImage imageNamed:@"success"]];
                   // cell.message_Image.imageURL=[NSURL URLWithString:feed_data.messageImageURL];
                }
                else
                    if ([feed_data.messagestatus isEqualToString:@"Sending"])
                    {
                    cell.message_Image.image=[UIImage imageNamed:@""];
                    //cell.message_Image.imageURL=[NSURL URLWithString:feed_data.messageImageURL];
                    cell.statusImage.alpha=0.0;
                    cell.statusindicator.alpha=1.0;
                    [cell.statusindicator startAnimating];
                    }
                    else
                    {
                    cell.statusindicator.alpha=0.0;
                    [cell.statusindicator stopAnimating];
                    cell.statusImage.alpha=1.0;
                    [cell.statusImage setImage:[UIImage imageNamed:@"failed"]];
                    }
                cell.message_Image.image=Uploadedimage.image;
                cell.Avatar_Image.layer.cornerRadius = 20.0;
                cell.Avatar_Image.layer.masksToBounds = YES;
                cell.Avatar_Image.layer.borderColor = [UIColor whiteColor].CGColor;
                cell.Avatar_Image.layer.borderWidth = 2.0;
                [cell.Avatar_Image setupImageViewer];
                cell.Buble_image.image= [[UIImage imageNamed:@"Bubbletyperight"] stretchableImageWithLeftCapWidth:21 topCapHeight:14];
                [cell.message_Image setupImageViewer];
                cell.Avatar_Image=_userImage;
                cell.time_Label.text=feed_data.messageTime;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                return cell;
                }
            else
                {
                SPHBubbleCellImageOther  *cell = (SPHBubbleCellImageOther *)[self.sphChatTable dequeueReusableCellWithIdentifier:CellIdentifier4];
                if (cell == nil)
                {
                    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SPHBubbleCellImageOther" owner:self options:nil];
                    cell = [topLevelObjects objectAtIndex:0];
                }
                else
                {
                }
//                [cell.message_Image setupImageViewer];
//                cell.Buble_image.image= [[UIImage imageNamed:@"Bubbletypeleft"] stretchableImageWithLeftCapWidth:15 topCapHeight:14];
//              //  cell.message_Image.imageURL=[NSURL URLWithString:@"http://www.binarytribune.com/wp-content/uploads/2013/06/india_binary_options-274x300.png"];
//                
//                cell.Avatar_Image.layer.cornerRadius = 20.0;
//                cell.Avatar_Image.layer.masksToBounds = YES;
//                cell.Avatar_Image.layer.borderColor = [UIColor whiteColor].CGColor;
//                cell.Avatar_Image.layer.borderWidth = 2.0;
//                [cell.Avatar_Image setupImageViewer];
//                
//                cell.Avatar_Image.image=[UIImage imageNamed:@"my_icon"];
//                cell.time_Label.text=feed_data.messageTime;
//                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                return cell;
            }
}
-(void)tapDetected{
//    NSLog(@"single Tap on imageview");
}
-(void)adddBubbledata:(NSString*)messageType  mtext:(NSString*)messagetext mtime:(NSString*)messageTime mimage:(UIImage*)messageImage  msgstatus:(NSString*)status withDic:(PFObject *)dicValues;
{
    SPHChatData *feed_data=[[SPHChatData alloc]init];
    feed_data.messageText=messagetext;
    feed_data.messageImageURL=messagetext;
    feed_data.messageImage=messageImage;
    feed_data.messageTime=messageTime;
    feed_data.messageType=messageType;
    feed_data.messagestatus=status;
    feed_data.messageChatValues = dicValues;
    
    [sphBubbledata addObject:feed_data];
    [self.sphChatTable reloadData];
    
    [self performSelector:@selector(scrollTableview) withObject:nil afterDelay:0.0];
}
-(void)adddBubbledataatIndex:(NSInteger)rownum messagetype:(NSString*)messageType  mtext:(NSString*)messagetext mtime:(NSString*)messageTime mimage:(UIImage*)messageImage  msgstatus:(NSString*)status;
{
    SPHChatData *feed_data=[[SPHChatData alloc]init];
    feed_data.messageText=messagetext;
    feed_data.messageImageURL=messagetext;
     feed_data.messageImage=messageImage;
    feed_data.messageTime=messageTime;
    feed_data.messageType=messageType;
    feed_data.messagestatus=status;
    [sphBubbledata  removeObjectAtIndex:rownum];
    [sphBubbledata insertObject:feed_data atIndex:rownum];
    [self.sphChatTable reloadData];
    
    [self performSelector:@selector(scrollTableview) withObject:nil afterDelay:0.0];
}
-(void)tapRecognized:(UITapGestureRecognizer *)tapGR
{
    UITextView *theTextView = (UITextView *)tapGR.view;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:theTextView.tag inSection:0];
    SPHChatData *feed_data=[[SPHChatData alloc]init];
    feed_data=[sphBubbledata objectAtIndex:indexPath.row];
    selectedRow=indexPath.row;
    [self.sphChatTable reloadData];
    
    if ([feed_data.messageType isEqualToString:@"textByme"])
    {
        SPHBubbleCellOther *mycell=(SPHBubbleCellOther*)[self.sphChatTable cellForRowAtIndexPath:indexPath];
        UIImageView *bubbleImage=(UIImageView *)[mycell viewWithTag:55];
        bubbleImage.image=[[UIImage imageNamed:@"Bubbletyperight_highlight"] stretchableImageWithLeftCapWidth:21 topCapHeight:14];
    }
    else
        if ([feed_data.messageType isEqualToString:@"textbyother"])
        {
            SPHBubbleCell *mycell=(SPHBubbleCell*)[self.sphChatTable cellForRowAtIndexPath:indexPath];
            UIImageView *bubbleImage=(UIImageView *)[mycell viewWithTag:56];
            bubbleImage.image=[[UIImage imageNamed:@"Bubbletypeleft_highlight"] stretchableImageWithLeftCapWidth:21 topCapHeight:14];
        }
    CGPoint touchPoint = [tapGR locationInView:self.view];
    [self.popupMenu showInView:self.view atPoint:touchPoint];
    [self.sphChatTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self.sphChatTable.delegate tableView:self.sphChatTable didSelectRowAtIndexPath:indexPath];
}
-(IBAction)bookmarkClicked:(id)sender
{
//    NSLog( @"Book mark clicked at row : %d",selectedRow);
}
-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}
-(void)scrollTableview
{
    [self.sphChatTable reloadData];
    int lastSection=[self.sphChatTable numberOfSections]-1;
    int lastRowNumber = [self.sphChatTable numberOfRowsInSection:lastSection]-1;
    NSIndexPath* ip = [NSIndexPath indexPathForRow:lastRowNumber inSection:lastSection];
    [self.sphChatTable scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
-(void) keyboardWillShow:(NSNotification *)note
{
    if (sphBubbledata.count>2)
    {
        [self performSelector:@selector(scrollTableview) withObject:nil afterDelay:0.0];
    }
    // get keyboard size and loctaion
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    // Need to translate the bounds to account for rotation.
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    // get a rect for the textView frame
	CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
    CGRect tableviewframe=self.sphChatTable.frame;
    tableviewframe.size.height-=160;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
	containerView.frame = containerFrame;
    self.sphChatTable.frame=tableviewframe;
	[UIView commitAnimations];
}
-(void) keyboardWillHide:(NSNotification *)note
{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
	// get a rect for the textView frame
	CGRect containerFrame = containerView.frame;
    containerFrame.origin.y = self.view.bounds.size.height - containerFrame.size.height;
    CGRect tableviewframe=self.sphChatTable.frame;
    tableviewframe.size.height+=160;
    // animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
	// set views with new info
    self.sphChatTable.frame=tableviewframe;
	containerView.frame = containerFrame;
	// commit animations
	[UIView commitAnimations];
}
- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
	CGRect r = containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
	containerView.frame = r;
}
- (IBAction)endViewedit:(id)sender
{
    [self.view endEditing:YES];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    isFirst=YES;
    [super viewDidAppear:animated];
    [self   loadMessages];
    
    
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewWillDisappear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewWillDisappear:animated];
    [timer invalidate];
}


-(void)loadMessages
{
    
    [sphBubbledata removeAllObjects];
    
    NSLog(@"%@ %@ are ids", _messangerID, _user_ID);
    
    if (isLoading == NO)
    {
        isLoading = YES;
        PFQuery * quertSort=[PFQuery queryWithClassName:@"Message"];
        [quertSort whereKey:@"ReceiverID" equalTo:_messangerID];
        [quertSort whereKey:@"senderID" equalTo:_user_ID];
        [quertSort whereKey:@"response" containsString:@"YES"];
        [quertSort whereKey:@"status" containsString:@"START"];
        [quertSort orderByAscending:@"updatedAt"];
        
        [quertSort findObjectsInBackgroundWithBlock:^(NSArray *objects1, NSError *error) {
            
            if (isFirst == YES)
            {
                isFirst = NO;
            }
            
            for (int i = 0; i < objects1.count ; i++)
            {
                
                
                   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                   NSString *stringUserID ;
                   NSString *receiverID;
               
                   if ([defaults objectForKey:@"mainUserID"])
                   {
                       stringUserID = [defaults objectForKey:@"mainUserID"];
                   }
                
                   if ([stringUserID  isEqualToString:[[objects1 objectAtIndex:0] objectForKey:@"senderID"]])
                   {
                       stringUserID = [[objects1 objectAtIndex:0] objectForKey:@"senderID"];
                       receiverID = [[objects1 objectAtIndex:0] objectForKey:@"ReceiverID"];
                       
                       
                       _parse_Receiver = [[NSString alloc] initWithFormat:@"%@", receiverID];
                       _parse_Sender = [[NSString alloc] initWithFormat:@"%@", stringUserID];
                       
                       _device_Receiver = [[NSString alloc] initWithFormat:@"%@", receiverID];
                       _device_Sender = [[NSString alloc] initWithFormat:@"%@", stringUserID];
                       
                       NSString * message=[[objects1 objectAtIndex:i] objectForKey:@"messageRecive" ];
                       NSString * time=[[objects1 objectAtIndex:i] objectForKey:@"chatTime_Receive"];
                       NSString * objectID=[[objects1 objectAtIndex:i] objectForKey:@"objectID"];
                       NSString * message1=[[objects1 objectAtIndex:i] objectForKey:@"messageSend" ];
                       NSString * time1=[[objects1 objectAtIndex:i] objectForKey:@"chatTime_Sender"];
                    //   PFFile * file=[[objects1 objectAtIndex:1] objectForKey:@"image_send"];
                       
                       
//                       [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//                           if (!error) {
//                               UIImage *image = [UIImage imageWithData:data];
//                               Uploadedimage.image=image;
//                               // image can now be set on a UIImageView
//                           }
//                       }];
                       if (![message  isEqualToString:objectID])
                       {
                           [self adddBubbledata:@"textbyother" mtext:message mtime:time mimage:Uploadedimage.image msgstatus:@"Sent" withDic:[objects1 objectAtIndex:i]];
                           
                       }
                       
                       if (![message1  isEqualToString:objectID])
                           [self adddBubbledata:@"textByme" mtext:message1 mtime:time1 mimage:Uploadedimage.image msgstatus:@"Sent" withDic:[objects1 objectAtIndex:i]];
                   }
                   else
                   {
                       stringUserID = [[objects1 objectAtIndex:0] objectForKey:@"ReceiverID"];
                       receiverID = [[objects1 objectAtIndex:0] objectForKey:@"senderID"];
                       
                       _parse_Receiver = [[NSString alloc] initWithFormat:@"%@", stringUserID];
                       _parse_Sender = [[NSString alloc] initWithFormat:@"%@", receiverID];
                       
                       _device_Receiver = [[NSString alloc] initWithFormat:@"%@", receiverID];
                       _device_Sender = [[NSString alloc] initWithFormat:@"%@", stringUserID];
                       
                       
                       NSString * message=[[objects1 objectAtIndex:i] objectForKey:@"messageRecive" ];
                       NSString * time=[[objects1 objectAtIndex:i] objectForKey:@"chatTime_Receive"];
                       NSString * objectID=[[objects1 objectAtIndex:i] objectForKey:@"objectID"];
                       
                       NSString * message1=[[objects1 objectAtIndex:i] objectForKey:@"messageSend" ];
                       NSString * time1=[[objects1 objectAtIndex:i] objectForKey:@"chatTime_Sender"];
                       
//                       PFFile * file=[[objects1 objectAtIndex:1] objectForKey:@"image_Recieve"];
//                       
//                       
//                       [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//                           if (!error) {
//                               UIImage *image = [UIImage imageWithData:data];
//                               Uploadedimage.image=image;
//                               // image can now be set on a UIImageView
//                           }
//                       }];

                       
                       if (![message  isEqualToString:objectID])
                           [self adddBubbledata:@"textByme" mtext:message mtime:time mimage:Uploadedimage.image msgstatus:@"Sent" withDic:[objects1 objectAtIndex:i]];
                       
                       if (![message1  isEqualToString:objectID])
                           [self adddBubbledata:@"textbyother" mtext:message1 mtime:time1 mimage:Uploadedimage.image msgstatus:@"Sending" withDic:[objects1 objectAtIndex:i]];
                       
                   }
                
            }
       
            isLoading = YES;

            timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(getLastMessage) userInfo:nil repeats:YES];
            
            
        }];
        
    }
}


-(void)getLastMessage
{
    
    
    if (isLoading)
    {
        isLoading = NO;
        
        PFQuery * quertSort=[PFQuery queryWithClassName:@"Message"];
        [quertSort whereKey:@"ReceiverID" equalTo:_messangerID];
        [quertSort whereKey:@"senderID" equalTo:_user_ID];
        [quertSort whereKey:@"response" containsString:@"YES"];
        [quertSort whereKey:@"status" containsString:@"START"];
        [quertSort orderByDescending:@"updatedAt"];
        
        [quertSort getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            
            if (object)
            {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSString *stringUserID ;
                NSString *receiverID;
                
                if ([defaults objectForKey:@"mainUserID"])
                {
                    stringUserID = [defaults objectForKey:@"mainUserID"];
                }
                
                if ([stringUserID  isEqualToString:[object objectForKey:@"senderID"]])
                {
                    stringUserID = [object objectForKey:@"senderID"];
                    receiverID = [object objectForKey:@"ReceiverID"];
                    
                    _parse_Receiver = [[NSString alloc] initWithFormat:@"%@", receiverID];
                    _parse_Sender = [[NSString alloc] initWithFormat:@"%@", stringUserID];
                    
                    _device_Receiver = [[NSString alloc] initWithFormat:@"%@", receiverID];
                    _device_Sender = [[NSString alloc] initWithFormat:@"%@", stringUserID];
                    
                    NSString * message=[object objectForKey:@"messageRecive" ];
                    NSString * time=[object objectForKey:@"chatTime_Receive"];
                    NSString * objectID1=[object objectForKey:@"objectID"];
                    
                    NSString * message1=[object objectForKey:@"messageSend" ];
                    NSString * time1=[object objectForKey:@"chatTime_Sender"];
                    PFFile * file1=[object objectForKey:@"image_send"];
//                    [file1 getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//                        if (!error) {
//                            UIImage *image = [UIImage imageWithData:data];
//                            _image_send1=image;
//                            // image can now be set on a UIImageView
//                        }
//                    }];
//                    PFFile * file=[object objectForKey:@"image_send"];
//                    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//                        if (!error) {
//                            UIImage *image = [UIImage imageWithData:data];
//                            _image_send=image;
//                            // image can now be set on a UIImageView
//                        }
//                    }];
//                    
                    SPHChatData *data = [sphBubbledata  lastObject];
                    
                    NSString * senderMsg = [data.messageChatValues objectForKey:@"messageSend"];
                    NSString * objectID = [data.messageChatValues objectForKey:@"objectID"];
                    NSString * receiverMsg = [data.messageChatValues objectForKey:@"messageRecive"];
                    
                    if (!([message isEqualToString:receiverMsg] && [objectID isEqualToString:objectID1] &&    [senderMsg isEqualToString:message1]))
                    {
                        
                        if (![message  isEqualToString:objectID1] && ![message length]<1)
                        {
                            [self adddBubbledata:@"textbyother" mtext:message mtime:time mimage:_image_send msgstatus:@"Sent" withDic:object];
                            
                        }
                        
                        if (![message1  isEqualToString:objectID1] && ![message1 length]<1)
                        {
                            [self adddBubbledata:@"textByme" mtext:message1 mtime:time1 mimage:_image_send1 msgstatus:@"Sent" withDic:object];
                     
                        }
                    }
                    
                }
                else
                {
                    stringUserID = [object objectForKey:@"ReceiverID"];
                    receiverID = [object objectForKey:@"senderID"];
                    
                    _parse_Receiver = [[NSString alloc] initWithFormat:@"%@", stringUserID];
                    _parse_Sender = [[NSString alloc] initWithFormat:@"%@", receiverID];
                    
                    _device_Receiver = [[NSString alloc] initWithFormat:@"%@", receiverID];
                    _device_Sender = [[NSString alloc] initWithFormat:@"%@", stringUserID];
                    
                    
                    NSString * message=[object objectForKey:@"messageRecive" ];
                    NSString * time=[object objectForKey:@"chatTime_Receive"];
                    NSString * objectID1=[object objectForKey:@"objectID"];
                    
                    NSString * message1=[object objectForKey:@"messageSend" ];
                    NSString * time1=[object objectForKey:@"chatTime_Sender"];
                    PFFile * file1=[object objectForKey:@"image_send"];
                    UIImage * imageRecive;
                    [file1 getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        if (!error) {
                            UIImage *image = [UIImage imageWithData:data];
                            _image_recive1=image;
                            // image can now be set on a UIImageView
                        }
                    }];

                    
                    SPHChatData *data = [sphBubbledata  lastObject];
                    
                    NSString * senderMsg = [data.messageChatValues objectForKey:@"messageSend"];
                    NSString * objectID = [data.messageChatValues objectForKey:@"objectID"];
                    NSString * receiverMsg = [data.messageChatValues objectForKey:@"messageRecive"];
//                    PFFile * file1r=[object objectForKey:@"image_receive"];
//                    [file1r getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//                        if (!error) {
//                            UIImage *image = [UIImage imageWithData:data];
//                            _image_recive1=image;
//                            // image can now be set on a UIImageView
//                        }
//                    }];
//                    PFFile * file=[object objectForKey:@"image_receive"];
//                  
//                    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//                        if (!error) {
//                            UIImage *image = [UIImage imageWithData:data];
//                            _image_recive1=image;
//                            // image can now be set on a UIImageView
//                        }
//                    }];
//                    
                    if (!([message isEqualToString:receiverMsg] && [objectID isEqualToString:objectID1] &&    [senderMsg isEqualToString:message1]))
                    {
                        if (![message  isEqualToString:objectID1] && ![message length]<1)
                            [self adddBubbledata:@"textByme" mtext:message mtime:time mimage:_image_recive msgstatus:@"Sent" withDic:object];
                        
                       if (![message1  isEqualToString:objectID1] && ![message1 length]<1)
                            [self adddBubbledata:@"textbyother" mtext:message1 mtime:time1 mimage:_image_recive1 msgstatus:@"Sending" withDic:object];
                    }
                    
                }
                
            }
        
                isLoading = YES;
        }];
        
    }
    
   
    
}


@end
