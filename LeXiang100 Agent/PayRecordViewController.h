//
//  PayRecordViewController.h
//  LeXiang100 Agent
//
//  Created by 任魏翔 on 14-7-4.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayRecordViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
        UITextField * backgroudText;
        UIDatePicker * startDatePicker;
        UIDatePicker * endDatePicker;
        UITextField * startMonthText;
        UITextField * endMonthText;
        Boolean startDatePickerShowed;
        Boolean endDatePickerShowed;
        UIButton * dateSureBtn;
        UILabel * startLeftLabel;
        UILabel * endLeftLabel;
        
        NSDateFormatter * formatter;
}
@property (nonatomic,strong) NSMutableArray * tableCellArray;
@property (nonatomic,strong) NSMutableArray * tableArray;
@property (nonatomic,strong) UITableView *recordTableview;

@end
