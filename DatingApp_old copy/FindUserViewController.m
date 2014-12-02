//
//  FindUserViewController.m
//  DatingApp
//
//  Created by CrayonLabs on 11/1/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import "FindUserViewController.h"
#import "FindUserTableViewCell.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import <Social/Social.h>
#import "SettingsViewController.h"
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import "MutiualFriendViewController.h"
#import <CoreLocation/CoreLocation.h>
static NSString *cellIdentifier=@"FindUserTableViewCell";
@interface FindUserViewController ()
@property (nonatomic, strong) NSMutableArray    *m_ArrFriends;
@property (strong ,nonatomic) NSString *name;
@property (strong ,nonatomic) NSString *age;
@property (strong ,nonatomic) NSString *ID;
@property (strong ,nonatomic) NSString *Gender;
// Arrays
@property(strong, nonatomic) NSMutableArray* arrayLongitude;
@property(strong, nonatomic) NSMutableArray* arrayLatitude;




@end

@implementation FindUserViewController
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
    _arrayLatitude = [[NSMutableArray alloc]init];
    _arrayLongitude = [[NSMutableArray alloc]init];
     _m_ArrFriends=[[NSMutableArray alloc] init];
  
    // Do any additional setup after loading the view.
    [self.m_TableView registerNib:[UINib nibWithNibName:@"FindUserTableViewCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:cellIdentifier];
    self.m_TableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //self.imageDownloadsInProgress = [[NSMutableDictionary alloc] init];
    self.navigationItem.title = @"Find Friends";
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
   

    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
   
    NSString* userLatitude=[defaults valueForKey:@"userLatitude"];
    NSString *userLongitude=[defaults valueForKey:@"userLongitude"];
    NSString *mainUserID=[defaults valueForKey:@"mainUserID"];
    
    if (_isShowAll==YES && _isNearBy==NO)
    {
       _m_ArrFriends = [[NSMutableArray alloc] init];
        MBProgressHUD *view=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [view setLabelText:@"Finding People"];
      
        PFQuery *quey=[PFQuery queryWithClassName:@"userData"];
     
        [quey whereKey:@"Stranger" equalTo:@"YES"];
        [quey findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

        _m_ArrFriends=objects;
            NSLog(@"%@",_m_ArrFriends);
            [_m_TableView reloadData];
        }];
        
    }
    else if(_isNearBy==YES && _isShowAll==NO)
    {
    
        MBProgressHUD *view=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [view setLabelText:@"Finding People"];
    
     CLLocation *userLocation1=[[CLLocation alloc] initWithLatitude:[userLatitude floatValue] longitude:[userLongitude floatValue]];
    NSMutableDictionary * dict=[[NSMutableDictionary alloc] init];
    NSLog(@"user location %@",userLocation1);
    PFQuery *quey=[PFQuery queryWithClassName:@"userData"];
   
      [quey whereKey:@"Stranger" equalTo:@"YES"];
    [quey findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSArray * locArr=[objects valueForKey:@"location"];
        NSArray * longitudeArray=[objects valueForKey:@"Longitude"];
        NSArray * latitudeArray=[objects valueForKey:@"latitude"];
        NSArray * IDArray=[objects valueForKey:@"facebookID"];
        NSArray * nameArray=[objects valueForKey:@"name"];
        NSArray * ageArray=[objects valueForKey:@"ageYear"];
        NSArray * genderArray=[objects valueForKey:@"Gender"];
       _m_ArrFriends = [[NSMutableArray alloc] init];
        
        
        for(int i=0;i<locArr.count;i++)
        {
            NSLog(@"%f,,,,,%f,%d,%d",[latitudeArray[i] floatValue],[longitudeArray[i] floatValue],locArr.count,i);
            CLLocation * friendLocation=[[CLLocation alloc] initWithLatitude:[latitudeArray[i] floatValue] longitude:[longitudeArray[i] floatValue]];
      //      NSLog(@"%@",locArr[i]);
            _name=[nameArray objectAtIndex:i];
            _age=[ageArray objectAtIndex:i];
        _ID=[IDArray objectAtIndex:i];
            _Gender=[genderArray objectAtIndex:i];
          NSLog(@"friend Location %@",friendLocation);
           NSLog(@"name  %@ ID  %@ age %@ Distance i kilometers: %f  gender %@   setGender %@",_name,_ID,_age ,[userLocation1 distanceFromLocation:friendLocation]*1609.344,_Gender,_setGender);
         NSString *distr=[NSString stringWithFormat:@"%f",[userLocation1 distanceFromLocation:friendLocation]];
            
            if ([distr intValue]<=[_setDistance intValue] && [_age intValue]<=[_setAge intValue])
            {
            if([[_setGender lowercaseString] isEqualToString:[_Gender lowercaseString]] && [_ID intValue]!=[mainUserID intValue] && _ID!=mainUserID)
            {
                
                
                [_m_ArrFriends  addObject:[objects  objectAtIndex:i]];
                NSLog(@"%@",_m_ArrFriends);
            }
              
            }
            
            
              NSLog(@"%@",_m_ArrFriends);
            [_m_TableView reloadData];
            
              }
        
        }];

    }
    
    
     }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    NSLog(@"%d",_m_ArrFriends.count);
    return _m_ArrFriends.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_m_ArrFriends.count==0) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"No Match Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
//    MBProgressHUD *view=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [view setLabelText:@"Finding Nearby People"];

    FindUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    
    
    //cell.tag = indexPath.row;
    cell.m_labelName.text=[[_m_ArrFriends objectAtIndex:indexPath.row ] objectForKey:@"name"];
    cell.m_labelGender.text=[[_m_ArrFriends objectAtIndex:indexPath.row] objectForKey:@"Gender"];
   
    [cell.m_ImageUse  sd_setImageWithURL:[NSURL URLWithString: [[_m_ArrFriends objectAtIndex:indexPath.row] objectForKey:@"profilepic"]]];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    //cell.m_ImageUse.image=[UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FindFriendsTableViewCell" owner:self options:nil];
//    if (nib)
//    {
//        FindUserTableViewCell  * cell = [nib objectAtIndex:0];
//         return cell.frame.size.height + 25.0f;
//    }
    return 94.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MutiualFriendViewController *mvc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"MutualFriendView"];
    mvc.m_nameFriend=[[self.m_ArrFriends objectAtIndex:indexPath.row] objectForKey:@"name"];
    mvc.m_DOBFriend=[[self.m_ArrFriends objectAtIndex:indexPath.row] objectForKey:@"birthday"];;
    mvc.m_iduser=[[self.m_ArrFriends objectAtIndex:indexPath.row] objectForKey:@"facebookID"];
    
    [self.navigationController pushViewController:mvc animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"OK"])
    {
        SettingsViewController *svc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"settingsView"];
        [self.navigationController pushViewController:svc animated:YES];
    }
        }

@end
