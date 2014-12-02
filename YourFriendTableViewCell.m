//
//  YourFriendTableViewCell.m
//  DatingApp
//
//  Created by CrayonLabs on 8/13/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import "YourFriendTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "MessagesListViewController.h"
#import <Parse/Parse.h>

@implementation YourFriendTableViewCell

-(id)initWithFrame:(CGRect)frame
{
    self = [super   initWithFrame:frame];
    
    if (self)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"YourFriendTableViewCell" owner:self options:nil];
        self = [nib objectAtIndex:0];
    }
    
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    
    self.m_ButtonAsk.layer.cornerRadius = 3.0f;
    self.m_ButtonAsk.layer.masksToBounds  = YES;
    
    self.m_ButtonAsk.layer.borderColor = [[UIColor   redColor] CGColor];
    self.m_ButtonAsk.layer.borderWidth = 1.0f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
}

- (IBAction)actionAskPress:(id)sender
{
    
    [_theDelegate   methodAskCalledFromCell:self withSender:sender];
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"REQUEST CHAT" message:@"You want to send request" delegate:self cancelButtonTitle:@"Cancel request" otherButtonTitles:@"Send request",nil ];
    [alert show];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUserDefaults *cellDefaults=[NSUserDefaults standardUserDefaults];
    NSString *_m_iduser=[cellDefaults objectForKey:@"RequestID"];
    NSLog(@"%@",_m_iduser);
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Send request"])
    {
        NSPredicate *predicate=[NSPredicate predicateWithFormat:@"facebookID==%@",_m_iduser];
        PFQuery *query=[PFQuery queryWithClassName:@"userData" predicate:predicate];
        [query whereKey:@"facebookID" equalTo:_m_iduser];
        NSLog(@"%@",_m_iduser);
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (objects.count==0) {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Person you want to chat is not on this app" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:@"App Request", nil];
                [alert show];
            }
            else
            {
                // Notify table view to reload the recipes from Parse cloud
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshTable" object:self];
                // Dismiss the controller
           //     [self dismissViewControllerAnimated:YES completion:nil];
            ///    ViewController *SPHvc=[[ViewController alloc ]initWithNibName:@"SPHViewController" bundle:nil];
//                SPHvc.isAssignView=YES;
//                SPHvc.isMessageView=NO;
            //    [self.navigationController pushViewController:SPHvc animated:YES];
                //  SPHvc.messangerID=_m_iduser;
               // SPHvc.messangername=_m_nameFriend;
                
             //   SPHvc.messangerID=_m_iduser;
                
                
                NSLog(@"Button 1 was selected.");
            }
        }];

      
        // Dismiss the controller
        
        
        
        
    }
    else if([title isEqualToString:@"Cancel request"])
    {
        NSLog(@"Button 2 was selected.");
    }
    
    
}

@end
