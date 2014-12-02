//
//  BuyCoinsViewController.h
//  DatingApp
//
//  Created by CrayonLabs on 10/7/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface BuyCoinsViewController : UIViewController<UINavigationControllerDelegate,SKProductsRequestDelegate,SKPaymentTransactionObserver,UIActionSheetDelegate>
{
    SKProductsRequest *productsRequest;
    NSArray *validProducts;
    UIActivityIndicatorView *activityIndicatorView;
    IBOutlet UILabel *productTitleLabel;
    IBOutlet UILabel *productDescriptionLabel;
    IBOutlet UILabel *productPriceLabel;
    IBOutlet UIButton *purchaseButton;
}
- (void)fetchAvailableProducts;
- (BOOL)canMakePurchases;
- (void)purchaseMyProduct:(SKProduct*)product;
- (IBAction)purchase:(id)sender;
- (IBAction)m_ClickTitle:(id)sender;
- (IBAction)m_ClickDescrition:(id)sender;
- (IBAction)m_ClickPrice:(id)sender;
@property (strong,nonatomic) NSString * numberOfCoins;
@property (assign,nonatomic) BOOL isSettingView;
@property (assign,nonatomic) BOOL isHomeView;
@property (strong, nonatomic) IBOutlet UIButton *m_buttonTitle;
@property (strong, nonatomic) IBOutlet UIButton *m_buttonCoins;
@property  int CoinsPrice;
@end
