//
//  FriendOfFriendViewController.m
//  DatingApp
//
//  Created by CrayonLabs on 8/15/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import "FriendOfFriendViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MBProgressHUD.h"
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import <Parse/Parse.h>
#import "YourFriendTableViewCell.h"
#import "MutiualFriendViewController.h"
#import "SettingsViewController.h"


static NSString *cellIdentifier=@"cellIdentifier";

@interface FriendOfFriendViewController ()
@property (nonatomic, strong) NSMutableArray    *m_ArrFriends;
@property (strong,nonatomic)    NSMutableArray * Showme;
@property (nonatomic, strong) NSMutableArray    *m_ArrFriend;
@property (nonatomic, strong) NSMutableArray    *m_FriendsOfFriends;
@property (strong,nonatomic) NSString* m_IDs;

@end

@implementation FriendOfFriendViewController

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
   
    self.navigationItem.title = @"Friends of Friends";
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
    [someButton2 addTarget:self action:@selector(pressedRightBarButton:)forControlEvents:UIControlEventTouchUpInside];
    someButton2.layer.cornerRadius=5.0f;
    [someButton2 setShowsTouchWhenHighlighted:YES];
    _rightBarButton =[[UIBarButtonItem alloc] initWithCustomView:someButton2];
    self.navigationItem.rightBarButtonItem=_rightBarButton;
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString * messangerID=[defaults objectForKey:@"messangerID"];
    NSLog(@"%@",messangerID);
    MBProgressHUD *view =[MBProgressHUD  showHUDAddedTo:self.view animated:YES];
    [view  setLabelText:@"Getting Friends"];
    [FBRequestConnection startWithGraphPath:@"me/friends/?fields=name,location,gender,birthday,relationship_status,picture,email,id"
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              ) {
                              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                              self.m_FriendsOfFriends = [[NSMutableArray alloc] initWithArray:[result    objectForKey:@"data"]];
                              NSLog(@"%@",self.m_FriendsOfFriends);
                              [self.m_CollectionView reloadData];
                              /* handle the result */
                          }];
    FBFriendPickerViewController *fbfriendsVC = [[FBFriendPickerViewController alloc] init];
    fbfriendsVC.allowsMultipleSelection = NO;
    
    
    
}

-(void)pressedRightBarButton:(id)sender
{
    SettingsViewController *svc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"settingsView"];
    [self.navigationController pushViewController:svc animated:YES];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.m_FriendsOfFriends.count;
   // return 15;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
//        PFQuery *queryShowMe=[PFQuery queryWithClassName:@"userData"];
//        [queryShowMe whereKey:@"FriendsOfFriends" equalTo:@"NO"];
//        [queryShowMe findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//         NSLog(@"%@",objects);
//         _Showme=[objects valueForKey:@"facebookID"];
//         NSLog(@"%@",_Showme);
//         NSString  * _id=[[self.m_FriendsOfFriends objectAtIndex:indexPath.row ] objectForKey:@"id"];
//         NSLog(@"%@",_id);
//         NSLog(@"%@",_Showme);
//         for (int i=0;i<_Showme.count;i++) {
//         if ([_Showme[i] isEqualToString:_id]) {
//         NSLog(@"hbkj%@",_Showme[i]);
//         NSString* m_iduser=[[self.m_FriendsOfFriends objectAtIndex:indexPath.row] objectForKey:@"id"];
//         NSLog(@"dfdsd%@",m_iduser);
//         UIImageView *Photo=(UIImageView *)[cell viewWithTag:1];
//         [Photo setImageWithURL:[NSURL URLWithString:[[[[self.m_FriendsOfFriends objectAtIndex:indexPath.row]         objectForKey:@"picture"]objectForKey:@"data"]objectForKey:@"url"]]];
//          NSLog(@"%@ is url", [[[[self.m_FriendsOfFriends objectAtIndex:indexPath.row] objectForKey:@"picture"]objectForKey:@"data"]objectForKey:@"url"]);
//
//                    break;
//                }
//                else
//                {
        NSString* m_iduser=[[self.m_FriendsOfFriends objectAtIndex:indexPath.row] objectForKey:@"id"];
        NSLog(@"dfdsd%@",m_iduser);
        UIImageView *Photo=(UIImageView *)[cell viewWithTag:1];
