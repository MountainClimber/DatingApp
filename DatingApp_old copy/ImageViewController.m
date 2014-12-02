//
//  ImageViewController.m
//  DatingApp
//
//  Created by CrayonLabs on 10/22/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import "ImageViewController.h"
#import "SettingsViewController.h"
#import "imagesTableViewCell.h"
#import <Parse/Parse.h>
#import "ProfileViewController.h"
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>

static NSString *cellIdentifier=@"imagesTableViewCell";
@interface ImageViewController ()
@property (strong,nonatomic) NSMutableArray *m_arrImage;
@property (strong ,nonatomic) UIImageView *img;
@property (strong,nonatomic) NSString * mainUserID;
@property (strong,nonatomic ) NSString *imageTime;

@end

@implementation ImageViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.m_TableViewHome registerNib:[UINib nibWithNibName:@"imagesTableViewCell" bundle:[NSBundle mainBundle]]forCellReuseIdentifier:cellIdentifier];
    self.m_TableViewHome.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
    
    UIImage* image3 = [UIImage imageNamed:@"settings bar.png"];
    CGRect frameimg = CGRectMake(0, 0, image3.size.width, image3.size.height);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(pressedLeftBarButton:)
         forControlEvents:UIControlEventTouchUpInside];
    someButton.layer.cornerRadius=5.0f;
    [someButton setShowsTouchWhenHighlighted:YES];
    
    _leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    _m_arrImage=[[NSMutableArray alloc] init];
    
    self.navigationItem.leftBarButtonItem=_leftBarButton;
    
    
    
    
    if (_isSettingView==NO  ) {
        NSLog(@"%@",_m_userMutualID);
        _mainUserID=_m_userMutualID;
        PFQuery *query=[PFQuery queryWithClassName:@"images"];
        [query whereKey:@"facebookID" equalTo:_m_userMutualID];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (objects.count!=0) {
                _m_arrImage=objects;
                [self.m_TableViewHome   reloadData];
            }
            else if(objects.count==0)
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"MESSAGE" message:@"Image Folder Is Empty . Select Icon to Update New Image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
//                ProfileViewController *svc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"profileView"];
//                
//                [self.navigationController pushViewController:svc animated:YES];
                
                
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
            
        }];

   }
//    else if(_isSettingView==NO &&  _isMutualView==NO && _isMutHomeView==NO)
//    {
//    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//    _mainUserID=[defaults objectForKey:@"mainUserID"];
//    NSLog(@"%@",_mainUserID);
//    
//    PFQuery *query=[PFQuery queryWithClassName:@"images"];
//    [query whereKey:@"facebookID" equalTo:_mainUserID];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (objects.count!=0) {
//            _m_arrImage=objects;
//            [self.m_TableViewHome   reloadData];
//        }
//        else if(objects.count==0)
//        {
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"MESSAGE" message:@"Image Folder Is Empty . Select Icon to Update New Image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//            ProfileViewController *svc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"profileView"];
//            
//            [self.navigationController pushViewController:svc animated:YES];
//        }
//        
//    }];
//    }
    else if(_isHomeView==NO && _isMutualView==NO )
    {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        _mainUserID=[defaults objectForKey:@"mainUserID"];
        NSLog(@"%@",_mainUserID);
        
        PFQuery *query=[PFQuery queryWithClassName:@"images"];
        [query whereKey:@"facebookID" equalTo:_mainUserID];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (objects.count!=0) {
                _m_arrImage=objects;
                
                                 [self.m_TableViewHome   reloadData];
            }
            else if(objects.count==0)
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"MESSAGE" message:@"Image Folder Is Empty . Select Icon to Update New Image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                SettingsViewController *svc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"settingsView"];
                
                [self.navigationController pushViewController:svc animated:YES];
            }
            
        }];
    }

    isFullScreen = false;
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgToFullScreen)];
    tap.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _m_arrImage.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    imagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.tag = indexPath.row;
    
    PFFile *object = [[_m_arrImage   objectAtIndex:indexPath.row] objectForKey:@"imagess"];
    
    NSLog(@"%@ is ul", object.url);
    
  // [cell.m_imageView   sd_setImageWithURL:[NSURL URLWithString:object.url]];
    [cell.m_imageView sd_setImageWithURL:[NSURL URLWithString:object.url] placeholderImage:[UIImage imageNamed:@"placeholder.png" ]];
    
    

//    cell.m_Label_Profile.text=[m_Label_Array objectAtIndex:indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:self options:nil];
    
    if (nib)
    {
        imagesTableViewCell  * cell = [nib objectAtIndex:0];
       
        return cell.frame.size.height + 285.0f;
        
    }
    
    return 230.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    imagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.tag = indexPath.row;
    
    PFFile *object = [[_m_arrImage   objectAtIndex:indexPath.row] objectForKey:@"imagess"];
    _imageTime=[[_m_arrImage objectAtIndex:indexPath.row] objectForKey:@"addTime"];
    NSLog(@"%@ is ul", _imageTime);
    
    [cell.m_imageView   sd_setImageWithURL:[NSURL URLWithString:object.url]];
    _img=cell.m_imageView;
    ProfileViewController *pvc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self.navigationController pushViewController:pvc animated:YES];
    
    pvc.selectedImage=cell.m_imageView;
    
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;
{
    BOOL shouldReceiveTouch = YES;
    
    if (gestureRecognizer == tap) {
        shouldReceiveTouch = (touch.view == _img);
    }
    return shouldReceiveTouch;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isDeleteView==NO) {
        imagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        
        cell.tag = indexPath.row;
        _imageTime=[[_m_arrImage objectAtIndex:indexPath.row] objectForKey:@"addTime"];
        PFQuery *query=[PFQuery queryWithClassName:@"images"];
        [query whereKey:@"facebookID" equalTo:_mainUserID];
        [query whereKey:@"addTime" equalTo:_imageTime];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            
            if (!error) {
                NSLog(@"%@ is ul", object);
                
                [object deleteInBackground];
                
                [_m_arrImage removeObjectAtIndex:indexPath.row];
                //            ImageViewController *ivc=[[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"ImageViewController"];
                //            [self.navigationController pushViewController:ivc animated:YES];
            }
            
            [self.m_TableViewHome reloadData];
            cell.hidden=YES;
            
        }];

    }
    else
    {
        NSLog(@"flkdpo");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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

@end
