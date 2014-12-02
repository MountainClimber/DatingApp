//
//  SettingsViewController.h
//  DatingApp
//
//  Created by CrayonLabs on 16/07/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewController.h"
#import "ELCAlbumPickerController.h"
#import "ELCImagePickerController.h"

@interface SettingsViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,UITextFieldDelegate, ELCImagePickerControllerDelegate>

- (IBAction)b_ImageView:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *m_ButtonADD;
@property (nonatomic,strong)IBOutlet UIBarButtonItem *leftBarButton;
@property (strong, nonatomic) IBOutlet UITextField *m_LabelHighSC;
@property (nonatomic,strong)IBOutlet UIBarButtonItem *rightBarButton;
@property (strong, nonatomic) IBOutlet UILabel *m_Label_Distance;
@property (strong, nonatomic) IBOutlet UILabel *m_Label_Ages;
@property (strong, nonatomic) IBOutlet UIButton *m_ButtonFemale;
@property (strong, nonatomic) IBOutlet UIButton *m_buttonMale;
@property (strong, nonatomic) IBOutlet UIScrollView *m_ScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *m_ImageViewMyImages;
@property (strong, nonatomic) IBOutlet UILabel *m_LabelCoinValue;
@property (strong, nonatomic) IBOutlet UITextField *m_TextfieldCancel;
@property (strong, nonatomic) IBOutlet UIButton *m_ButtonCancel;
@property (strong, nonatomic) IBOutlet UILabel *m_LabelImage;

@property (assign,nonatomic) NSString *m_userID;
@property (assign,nonatomic) NSString *m_username;
@property (strong, nonatomic) IBOutlet UIView *m_ViewEthnicities;
@property (strong, nonatomic) IBOutlet UIButton *m_buttondropdownCaucasian;
@property (strong, nonatomic) IBOutlet UILabel *m_labelRecharge;
- (IBAction)buttondropdown:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *m_LabelEthnicities;
@property (strong, nonatomic) IBOutlet UIButton *b_ShowAll;


@property (strong, nonatomic) IBOutlet UIButton *b_female;
- (IBAction)b_gender:(id)sender;

- (IBAction)buttonShowAll:(id)sender;

- (IBAction)buttonAdd:(id)sender;
- (IBAction)CheckButtonGender:(UIButton *)sender;
- (IBAction)sliderdistance:(UISlider *)sender;
- (IBAction)sliderAges:(UISlider *)sender;
- (IBAction)switch_Caucasian:(id)sender;
- (IBAction)switch_Lation:(id)sender;
- (IBAction)sliderCoinValue:(UISlider *)sender;
- (IBAction)switchRechangeCoins:(UISwitch *)sender;
- (IBAction)switchStrangers:(UISwitch *)sender;
- (IBAction)switchFriendsOfFriends:(UISwitch *)sender;
- (IBAction)buttonShowMe:(id)sender;
- (IBAction)buttonCancel:(id)sender;
//- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)buttonSelectImage:(id)sender;
- (IBAction)buttonSearch:(id)sender;
- (IBAction)FindUser:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *m_FindUser;
@property (strong, nonatomic) IBOutlet UISlider *m_SliderSearchDistance;
@property (strong, nonatomic) IBOutlet UISlider *m_SliderShowAges;
@property (strong, nonatomic) IBOutlet UISlider *m_SliderCoinValue;
@property (strong, nonatomic) IBOutlet UISwitch *m_SwitchRechargeCoin;
@property (strong, nonatomic) IBOutlet UISwitch *m_SwitchShowme;
@property (strong, nonatomic) IBOutlet UISwitch *m_SwitchFriendsOfFriends;

@property (strong, nonatomic) IBOutlet UIButton *m_ButtonGender_Male;
@property (strong, nonatomic) IBOutlet UISwitch *m_SwitchStanger;
@property (strong, nonatomic) IBOutlet UIButton *m_ButtonGender_Female;
@property (strong, nonatomic) IBOutlet UIButton *m_femae;

@property (strong, nonatomic) IBOutlet UIButton *m_male;

@property (strong, nonatomic) IBOutlet UILabel *e_Label1;
@property (assign,nonatomic) BOOL * isSettingView;
@property (assign,nonatomic) BOOL * isNotSettingView;

@end
