//
//  MainViewController.h
//  LeXiang100 Agent
//
//  Created by ZengYifei on 14-6-24.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MainUIViewController.h"
#import "TableLevle2TableViewController.h"
#import "PayValueViewController.h"
#import "ConnectionAPI.h"



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
    
     NSArray *arrayImage;
    
     BOOL tableShowed;
}

@property (nonatomic, retain) NSMutableArray *resultArray;
@property (nonatomic,assign) UITableView * classTableview;
@property (nonatomic,assign) NSArray *array;



@end
