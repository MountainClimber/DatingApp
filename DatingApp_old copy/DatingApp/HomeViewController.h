//
//  HomeViewController.h
//  DatingApp
//
//  Created by CrayonLabs on 16/07/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface HomeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *m_TableViewHome;

@property (nonatomic,strong)IBOutlet UIBarButtonItem *leftBarButton;
@property (nonatomic,strong)IBOutlet UIBarButtonItem *rightBarButton;

@property (nonatomic,strong) NSMutableArray *m_Image_Array;
@property (nonatomic,strong) NSMutableArray *m_Label_Array;

@end
