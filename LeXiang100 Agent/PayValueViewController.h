//
//  SpecialOfferViewController.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-22.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//


#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import "connectionAPI.h"
#import "UIColorForiOS7Colors.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "AddresseBookTableViewController.h"
#import "PayValueViewController.h"
#import "PayViewController.h"
#import "UIColorForiOS7Colors.h"

//#import "PayInfo.h"

@interface PayValueViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *array;
    UIButton *feedbackButton;
    UITextView *inputFeedback;
    
    NSString *selectedString;
    NSArray *arrayImage;
    BOOL tableShowed;
    
    UITextField * phoneText;
    AddresseBookTableViewController * addressBook;
    
}


@property (nonatomic,assign) UITableView * classTableview;
@property (nonatomic,assign) NSArray *array;
@property (nonatomic,assign) UIButton *payNumButton;
@property (nonatomic,assign) UITextView *inputFeedback;
@property (nonatomic,assign) UILabel *noteMessage;//提示
@property (nonatomic,assign) NSArray *arrayImage;
@property (nonatomic,assign)UITextField * phoneText;
@property (nonatomic,assign)NSString * payNumVaue;//充值金额

@end
