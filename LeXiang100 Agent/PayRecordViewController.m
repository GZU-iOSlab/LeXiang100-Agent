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
extern NSMutableDictionary * userDic;
extern ConnectionAPI * soap;
extern NSNotificationCenter *nc;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"缴费查询";
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        [nc addObserver:self selector:@selector(showTableview:) name:@"queryPayHistory" object:nil];
        self.tableArray = [[NSMutableArray alloc]init];
        self.tableCellArray  = [[NSMutableArray alloc]init];
        self.recordTableview = [[UITableView alloc]initWithFrame:CGRectMake(viewWidth/10, viewHeight/2, viewWidth, viewHeight*6/10)style:UITableViewStylePlain];
        self.recordTableview.delegate = self;
        self.recordTableview.dataSource = self;
        //self.recordTableview.userInteractionEnabled = NO;
        
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
        
        startMonthText = [[UITextField alloc]initWithFrame:CGRectMake(viewWidth/9.5, viewHeight/160, viewWidth*0.75, viewHeight/25)];
        startMonthText.borderStyle = UITextBorderStyleRoundedRect;
        startMonthText.backgroundColor = [UIColor whiteColor];
        startMonthText.delegate = self;
        startMonthText.text = @"2012/06";
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
        dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight/2+viewHeight/10);
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
        
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
        self.view.backgroundColor = [UIColor whiteColor];
        }
         if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone)
         {
             backgroudText.center=CGPointMake(viewWidth/2, viewHeight/6);
             //startDatePicker
            dateSureBtn.center=CGPointMake(viewWidth/2, viewHeight*0.8);
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
    if (textField == backgroudText || textField == startMonthText) {
        [UIView beginAnimations:@"切换" context:nil];
        [UIView setAnimationDuration:0.3];
        startDatePicker.center = CGPointMake(viewWidth/2, viewHeight/3+startDatePicker.frame.size.height/2);
        if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone) {
            dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight*0.8);
        }else
        dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight/2+viewHeight/10);
        if(self.recordTableview != nil){
            self.recordTableview.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/3);
        }
        [UIView commitAnimations];
        startDatePickerShowed = YES;
    }
    
    
    return  NO;//NO进入不了编辑模式
}

#pragma mark tableview 

- (void)showTableview:(NSNotification *)note{
    [self dateForSure];
    [UIView beginAnimations:@"下降" context:nil];
    [UIView setAnimationDuration:0.3];
    startDatePicker.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight/3);
    dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/8);
    [UIView commitAnimations];
    startDatePickerShowed = NO;
    
    [self.tableCellArray removeAllObjects];
    [self.tableArray removeAllObjects];
    if ([[[note userInfo] objectForKey:@"1"]isKindOfClass:[NSDictionary class]]) {
        NSLog(@"dic");
    }
    NSArray * cellArray = [[NSArray alloc]initWithArray:[[[note userInfo] objectForKey:@"1"]objectForKey:@"payHistories"]];
    for (NSMutableDictionary * dic in cellArray){
        NSString * str = [NSString stringWithFormat:@"手机号码:%@\n充值金额:%@元\n充值时间:%@",[dic objectForKey: @"opPhone"],[dic objectForKey: @"payMoney"],[[dic objectForKey: @"payTime"] substringWithRange:NSMakeRange(0,10)]];
        [self.tableArray addObject:str];
        NSString * str1=[NSString stringWithFormat:@"\n充值%@",[dic objectForKey: @"statusDesc"]];
        //str1 = [NSString stringWithFormat:@"%@年%@月",str2,str3];
        [self.tableCellArray addObject:str1];
        //NSLog(@"months:%@",str1);
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [UIView animateWithDuration:0.3 animations:^{self.recordTableview.center = CGPointMake(viewWidth/2, viewHeight/1.5);}];
        NSLog(@"%f",viewHeight/1.3);
    }else{
        [UIView animateWithDuration:0.3 animations:^{self.recordTableview.center = CGPointMake(viewWidth/2, viewHeight/2);}];
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
    static NSString * identifier = @"style-subtitle";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier]autorelease];
    }    // Configure the cell...
    
    NSString * text = [self.tableArray objectAtIndex:indexPath.row];
    NSString * detailtext = [self.tableCellArray objectAtIndex:indexPath.row];
    NSLog(@"text:%@ detailtext:%@",text,detailtext);
    
    UIFont *font = [UIFont systemFontOfSize:13];
    CGFloat contentWidth = self.recordTableview.frame.size.width;
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth-100, 1000) lineBreakMode:NSLineBreakByCharWrapping];
    //cell.textLabel.frame = CGRectMake(0, 0, 100, 30);
    CGRect rect = [cell.textLabel textRectForBounds:cell.textLabel.frame  limitedToNumberOfLines:0];
    rect.size =size;
    cell.textLabel.frame = rect;
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.frame = rect;
    cell.detailTextLabel.numberOfLines = 0;
    
    cell.textLabel.text = text;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:viewHeight/44];
    cell.detailTextLabel.text = detailtext;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:viewHeight/40];
    cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.textColor = [UIColor iOS7redColor];
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    // 去掉guop tableview的背景
    tableView.backgroundView = nil;
    tableView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor lightTextColor];
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//选中后的反显颜色即刻消失
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 100;
    }else
    return 50;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *header= [NSString stringWithFormat:@"共%d条记录",self.tableArray.count];
    return header;
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *header= [NSString stringWithFormat:@"共%d条记录",self.tableArray.count];
    return header;
}

- (void)dateForSure{
    
    
        //NSString * dateString = [formatter stringFromDate:startDatePicker.date];
        startMonthText.text = [formatter stringFromDate:startDatePicker.date];
    
}

- (void)recommendedsoap
{
    [UIView beginAnimations:@"下降" context:nil];
    [UIView setAnimationDuration:0.3];
    startDatePicker.center = CGPointMake(viewWidth/2, viewHeight*3/2);
    dateSureBtn.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/8);
    if(self.recordTableview != nil){
        self.recordTableview.center = CGPointMake(viewWidth/2, viewHeight+viewHeight/3);
    }
    [UIView commitAnimations];
    
    if (!([startMonthText.text isEqual:@""]))
    {
        NSString * token = [userDic objectForKey:@"token"];
        NSString *opPhone=[userDic objectForKey:@"phone"];
        NSString *start=@"2";
        NSString * startYear = [startMonthText.text substringWithRange:NSMakeRange(0,4)];
        NSString * startMonth = [startMonthText.text substringWithRange:NSMakeRange(5,2)];
        NSMutableString * startYearAndMonth = [[NSMutableString alloc]init];
        [startYearAndMonth appendString:startYear];
        [startYearAndMonth appendString:startMonth];
        [soap queryPayHistoryWithInterface:@"queryPayHistory" Parameter1:@"opPhone" OpPhone:opPhone Parameter2:@"month" Month:startYearAndMonth Parameter3:@"start" Start:start Parameter4:@"token" Token:token];
        [startYearAndMonth release];
    }
    
}



@end
