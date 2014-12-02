//
//  ImageViewController.h
//  DatingApp
//
//  Created by CrayonLabs on 10/22/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController<UITableViewDataSource,UITabBarDelegate,UIGestureRecognizerDelegate>
{
    UITapGestureRecognizer *tap;
    BOOL isFullScreen;
    CGRect prevFrame;
}
@property (strong, nonatomic) IBOutlet UITableView *m_TableViewHome;
@property (nonatomic,strong)IBOutlet UIBarButtonItem *leftBarButton;
@property (assign, nonatomic) BOOL*isSettingView;
@property (assign, nonatomic) BOOL*isMutualView;
@property (assign, nonatomic) BOOL*isHomeView;
@property (assign,nonatomic) BOOL *isMutHomeView;
@property (assign,nonatomic) BOOL isDeleteView;

@property(strong,nonatomic) NSString * m_userMutualID;

@end
