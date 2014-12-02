//
//  MessagesListViewController.h
//  DatingApp
//
//  Created by CrayonLabs on 8/29/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagesListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *m_MessageTableViewCell;
@property (assign,nonatomic) BOOL isMessagesView;
@property (nonatomic,strong)IBOutlet UIBarButtonItem *leftBarButton;
@property (nonatomic,strong)IBOutlet UIBarButtonItem *rightBarButton;

@end
