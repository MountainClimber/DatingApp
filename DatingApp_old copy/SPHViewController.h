//
//  SPHViewController.h
//  SPHChatBubble
//
//  Created by Siba Prasad Hota  on 10/18/13.
//  Copyright (c) 2013 Wemakeappz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"
#import "MNMPullToRefreshManager.h"

@class QBPopupMenu;

@interface SPHViewController : UIViewController<HPGrowingTextViewDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MNMPullToRefreshManagerClient>
{
     NSMutableArray *sphBubbledata;
     UIView *containerView;
     HPGrowingTextView *textView;
     int selectedRow;
     BOOL newMedia;
    NSTimer *timer;
    BOOL isLoading;
    BOOL isFirst;
    NSDate *createdAt;
    NSString *lastMEssage;
    NSMutableArray *arrMEssages;
    
}
@property (nonatomic, readwrite, assign) NSUInteger reloads;
@property (nonatomic, readwrite, strong) MNMPullToRefreshManager *pullToRefreshManager;
@property (nonatomic,strong)IBOutlet UIBarButtonItem *rightBarButton;

@property (weak, nonatomic) IBOutlet UIImageView *Uploadedimage;
@property (nonatomic, strong) QBPopupMenu *popupMenu;
@property (weak, nonatomic) IBOutlet UITableView *sphChatTable;
@property (nonatomic, retain) UIImagePickerController *imgPicker;
@property (strong,nonatomic) NSString* messangername;
@property (strong,nonatomic) NSString * messangerID;
@property (strong , nonatomic) NSString * user_ID;
@property (assign , nonatomic) BOOL isMessageView;
@property (assign , nonatomic) BOOL isAssignView;
@property (assign , nonatomic) BOOL isShowMeView;
@property (assign , nonatomic) BOOL notShowMEView;

@property (strong,nonatomic) NSString *primaryKey;


- (IBAction)endViewedit:(id)sender;

- (void) handleURL:(NSURL *)url;

@end
