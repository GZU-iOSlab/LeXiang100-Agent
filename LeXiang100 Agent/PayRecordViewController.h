//
//  PayRecordViewController.h
//  LeXiang100 Agent
//
//  Created by 任魏翔 on 14-7-4.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectionAPI.h"
#import "UIColorForiOS7Colors.h"
@interface PayRecordViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITextField * backgroudText;
    UIDatePicker * startDatePicker;
    UITextField * startMonthText;
    Boolean startDatePickerShowed;
    UIButton * dateSureBtn;
    UILabel * startLeftLabel;
    NSDateFormatter * formatter;
}
@property (nonatomic,strong) NSMutableArray * tableCellArray;
@property (nonatomic,strong) NSMutableArray * tableArray;
@property (nonatomic,strong) UITableView *recordTableview;

@end
