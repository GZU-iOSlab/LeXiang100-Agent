//
//  PayRecordViewController.m
//  LeXiang100 Agent
//
//  Created by 任魏翔 on 14-7-4.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "PayRecordViewController.h"

//extern connectionAPI * soap;
//extern NSMutableDictionary * UserInfo;
//extern NSNotificationCenter *nc;


@interface PayRecordViewController ()

@end

@implementation PayRecordViewController
#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height
@synthesize tableCellArray;
@synthesize tableArray;
@synthesize recordTableview;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"缴费查询";
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        self.tableArray = [[NSMutableArray alloc]init];
        self.tableCellArray  = [[NSMutableArray alloc]init];
        self.recordTableview = [[UITableView alloc]initWithFrame:CGRectMake(viewWidth/10, viewHeight/2, viewWidth*4/5, 300)style:UITableViewStylePlain];
        self.recordTableview.delegate = self;
        self.recordTableview.dataSource = self;
        
        backgroudText = [[UITextField alloc]initWithFrame:CGRectMake(viewWidth/20, viewHeight/10, viewWidth*0.99, viewHeight/20) ];
        backgroudText.borderStyle = UITextBorderStyleRoundedRect;
        backgroudText.center=CGPointMake(viewWidth/2, viewHeight/10);
        backgroudText.backgroundColor = [UIColor lightTextColor];
        backgroudText.autoresizesSubviews = YES;
        backgroudText.delegate = self;
        [self.view addSubview:backgroudText];
        
        
        
        UILabel * startMonthLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewWidth/4, viewHeight/20)];
        startMonthLabel.text = @"月份：";
        startMonthLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        startMonthLabel.backgroundColor = [UIColor clearColor];
        [backgroudText addSubview:startMonthLabel];
        
        startMonthText = [[UITextField alloc]initWithFrame:CGRectMake(viewWidth/10, viewHeight/160, viewWidth*0.88, viewHeight/25)];
        startMonthText.borderStyle = UITextBorderStyleRoundedRect;
        startMonthText.backgroundColor = [UIColor whiteColor];
        startMonthText.delegate = self;
        startMonthText.text = @"2012/6";
        startMonthText.leftView = startLeftLabel;
        startMonthText.leftViewMode = UITextFieldViewModeAlways;
        [backgroudText addSubview:startMonthText];
        
        startDatePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, viewHeight/3, viewWidth, viewHeight/3)];
        startDatePicker.datePickerMode = UIDatePickerModeDate;
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
        //[startDatePicker addTarget:self action:@selector(dateForSure) forControlEvents:UIControlEventTouchUpInside];
        startDatePicker.locale = locale;
        [self.view addSubview:startDatePicker];
        startDatePickerShowed = NO;
        
        dateSureBtn =  [UIButton buttonWithType:UIButtonTypeRoundedRect];//[[UIButton alloc]initWithFrame:CGRectMake(viewWidth/2, viewHeight+viewHeight/8, viewWidth/5, viewHeight/18)];
        dateSureBtn.frame = CGRectMake(viewWidth/2, viewHeight+viewHeight/8, viewWidth/5, viewHeight/25);
        dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight/2+viewHeight/25);
        [dateSureBtn setTitle:@"确定" forState:UIControlStateNormal];
        dateSureBtn.titleLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        [dateSureBtn addTarget:self action:@selector(dateForSure) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:dateSureBtn];
        
        UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        searchBtn.frame = CGRectMake(viewWidth*0.88, viewHeight/160, viewWidth/10, viewHeight/25);
        [searchBtn setTitle:@"查询" forState:UIControlStateNormal];
        searchBtn.titleLabel.font = [UIFont systemFontOfSize:viewHeight/60];
        [searchBtn addTarget:self action:@selector(recommendedsoap) forControlEvents:UIControlEventTouchUpInside];
        searchBtn.layer.borderColor =  [UIColor grayColor].CGColor;
        searchBtn.layer.borderWidth = 0;
        [backgroudText addSubview: searchBtn];
        
        formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy/MM"];
        
         if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
         {
             backgroudText.center=CGPointMake(viewWidth/2, viewHeight/6);
             //startDatePicker
            dateSureBtn.center=CGPointMake(viewWidth/2, viewHeight*0.7);
             //searchBtn
         }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark textefield delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == backgroudText) {
        [UIView beginAnimations:@"下降" context:nil];
        [UIView setAnimationDuration:0.3];
        startDatePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
        endDatePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
        dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/8);
        if(self.recordTableview != nil){
            self.recordTableview.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/3);
        }
        [UIView commitAnimations];
        startDatePickerShowed = NO;
        endDatePickerShowed = NO;
    }else if(textField == startMonthText){
        if (endDatePickerShowed == YES) {
            [UIView beginAnimations:@"下降" context:nil];
            [UIView setAnimationDuration:0.3];
            endDatePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
            dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/8);
            [UIView commitAnimations];
            endDatePickerShowed = NO;
        }
        [UIView beginAnimations:@"上升" context:nil];
        [UIView setAnimationDuration:0.3];
       /* if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            startDatePicker.frame = CGRectMake(0, viewHeight/2.2, viewWidth, viewHeight/3);
            dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight/2+viewHeight/2.5);
        }else{
            startDatePicker.frame = CGRectMake(0, viewHeight/2, viewWidth, viewHeight/2);
            dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight/2+viewHeight/3);
        }*/
        startDatePickerShowed = YES;
        if(self.recordTableview != nil){
            self.recordTableview.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/3);
        }
        [UIView commitAnimations];
    }else if(textField == endMonthText){
        if (startDatePickerShowed == YES) {
            [UIView beginAnimations:@"下降" context:nil];
            [UIView setAnimationDuration:0.3];
            startDatePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
            
            dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/8);
            [UIView commitAnimations];
            
            startLeftLabel.text = [formatter stringFromDate:startDatePicker.date];
        }
        [UIView beginAnimations:@"上升" context:nil];
        [UIView setAnimationDuration:0.3];
        
        
        if(self.recordTableview != nil){
            self.recordTableview.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/3);
        }
        [UIView commitAnimations];
    }
    return  NO;//NO进入不了编辑模式
}

