 //
//  YourFriendViewController.m
//  DatingApp
//
//  Created by CrayonLabs on 8/13/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import "YourFriendViewController.h"
#import "YourFriendTableViewCell.h"
#import "MutiualFriendViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "MBProgressHUD.h"
#import <Social/Social.h>
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import <Parse/Parse.h>
#import "SettingsViewController.h"


static NSString *cellIdentifier=@"YourFriendTableViewCell";
static NSNumber *numID;
static UIImage *imageselect;
static NSString *userdate;
static NSString *requested;
static NSObject *dateObject;
static NSURL *urlpic;
static NSString *friendsimage;
static int i=20;

@interface YourFriendViewController ()
@property (nonatomic, strong) NSMutableArray    *more;
@property (nonatomic, strong) NSMutableArray    *m_ArrFriends;
@property (nonatomic, strong) NSMutableArray    *m_ArrFriendsPic;
@property (nonatomic, strong) NSMutableDictionary *imageDownloadsInProgress;
@property (nonatomic, strong) NSMutableDictionary *dicSortedAccToDates;
@property (strong,nonatomic)    NSMutableArray * Showme;
@property (strong,nonatomic)    NSMutableArray * m_ArrFriend;
@property (strong,nonatomic) MBProgressHUD * view2;
@property (nonatomic, strong) NSMutableArray  * nameArray;

@end

@implementation YourFriendViewController

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
    [self.m_TableView registerNib:[UINib nibWithNibName:@"YourFriendTableViewCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:cellIdentifier];
    self.m_TableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.imageDownloadsInProgress = [[NSMutableDictionary alloc] init];
    self.navigationItem.title = @"Your Friends";
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
    NSUserDefaults *cellDefault=[NSUserDefaults standardUserDefaults];
    [cellDefault setObject:requested forKey:@"RequestID"];
    NSLog(@"%@",requested);
    [cellDefault synchronize];
    [self   facebookGetFriends];
//    UITapGestureRecognizer  *tapGesture = [[UITapGestureRecognizer   alloc] initWithTarget:self action:@selector(tapGestureCalled:)];
//    tapGesture.numberOfTapsRequired = 1;
    
//    [self.view   addGestureRecognizer:tapGesture];
}

-(void)pressedRightBarButton:(id)sender
{
    SettingsViewController *svc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"settingsView"];
    [self.navigationController pushViewController:svc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)tapGestureCalled:(id)sender
//{
//    [self.m_searchTextField resignFirstResponder];
//}
- (void)queryButtonAction
{
    
}
-(void)facebookGetFriends
{
    MBProgressHUD *view =[MBProgressHUD  showHUDAddedTo:self.view animated:YES];
    [view  setLabelText:@"Getting Friends"];
    [FBRequestConnection startWithGraphPath:@"me/friends/?fields=name,location,gender,birthday,relationship_status,picture,email,id"
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              )
    {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    self.m_ArrFriends = [[NSMutableArray alloc] initWithArray:[result    objectForKey:@"data"]];
        _nameArray=[_m_ArrFriends valueForKey:@"name"];
        NSLog(@"%@",_nameArray);
        
    NSLog(@"%@",self.m_ArrFriends);
    _more=self.m_ArrFriends;
    [self.m_TableView reloadData];
                /* handle the result */
    }];
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
    NSString *numberoff= [friend_count objectForKey:@"friend_count"];
    NSLog(@"Result2: %@", numberoff);
    }
    }];
    _m_SearchButton.selected=NO;

}

- (IBAction)b_buttonMore:(id)sender
{
    if (_m_buttonMore.selected==NO && i<_more.count-(10)) {
    i=i+15;
//    _more=_more[i];
    [self.m_TableView reloadData];
    }
    else if(_m_buttonMore.selected==YES)
    {
//   _more=_more[30];
    i=15;
    }
}

