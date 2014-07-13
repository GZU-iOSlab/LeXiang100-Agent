//
//  MainViewController.h
//  LeXiang100 Agent
//
//  Created by ZengYifei on 14-6-24.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MainUIViewController.h"
#import "MariketingTableViewController.h"
#import "PayValueViewController.h"
#import "ConnectionAPI.h"
#import "UpdateCheckingViewController.h"
#import "PayRecordViewController.h"
#import "TestData.h"

#import "UpadtePwdViewController.h"

@interface MainUIViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>{
    
    UITextField * messageText;
    
    
    UIAlertView *testAlert;
    
    UIButton * buttonMarketing;
    UIButton * buttonPay;
    UIButton * buttonCredit;
    UIButton * buttonPick;
    UIButton * buttonPaid;
    UIButton * buttonUpdate;
    UIButton * button7;
    NSString * staffId ;
    NSArray *arrayImage;
    
    BOOL tableShowed;
    PayValueViewController *pay;
    MariketingTableViewController *marketingTableView;
    UpdateCheckingViewController * update;
    PayRecordViewController * payRecord;
    
    
    NSMutableString * payMent;
    UIAlertView * personAlert;
    //NSNotification * note;
    
}

@property (nonatomic, retain) NSMutableArray *resultArray;
@property (nonatomic,assign) UITableView * classTableview;
@property (nonatomic,assign) NSArray *array;


//-(void)personalMsgAlertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