#pragma mark tableview 

- (void)showTableview:(NSNotification *)note{
    
    [UIView beginAnimations:@"下降" context:nil];
    [UIView setAnimationDuration:0.3];
    startDatePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
    endDatePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
    dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/8);
    [UIView commitAnimations];
    startDatePickerShowed = NO;
    endDatePickerShowed = NO;
    
    //    if (self.recordTableview != nil) {
    //        self.recordTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, viewHeight, viewWidth, viewHeight/2) style:UITableViewStyleGrouped];
    //    }else{
    //        self.recordTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, viewHeight, viewWidth, viewHeight/2) style:UITableViewStyleGrouped];
    //    }
    
    [self.tableCellArray removeAllObjects];
    [self.tableArray removeAllObjects];
    NSArray * cellArray = [[NSArray alloc]initWithArray:[[note userInfo] objectForKey:@"1"]];
    for (NSMutableDictionary * dic in cellArray){
        NSString * str = [NSString stringWithFormat:@"总推荐量%@笔,成功%@笔，失败%@笔",[dic objectForKey: @"totalRecommend"],[dic objectForKey: @"succRecommend"],[dic objectForKey: @"failRecommend"]];
        [self.tableCellArray addObject:str];
        NSString * str1=[dic objectForKey: @"months"];
        NSString * str2 = [str1 substringWithRange:NSMakeRange(0, 4)];
        NSString * str3 = [str1 substringWithRange:NSMakeRange(4, 2)];
        str1 = [NSString stringWithFormat:@"%@年%@月",str2,str3];
        [self.tableArray addObject:str1];
        NSLog(@"months:%@",str1);
    }
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [UIView animateWithDuration:0.3 animations:^{self.recordTableview.center = CGPointMake(viewWidth/2, viewHeight/1.3);}];
        NSLog(@"%f",viewHeight/1.3);
    }else{
        [UIView animateWithDuration:0.3 animations:^{self.recordTableview.center = CGPointMake(viewWidth/2, viewHeight/1.4);}];
    }
    [self.view addSubview:self.recordTableview];
    [self.recordTableview reloadData];
    NSLog(@"%f",self.recordTableview.center.y);
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"return:%d",[self.tableArray count]);
    return [self.tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArray.count >5) {
        tableView.scrollEnabled = YES;
    }else
        tableView.scrollEnabled = NO;
    tableView.tableHeaderView = nil;
    //tableView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    static NSString * identifier = @"basis-cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        
    }    // Configure the cell...
    NSString * text = [self.tableArray objectAtIndex:indexPath.row];
    NSString * detailtext = [self.tableCellArray objectAtIndex:indexPath.row];
    NSLog(@"text:%@ detailtext:%@",text,detailtext);
    cell.textLabel.text = text;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:viewHeight/35];
    cell.detailTextLabel.text = detailtext;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:viewHeight/35];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    // 去掉guop tableview的背景
    tableView.backgroundView = nil;
    tableView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor lightTextColor];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
}

- (void)dateForSure{
    
    
        //NSString * dateString = [formatter stringFromDate:startDatePicker.date];
        startMonthText.text = [formatter stringFromDate:startDatePicker.date];
    
}

- (void)recommendedsoap
{
    /*[self dateForSure];
    
    [UIView beginAnimations:@"下降" context:nil];
    [UIView setAnimationDuration:0.3];
    startDatePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
    endDatePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
    dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/8);
    if(self.recordTableview != nil){
        self.recordTableview.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/3);
    }
    
    [UIView commitAnimations];
    if (!([startLeftLabel.text isEqual:@""]||[endLeftLabel.text isEqual:@""])) {
        NSString * name = [UserInfo objectForKey:@"name"];
        NSString * token = [UserInfo objectForKey:@"token"];
        NSString * startYear = [startLeftLabel.text substringWithRange:NSMakeRange(0,4)];
        NSString * startMonth = [startLeftLabel.text substringWithRange:NSMakeRange(5,2)];
        NSMutableString * startYearAndMonth = [[NSMutableString alloc]init];
        [startYearAndMonth appendString:startYear];
        [startYearAndMonth appendString:startMonth];
        NSString * endYear = [endLeftLabel.text substringWithRange:NSMakeRange(0,4)];
        NSString * endMonth = [endLeftLabel.text substringWithRange:NSMakeRange(5,2)];
        NSMutableString * endYearAndMonth = [[NSMutableString alloc]init];
        [endYearAndMonth appendString:endYear];
        [endYearAndMonth appendString:endMonth];
        [soap RecommendedRecordWithInterface:@"queryRecommendRecords" Parameter1:@"opPhone" Name:name Parameter2:@"startMonth" StartMonth:startYearAndMonth Parameter3:@"endMonth" EndMonth:endYearAndMonth Parameter4:@"token" Token:token];
        [startYearAndMonth release];
        [endYearAndMonth release];
    }
    if (self.recordTableview != nil) {
        //[self.recordTableview release];
    }*/
}



@end
