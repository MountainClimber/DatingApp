//
//  YourFriendViewController.h
//  DatingApp
//
//  Created by CrayonLabs on 8/13/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MutiualFriendViewController.h"
@interface YourFriendViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>

@property(strong,nonatomic) UIView *footerView;
@property (strong, nonatomic) IBOutlet UITableView *m_TableView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *leftBarButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *rightBarButton;
@property (strong, nonatomic) IBOutlet UIButton *m_buttonMore;
@property (assign,nonatomic) NSString* isbackView;
- (IBAction)b_buttonMore:(id)sender;
- (IBAction)searchFriends:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *m_searchTextField;
@property (strong, nonatomic) IBOutlet UIButton *m_SearchButton;

@end