- (IBAction)searchFriends:(id)sender
{
    NSString * searchFriend=_m_searchTextField.text;
    NSLog(@"%@",searchFriend);
    NSMutableArray * arr=[[NSMutableArray alloc] init];

   
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self CONTAINS[c] %@", searchFriend];
    NSArray *containsMatches = [_nameArray filteredArrayUsingPredicate:predicate];
    NSLog(@"closest search matches: %@", containsMatches);
    
    
    for (int i=0;i<_nameArray.count; i++) {
        for (int j=0;j<containsMatches.count;j++) {
            
        
        if ([containsMatches[j] isEqualToString:[[_m_ArrFriends objectAtIndex:i ] objectForKey:@"name"]])
        {
           NSString *name=[[_m_ArrFriends objectAtIndex:i ] objectForKey:@"name"];
            NSString *gender=[[_m_ArrFriends objectAtIndex:i ] objectForKey:@"gender"];
            NSString *ids=[[_m_ArrFriends objectAtIndex:i ] objectForKey:@"id"];
            
            [arr addObjectsFromArray:[NSArray arrayWithObjects:[NSMutableDictionary dictionaryWithObjects:
                                                                       [NSArray arrayWithObjects: name, gender,ids, nil]
                                                                                                         forKeys:[NSArray arrayWithObjects: @"name", @"gender", @"id", nil]], nil]];
            
            NSLog(@"%@",arr);
            _more=arr;
           
            NSLog(@"%@",_more);

        }
        }
    }
    _m_SearchButton.selected=YES;
    [self.m_TableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSLog(@"%d",_more.count);
    if (_m_SearchButton.selected==YES) {
        return _more.count;
    }
    else
    {
        return i;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YourFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    cell.tag = indexPath.row;
    cell.m_LabelTitleName.text = [[_more objectAtIndex:indexPath.row ] objectForKey:@"name"];
    NSLog(@"%@",[[_more objectAtIndex:indexPath.row ] objectForKey:@"id"]);
    cell.m_LabelTitleDes.text = [[_more objectAtIndex:indexPath.row ] objectForKey:@"gender"];
    
//    imageselect=[[[[_more objectAtIndex:indexPath.row] objectForKey:@"picture"]objectForKey:@"data"]objectForKey:@"url"] ;
    
    NSString *value = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1",[ [_more objectAtIndex:indexPath.row ] objectForKey:@"id"]];
    [cell.m_ImageView   sd_setImageWithURL:[NSURL URLWithString: value]];
    
    if (indexPath.row==i-1 )
    {
    _m_buttonMore.hidden=NO;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"YourFriendTableViewCell" owner:self options:nil];
    if (nib)
    {
        YourFriendTableViewCell  * cell = [nib objectAtIndex:0];
        return cell.frame.size.height + 25.0f;
    }
    return 74.0f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  _view2=[MBProgressHUD  showHUDAddedTo:self.view animated:YES];
    [_view2  setLabelText:@"Getting Profile"];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   YourFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    MutiualFriendViewController *pvc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"MutualFriendView"];
    PFQuery *queryShowMe=[PFQuery queryWithClassName:@"userData"];
    [queryShowMe whereKey:@"FriendsOfFriends" equalTo:@"NO"];
    [queryShowMe findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
    {
    NSLog(@"%@",objects);
    _Showme=[objects valueForKey:@"facebookID"];
    NSLog(@"%@",_Showme);
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *mainuserID=[defaults objectForKey:@"mainUserID"];
    NSLog(@"%@",mainuserID);
    NSString  * _id=[[self.more objectAtIndex:indexPath.row ] objectForKey:@"id"];
        NSString * location=[[self.more objectAtIndex:indexPath.row] objectForKey:@"location"];
       // CLLocationDistance distance = [locA distanceFromLocation:locB];
    NSLog(@"%@",_id);
    NSLog(@"%@",_Showme);
    for (int i=0;i<_Showme.count;i++)
    {
    if ([_Showme[i] isEqualToString:_id]) {
    NSLog(@"hbkj%@",_Showme[i]);
    cell.tag = indexPath.row;
    cell.hidden=YES;
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"WARNING" message:@"User not allow to view profile" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    break;
    }
    else
    {
    pvc.m_nameFriend=[[self.more objectAtIndex:indexPath.row] objectForKey:@"name"];
    pvc.m_DOBFriend=[[self.more objectAtIndex:indexPath.row] objectForKey:@"birthday"];;
    pvc.m_iduser=[[self.more objectAtIndex:indexPath.row] objectForKey:@"id"];
    requested=pvc.m_iduser;
    pvc.m_ObjectDate=dateObject;
    [self.navigationController pushViewController:pvc animated:YES];
    }
    }
    }];
    
    NSLog(@"DOB %@",pvc.m_DOBFriend);
    
    
    

    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (60.0*M_PI)/180, 0.0, 0.7, 0.4);
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_m_searchTextField resignFirstResponder];
    
    return YES;
}
-(IBAction)backgroundTap:(id)sender
{
    [_m_searchTextField resignFirstResponder];
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

@end
