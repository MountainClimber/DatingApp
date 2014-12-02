//
//  Settings1ViewController.m
//  DatingApp
//
//  Created by CrayonLabs on 8/13/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import "Settings1ViewController.h"

@interface Settings1ViewController ()

@end

@implementation Settings1ViewController

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
    
    UIImage* image32 = [UIImage imageNamed:@"comment.png"];
    CGRect frameimg2 = CGRectMake(0, 0, image32.size.width, image32.size.height);
    UIButton *someButton2 = [[UIButton alloc] initWithFrame:frameimg2];
    [someButton2 setBackgroundImage:image32 forState:UIControlStateNormal];
    [someButton2 addTarget:self action:@selector(pressedRightBarButton:)
          forControlEvents:UIControlEventTouchUpInside];
    someButton2.layer.cornerRadius=5.0f;
    [someButton2 setShowsTouchWhenHighlighted:YES];
    
    _rightBarButton =[[UIBarButtonItem alloc] initWithCustomView:someButton2];
    
    self.navigationItem.rightBarButtonItem=_rightBarButton;
    
    
    self.m_LabelCoinValues.text=@"$6";

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

- (IBAction)buttonSearchSC:(id)sender {
    
    
    
}

- (IBAction)sliderCoinValue:(UISlider *)sender {
   int progress2 = lroundf(sender.value);
    self.m_LabelCoinValues.text = [NSString stringWithFormat:@"$%d", progress2];
    NSLog(@"search distance %d",progress2);
    
    
    
}





- (IBAction)buttonMyImages:(id)sender {
}

- (IBAction)switchRechange:(UISwitch *)sender {
}

- (IBAction)switchStranger:(UISwitch *)sender {
    if ([sender isOn]) {
        NSLog(@"Lation switch on");
    }
    else
    {
        NSLog(@"Lation switch off");
    }

}

- (IBAction)switchFriendsOfFriends:(UISwitch *)sender {
    if ([sender isOn]) {
        NSLog(@"Lation switch on");
    }
    else
    {
        NSLog(@"Lation switch off");
    }

}

- (IBAction)switchStrangers:(id)sender {
    if ([sender isOn]) {
        NSLog(@"Lation switch on");
    }
    else
    {
        NSLog(@"Lation switch off");
    }

}
@end
