//
//  BuyCoinsViewController.m
//  DatingApp
//
//  Created by CrayonLabs on 10/7/14.
//  Copyright (c) 2014 CrayonLabs. All rights reserved.
//

#import "BuyCoinsViewController.h"
#import <Parse/Parse.h>

//#define kTutorialPointProductID  ;
@interface BuyCoinsViewController ()
@property (strong,nonatomic) NSString *kTutorialPointProductID;
@property (strong,nonatomic) NSString *m_coinValue;
@end

@implementation BuyCoinsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Adding activity indicator
//    activityIndicatorView = [[UIActivityIndicatorView alloc]
//                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    activityIndicatorView.center = self.view.center;
//    [activityIndicatorView hidesWhenStopped];
//    [self.view addSubview:activityIndicatorView];
   // [activityIndicatorView startAnimating];
    //Hide purchase button initially
    purchaseButton.hidden = YES;
    [self fetchAvailableProducts];
    
    
    UIAlertView *alert=[[UIAlertView alloc ] initWithTitle:@"HELP" message:@"For Buy Coins Click On 'Select Title' , Then Pick Package ,After Selecting Package Click On 'Select Coins' And Choose No Of Coins And Wait For Purchase" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
    if (_isSettingView==YES) {
//        _m_buttonCoins.hidden=YES;
//        _m_buttonTitle.hidden=YES;
        productTitleLabel.text=[NSString stringWithFormat:@"Rechange Coins"];
        productDescriptionLabel.text=[NSString stringWithFormat:@"%d Coins",_CoinsPrice];
        productPriceLabel.text=[NSString stringWithFormat:@"%d",_CoinsPrice];
    }
    else if(_isHomeView==NO)
    {
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchAvailableProducts{
//    NSSet *productIdentifiers = [NSSet
//                                 setWithObjects:kTutorialPointProductID,nil];
//    productsRequest = [[SKProductsRequest alloc]
//                       initWithProductIdentifiers:productIdentifiers];
//    productsRequest.delegate = self;
//    [productsRequest start];
}

- (BOOL)canMakePurchases
{
    return [SKPaymentQueue canMakePayments];
}
- (void)purchaseMyProduct:(SKProduct*)product{
    if ([self canMakePurchases]) {
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"Purchases are disabled in your device" message:nil delegate:
                                  self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
    }
}
-(IBAction)purchase:(id)sender{
    [self purchaseMyProduct:[validProducts objectAtIndex:0]];
    purchaseButton.enabled = NO;
}

- (IBAction)m_ClickTitle:(id)sender {
    
    if([productTitleLabel.text isEqualToString:@"None"])
        {
    
    UIActionSheet *actionSheet1 = [[UIActionSheet alloc] initWithTitle:@"Pick Package:"
                                                              delegate:self
                                                     cancelButtonTitle:nil
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"Coins",@"None", nil];
    [actionSheet1 showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
    
    [actionSheet1 showInView:self.view];
    actionSheet1.tag=3;
            productPriceLabel.text=@" ";
            productDescriptionLabel.text=@" ";
    _m_buttonCoins.hidden=NO;
        }
    else
    {
        UIActionSheet *actionSheet1 = [[UIActionSheet alloc] initWithTitle:@"Pick Package:"
                                                                  delegate:self
                                                         cancelButtonTitle:nil
                                                    destructiveButtonTitle:nil
                                                         otherButtonTitles:@"Coins",@"None", nil];
        [actionSheet1 showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
        
        [actionSheet1 showInView:self.view];
        actionSheet1.tag=3;
        _m_buttonCoins.hidden=NO;

    }
}

- (IBAction)m_ClickDescrition:(id)sender
{
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.center = self.view.center;
    activityIndicatorView.color=[UIColor blackColor];
    [activityIndicatorView hidesWhenStopped];
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];

    
    UIActionSheet *actionSheet1 = [[UIActionSheet alloc] initWithTitle:@"Pick Package:"
                                                              delegate:self
                                                     cancelButtonTitle:nil
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:@"1", @"5", @"10", @"20",@"30",@"50", @"75", @"85",@"None", nil];
    [actionSheet1 showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
    
    [actionSheet1 showInView:self.view];
    actionSheet1.tag=4;
    

}

//- (IBAction)m_ClickPrice:(id)sender {
//    UIActionSheet *actionSheet1 = [[UIActionSheet alloc] initWithTitle:@"Pick Package:"
//                                                              delegate:self
//                                                     cancelButtonTitle:nil
//                                                destructiveButtonTitle:nil
//                                                     otherButtonTitles:@"$1", @"$5", @"$10", @"$25",@"$50", @"$75", @"$100", @"$125",@"None", nil];
//    [actionSheet1 showFromRect:[(UIButton *)sender frame] inView:self.view animated:YES];
//    
//    [actionSheet1 showInView:self.view];
//    actionSheet1.tag=5;
//
//}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    int coinValue=0;
    
    if (actionSheet.tag==3)
    {
        if (buttonIndex==0)
        {
        
        
        productTitleLabel.text=[NSString stringWithFormat:@"%@",[actionSheet buttonTitleAtIndex:buttonIndex]];
        [_m_buttonTitle setTitle:@" " forState:UIControlStateNormal];
        productPriceLabel.text=@" ";
        productDescriptionLabel.text=@" ";
        _m_buttonCoins.hidden=NO;
    }
    else if (buttonIndex==1)
    {
        productTitleLabel.text=[NSString stringWithFormat:@"%@",[actionSheet buttonTitleAtIndex:buttonIndex]];
        [_m_buttonTitle setTitle:@" " forState:UIControlStateNormal];
        productPriceLabel.text=@"None";
        productDescriptionLabel.text=@"None";
        purchaseButton.hidden=YES;
        _m_buttonCoins.hidden=YES;

    }
}
    if (actionSheet.tag==4)
    {
        productDescriptionLabel.text=[NSString stringWithFormat:@"%@",[actionSheet buttonTitleAtIndex:buttonIndex]];
        [_m_buttonCoins setTitle:@" " forState:UIControlStateNormal];
        
        if (buttonIndex==0)
        {
            productPriceLabel.text=[NSString stringWithFormat:@"$ 1"];
            _kTutorialPointProductID=@"com.DatingApp_Coins";
            NSSet *productIdentifiers = [NSSet
                                         setWithObjects:_kTutorialPointProductID,nil];
            productsRequest = [[SKProductsRequest alloc]
                               initWithProductIdentifiers:productIdentifiers];
            productsRequest.delegate = self;
            [productsRequest start];
            coinValue=1;

        }
        else if (buttonIndex==1)
        {
            _kTutorialPointProductID=@"com.DatingApp5Coin";
            productPriceLabel.text=[NSString stringWithFormat:@"$ 5"];
            NSSet *productIdentifiers = [NSSet
                                         setWithObjects:_kTutorialPointProductID,nil];
            productsRequest = [[SKProductsRequest alloc]
                               initWithProductIdentifiers:productIdentifiers];
            productsRequest.delegate = self;
            [productsRequest start];
            coinValue=5;

        }
        else if (buttonIndex==2)
        {
            productPriceLabel.text=[NSString stringWithFormat:@"$ 10"];
            _kTutorialPointProductID=@"com.DatingApp_Coins_10";
                        NSSet *productIdentifiers = [NSSet
                                         setWithObjects:_kTutorialPointProductID,nil];
            productsRequest = [[SKProductsRequest alloc]
                               initWithProductIdentifiers:productIdentifiers];
            productsRequest.delegate = self;
            [productsRequest start];
            coinValue=10;
            
            
        }
        else if (buttonIndex==3)
        {
            productPriceLabel.text=[NSString stringWithFormat:@"$ 20"];
            _kTutorialPointProductID=@"com.DatingApp_Coins_20";
            NSSet *productIdentifiers = [NSSet
                                         setWithObjects:_kTutorialPointProductID,nil];
            productsRequest = [[SKProductsRequest alloc]
                               initWithProductIdentifiers:productIdentifiers];
            productsRequest.delegate = self;
            [productsRequest start];
            coinValue=20;

        }
        else if (buttonIndex==4)
        {
            productPriceLabel.text=[NSString stringWithFormat:@"$ 30"];
            _kTutorialPointProductID=@"com.DatingApp_Coins_30";
            NSSet *productIdentifiers = [NSSet
                                         setWithObjects:_kTutorialPointProductID,nil];
            productsRequest = [[SKProductsRequest alloc]
                               initWithProductIdentifiers:productIdentifiers];
            productsRequest.delegate = self;
            [productsRequest start];
            coinValue=30;
        }
        else if (buttonIndex==5)
        {
            productPriceLabel.text=[NSString stringWithFormat:@"$ 50"];
            _kTutorialPointProductID=@"com.DatingApp_Coins_50";
            NSSet *productIdentifiers = [NSSet
                                         setWithObjects:_kTutorialPointProductID,nil];
            productsRequest = [[SKProductsRequest alloc]
                               initWithProductIdentifiers:productIdentifiers];
            productsRequest.delegate = self;
            [productsRequest start];
            coinValue=50;
        }
        else if (buttonIndex==06)
        {
            productPriceLabel.text=[NSString stringWithFormat:@"$ 75"];
            _kTutorialPointProductID=@"com.DatingApp_Coins_75";
            NSSet *productIdentifiers = [NSSet
                                         setWithObjects:_kTutorialPointProductID,nil];
            productsRequest = [[SKProductsRequest alloc]
                               initWithProductIdentifiers:productIdentifiers];
            productsRequest.delegate = self;
            [productsRequest start];
            coinValue=75;
        }
        else if (buttonIndex==07)
        {
            productPriceLabel.text=[NSString stringWithFormat:@"$ 100"];
            _kTutorialPointProductID=@"com.DatingApp_Coins_100";
            NSSet *productIdentifiers = [NSSet
                                         setWithObjects:_kTutorialPointProductID,nil];
            productsRequest = [[SKProductsRequest alloc]
                               initWithProductIdentifiers:productIdentifiers];
            productsRequest.delegate = self;
            [productsRequest start];
            coinValue=100;
        }
    }
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString *mainUserID=[defaults valueForKey:@"mainUserID"];
    
    PFQuery *query1=[PFQuery queryWithClassName:@"userData"];
    [query1 whereKey:mainUserID equalTo:@"facebookID"];
    [query1 getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        NSString *str=[object objectForKey:@"noOfcions"];
        int coins=[str intValue]+coinValue;
        _m_coinValue=[NSString stringWithFormat:@"%d",coins];
    }];
    
    
   
   
    PFQuery *query=[PFQuery queryWithClassName:@"userData"];
    [query whereKey:mainUserID equalTo:@"facebookID"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        [object setObject:_m_coinValue forKey:@"noOfcoins"];
        [object saveInBackground];
    }];
    
    
    
}
#pragma mark StoreKit Delegate

-(void)paymentQueue:(SKPaymentQueue *)queue
updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"Purchasing");
                break;
            case SKPaymentTransactionStatePurchased:
                if ([transaction.payment.productIdentifier
                     isEqualToString:_kTutorialPointProductID])
                {
                    NSLog(@"Purchased ");
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                              @"Purchase is completed succesfully" message:nil delegate:
                                              self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [alertView show];
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Restored ");
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"Purchase failed ");
                break;
            default:
                break;
        }
    }
}

-(void)productsRequest:(SKProductsRequest *)request
    didReceiveResponse:(SKProductsResponse *)response
{
    SKProduct *validProduct = nil;
    int count = [response.products count];
    if (count>0)
    {
        validProducts = response.products;
        validProduct = [response.products objectAtIndex:0];
        if ([validProduct.productIdentifier
             isEqualToString:_kTutorialPointProductID])
        {
            [productTitleLabel setText:[NSString stringWithFormat:
                                        @"%@",validProduct.localizedTitle]];
            [productDescriptionLabel setText:[NSString stringWithFormat:
                                              @" %@",validProduct.localizedDescription]];
            [productPriceLabel setText:[NSString stringWithFormat:
                                        @"%@",validProduct.price]];
        }
    }
    else
    {
        UIAlertView *tmp = [[UIAlertView alloc]
                            initWithTitle:@"Not Available"
                            message:@"No products to purchase"
                            delegate:self
                            cancelButtonTitle:nil
                            otherButtonTitles:@"Ok", nil];
        [tmp show];
    }    
    [activityIndicatorView stopAnimating];
    purchaseButton.hidden = NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
