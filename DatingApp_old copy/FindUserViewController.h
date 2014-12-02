//
//  FindUserViewController.h
//  DatingApp
//
//  Created by CrayonLabs on 11/1/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FindUserTableViewCell.h"
@interface FindUserViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property(strong,nonatomic) UIView *footerView;

@property (strong, nonatomic) IBOutlet UITableView *m_TableView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *leftBarButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *rightBarButton;
@property(nonatomic,strong) NSString*setDistance;
@property(nonatomic,strong) NSString*setAge;
@property(nonatomic,strong) NSString*setGender;
@property(nonatomic,strong) NSString*setAg;
@property(nonatomic,assign) BOOL isShowAll ;
@property(nonatomic,assign) BOOL isNearBy ;

@end