//      [Photo sd_setImageWithURL:[NSURL URLWithString:[[[[self.m_FriendsOfFriends objectAtIndex:indexPath.row] objectForKey:@"picture"]objectForKey:@"data"]objectForKey:@"url"]]];
        NSLog(@"%@ is url", [[[[self.m_FriendsOfFriends objectAtIndex:indexPath.row] objectForKey:@"picture"]objectForKey:@"data"]objectForKey:@"url"]);
        [Photo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1",[ [_m_FriendsOfFriends objectAtIndex:indexPath.row ] objectForKey:@"id"]] ]];
//      cell.backgroundColor= [UIColor grayColor];
//          }
//          }
//         }];
        return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    PFQuery *queryShowMe=[PFQuery queryWithClassName:@"userData"];
    [queryShowMe whereKey:@"FriendsOfFriends" equalTo:@"NO"];
    [queryShowMe findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    NSLog(@"%@",objects);
    _Showme=[objects valueForKey:@"facebookID"];
    NSLog(@"%@",_Showme);
    NSString  * _id=[[self.m_FriendsOfFriends objectAtIndex:indexPath.row ] objectForKey:@"id"];
    NSLog(@"%@",_id);
    NSLog(@"%@",_Showme);
    for (int i=0;i<_Showme.count;i++)
    {
    if ([_Showme[i] isEqualToString:_id])
    {
                NSLog(@"hbkj%@",_Showme[i]);
                cell.tag = indexPath.row;
                cell.hidden=YES;
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"WARNING" message:@"User not allow to view profile" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                break;
            }
            else
            {
    MutiualFriendViewController *pvc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"MutualFriendView"];
    [self.navigationController pushViewController:pvc animated:YES];
    pvc.m_nameFriend=[[self.m_FriendsOfFriends objectAtIndex:indexPath.row] objectForKey:@"name"];
    pvc.m_DOBFriend=[[self.m_FriendsOfFriends objectAtIndex:indexPath.row] objectForKey:@"birthday"];;
    pvc.m_iduser=[[self.m_FriendsOfFriends objectAtIndex:indexPath.row] objectForKey:@"id"];
                break;
            }
        }
    }];
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
-(void)facebookGetFriends
{
    NSString *requestPath = [NSString stringWithFormat:@"me/friends/?fields=name,location,gender,birthday,relationship_status,picture,email,id" ];
    FBRequest *request = [[FBRequest    alloc] initWithSession:[PFFacebookUtils session] graphPath:requestPath];
    if (request.session.isOpen)
    {
        MBProgressHUD *view =[MBProgressHUD  showHUDAddedTo:self.view animated:YES];
        [view  setLabelText:@"Getting Friends"];
        [request    startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error)
         {
        NSLog(@"%@ os request",result);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        self.m_ArrFriends = [[NSMutableArray alloc] initWithArray:[result    objectForKey:@"data"]];
        [self.m_CollectionView  reloadData];
         }];
    }
        NSString *query =@"SELECT friend_count FROM user WHERE uid = me()";
    // Set up the query parameter
        NSDictionary *queryParam =
        [NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];
    // Make the API request that uses FQL
        [FBRequestConnection startWithGraphPath:@"/fql"
                                 parameters:queryParam
                                 HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection,
                                              id result,
                                              NSError *error) {
                              if (error) {
                                  NSLog(@"Error: %@", [error localizedDescription]);
                              } else {
                                  NSLog(@"Result: %@", result);
                                  // show result
                                  NSArray *friendInfo = (NSArray *) [result objectForKey:@"data"];
                                  NSLog(@"result=%@",[friendInfo objectAtIndex:0]);
                                  NSDictionary *friend_count =[friendInfo objectAtIndex:0];
                                  NSString *numberoff= [friend_count objectForKey:@"friend_count"];
                                  NSLog(@"Result2: %@", numberoff);
                              }
                          }];
}
@end
