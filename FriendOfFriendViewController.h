//
//  FriendOfFriendViewController.h
//  DatingApp
//
//  Created by CrayonLabs on 8/15/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendOfFriendViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionViewCell *m_ImageFOFCells;

@property (strong,nonatomic) IBOutlet UICollectionView *m_CollectionView;
@property (strong, nonatomic) IBOutletCollection(UICollectionViewCell) NSArray *m_ImagesOfFriends;


@property (nonatomic, strong) IBOutlet UIBarButtonItem *leftBarButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *rightBarButton;
@property (strong, nonatomic) IBOutlet UILabel *m_LabelFriendsof;
@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat interItemSpacingY;
@property (strong, nonatomic) IBOutlet UILabel *m_FOFName;
@property (nonatomic) NSInteger numberOfColumns;

@end
