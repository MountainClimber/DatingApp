//
//  MessagesListViewController.m
//  DatingApp
//
//  Created by CrayonLabs on 8/29/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import "MessagesListViewController.h"
#import "messageListTableViewCell.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import "SettingsViewController.h"
#import "SPHViewController.h"
#import "MBProgressHUD.h"
#import "HomeViewController.h"
static NSString *cellIdentifier=@"messageListTableViewCell";

static UIImage *imageselect;

@interface MessagesListViewController ()
@property (nonatomic, strong) NSMutableArray    *m_ArrMessangerID;
@property (nonatomic, strong) NSArray    *ID;
@property (nonatomic, strong) NSMutableArray    *m_ArrChatList;
@property (nonatomic,strong) NSString *facebookID;
@property (nonatomic,strong) NSString *m_messangerName;
@property (nonatomic,strong) NSString *m_messangerImage;
@property (nonatomic,strong) NSString *m_chatDate;
@property (nonatomic,strong) NSString *m_chatTime;
@property (nonatomic,strong) NSNumber *m_messangerID;
@property (strong ,nonatomic)  NSMutableArray *  array1;
@property (strong ,nonatomic)  NSMutableArray *  array2;
@property (nonatomic, retain) NSString * destinationname;
@end

static NSString *celldentifier =@"messageListTableViewCell";
@implementation MessagesListViewController

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
    [self.m_MessageTableViewCell registerNib:[UINib nibWithNibName:@"messageListTableViewCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:cellIdentifier];
    self.m_MessageTableViewCell.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navigationItem.title = @"My Communication";
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
    //
    //    _leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    //
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
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *mainUserID=[defaults objectForKey:@"mainUserID"];
    NSLog(@"%@",mainUserID);
    _facebookID=mainUserID;
    

    NSPredicate *predicate;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"Retreiving messages...", nil);
    
    predicate   = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(senderID = '%@' OR ReceiverID = '%@' ) AND ( response = 'YES' AND status = 'GET')", mainUserID, mainUserID]];
    
    PFQuery *queryClass = [PFQuery   queryWithClassName:@"Message" predicate:predicate];
    
    NSLog(@"%@ is %@", mainUserID, mainUserID);
    
    MBProgressHUD *viewm1 =[MBProgressHUD  showHUDAddedTo:self.view animated:YES];
    [viewm1  setLabelText:@"Getting message"];
    
    [queryClass findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            _ID = objects;
           
            _m_ArrMessangerID =       [[NSMutableArray alloc] init];
            
         //   int j=objects.count+1;
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            if (objects.count==0)
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"MESSAGE" message:@"Your Chat List is empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
                
                _m_ArrMessangerID = objects;
                
                [self.m_MessageTableViewCell reloadData];
            }
            
        }
    }];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"OK"])
    {
        HomeViewController *hvc= [[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
        [self.navigationController pushViewController:hvc animated:YES];
    }
}

-(IBAction)pressedRightBarButton:(id)sender
{
    SettingsViewController *svc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"settingsView"];
    [self.navigationController pushViewController:svc animated:YES];
}
-(void)getInfoFomeParse
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",_m_ArrMessangerID.count);
    return _m_ArrMessangerID.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   messageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.tag = indexPath.row;
    cell.m_LabelMessangerName.text = [NSString stringWithFormat:@"Chat No .%d",indexPath.row +1 ];
    cell.m_LabelChatTime.text = [[_m_ArrMessangerID objectAtIndex:indexPath.row ] objectForKey:@"ChatTime"];
    NSLog(@"%@",cell.m_LabelChatTime.text);
    
    
    
    cell.m_LabelID.text=[[_m_ArrMessangerID objectAtIndex:indexPath.row] objectForKey:@"messangeID"];
//    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//    NSString * messangerImage=[defaults objectForKey:@"messangerImage"];
//    NSLog(@"%@",messangerImage);
    cell.m_ImageView_Messangerpic.image=[UIImage imageNamed:@"my_icon.png"];
   //cell.m_ImageView_Messangerpic.image=[[[[self.m_ArrChatList objectAtIndex:indexPath.row] objectForKey:@"messangerPicture"]objectForKey:@"data"]objectForKey:@"url"] ;
   // [cell.m_ImageView_Messangerpic setImageWithURL:imageselect];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"messageListTableViewCell" owner:self options:nil];
    if (nib)
    {
    messageListTableViewCell  * cell = [nib objectAtIndex:0];
    return cell.frame.size.height + 25.0f;
    }
    return 74.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SPHViewController * vc=[[SPHViewController alloc] initWithNibName:@"SPHViewController" bundle:nil];

    vc.isAssignView=NO;
    vc.isMessageView=YES;
    
    
    vc.primaryKey=[[_m_ArrMessangerID objectAtIndex:indexPath.row ] objectForKey:@"primaryKey"];
    vc.messangername=[[_m_ArrMessangerID objectAtIndex:indexPath.row ] objectForKey:@"chatWith"];
    vc.messangerID= [[self.m_ArrMessangerID objectAtIndex:indexPath.row ] objectForKey:@"ReceiverID"];
    _m_messangerID=[NSNumber numberWithDouble:[[[self.m_ArrMessangerID objectAtIndex:indexPath.row ] objectForKey:@"ReceiverID"] doubleValue]];
    vc.user_ID= [[self.m_ArrMessangerID objectAtIndex:indexPath.row ] objectForKey:@"senderID"]    ;;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
           messageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        _m_messangerID=[[self.m_ArrMessangerID objectAtIndex:indexPath.row ] objectForKey:@"ReceiverID"];
        cell.tag = indexPath.row;
    NSLog(@"%@  %@",_facebookID,_m_messangerID);
              PFQuery *query=[PFQuery queryWithClassName:@"Message"];
        [query whereKey:@"userID" equalTo:_facebookID];
         [query whereKey:@"ReceiverID"  equalTo:_m_messangerID];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
         
            
            if (!error) {
                NSLog(@"%@ is ul", objects);
                for (PFObject *object in objects) {
                    
                
                [object deleteInBackground];
                }
                [_m_ArrMessangerID removeObjectAtIndex:indexPath.row];
                //            ImageViewController *ivc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"ImageViewController"];
                //            [self.navigationController pushViewController:ivc animated:YES];
            }
            
            [self.m_MessageTableViewCell reloadData];
            cell.hidden=YES;
            
        }];
        
    

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
