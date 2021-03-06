//
//  SpecialOfferViewController.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-22.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionAPI.h"
#import "UIColorForiOS7Colors.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "AddresseBookTableViewController.h"

@interface PayViewController : UIViewController<UITextFieldDelegate, UIAlertViewDelegate>{
    
    UITextField * bossPWD;
    AddresseBookTableViewController * addressBook;
    UILabel * busiLabel;
    UITextField * busiText;
    
    UIAlertView *confirmPayAlert;
    
}


@property (nonatomic,strong)UIAlertView * alerts;
//@property (retain,nonatomic) PayInfo *payInfo;
- (void) dimissAlert:(UIAlertView *)alert;
@end
