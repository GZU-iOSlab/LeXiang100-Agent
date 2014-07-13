
#import "PayValueViewController.h"
#import <UIKit/UIKit.h>
 

@interface PayValueViewController ()

@end

@implementation PayValueViewController

#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height



@synthesize classTableview;
@synthesize array;

@synthesize inputFeedback;
@synthesize noteMessage;
@synthesize arrayImage;

@synthesize payNumButton;
@synthesize phoneText;
@synthesize payNumVaue;

extern NSMutableDictionary * payInfoDic;

extern NSNotificationCenter *nc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //self.title = service;
        
        [nc addObserver:self selector:@selector(payMentListFeedback:) name:@"queryAllPayMoneysResponse" object:nil];
        
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一步" style:UIBarButtonItemStyleBordered target:self action:@selector(toPayPage)];
        UITextView * background = [[[UITextView alloc]init]autorelease];
        background.frame = self.view.frame;
        //[self.view addSubview: background];
        
        //通讯录tableview初始化
        addressBook = [[AddresseBookTableViewController alloc]init];
        addressBook.uerInfoArray = [[NSMutableArray alloc]init];
        
        //背景框
        UITextField * backgroundText = [[[UITextField alloc]initWithFrame:CGRectMake(viewWidth/40, viewHeight/60, viewWidth-viewWidth/20, viewHeight/2) ]autorelease];
        backgroundText.enabled = NO;
        backgroundText.borderStyle = UITextBorderStyleRoundedRect;
        backgroundText.backgroundColor = [UIColor lightTextColor];
        backgroundText.autoresizesSubviews = YES;
        [self.view addSubview:backgroundText];
        
        phoneText = [[UITextField alloc]initWithFrame:CGRectMake( viewWidth/32+viewWidth/40 , viewHeight/10 +viewWidth/40, viewWidth/1.5, viewHeight/15)];
        phoneText.delegate = self;
        phoneText.placeholder = @"请输入号码";
        phoneText.font = [UIFont systemFontOfSize:viewHeight/25];
        phoneText.borderStyle = UITextBorderStyleRoundedRect;
        phoneText.backgroundColor = [UIColor lightTextColor];
        phoneText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        [self.view addSubview:phoneText];
        
        UIButton * linkManBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        linkManBtn.frame = CGRectMake(viewWidth/1.3,viewHeight/10 +viewWidth/40, viewWidth/6, viewHeight/15);
        [linkManBtn setTitle:@"联系人" forState:UIControlStateNormal];
        linkManBtn.titleLabel.font = [UIFont systemFontOfSize:viewHeight/35];
        [linkManBtn addTarget:self action:@selector(linkMan) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:linkManBtn];
        
        UILabel * servicesLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/32+viewWidth/40, viewHeight/30, viewWidth/2, viewHeight/20)];
        servicesLabel.text = @"客户手机号码:";
        servicesLabel.backgroundColor = [UIColor clearColor];
        servicesLabel.font = [UIFont systemFontOfSize:viewHeight/35];
        //servicesLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:servicesLabel];
        
        
        
        
        //充值金额按钮
        payNumButton=[[UIButton alloc] initWithFrame:CGRectMake(viewWidth/35, viewHeight/5 + viewHeight/40,  viewWidth-viewWidth/18, viewHeight/20)];
        payNumButton.backgroundColor=[UIColor grayColor];
        [payNumButton setTitle:@"请选择充值金额" forState:UIControlStateNormal];
        [payNumButton addTarget:self action:@selector(showTables) forControlEvents:UIControlEventTouchUpInside];
        selectedString = [[NSString alloc]initWithString:@"请选择充值金额"];
        
        [payNumButton setTitle:selectedString forState:UIControlStateNormal];
        [self.view addSubview:payNumButton];
        
        UILabel * noteLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/32, viewHeight/3.2, viewWidth/1.01, viewHeight/20)];
        noteLabel.text = @"说明：只支持贵州移动手机号码充值缴费";
        noteLabel.backgroundColor = [UIColor clearColor];
        noteLabel.font = [UIFont systemFontOfSize:viewHeight/35];
        //servicesLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:noteLabel];
        
        
        //        classTableview=[[UITableView alloc]initWithFrame:CGRectMake(viewWidth/10, viewHeight/2, viewWidth*4/5, 300)style:UITableViewStylePlain];
        //
        //        classTableview.delegate=self;
        //        classTableview.dataSource=self;
        //        classTableview.backgroundColor=[UIColor whiteColor];
        //        [self.view addSubview:classTableview];
        //        classTableview.center=CGPointMake(viewWidth/2, viewHeight*1.5);
        //         array=[[NSMutableArray alloc]init];
        //        arrayValue=[[NSMutableArray alloc]init];
        //
        ////        for (int i=0; i<payMentArray.count; i++)
        ////        {
        ////            //NSLog(@"第%d个元素---%@", i, [resultArray1[i] objectForKey:@"payMoney"]);
        ////            [arrayValue addObject: payMentArray[i]] ;
        ////        }//            if (
        //
        //        [arrayValue addObject:@"10元"];
        //        [arrayValue addObject:@"20元"];
        //        [arrayValue addObject:@"30元"];
        //        [arrayValue addObject:@"50元"];
        //        [arrayValue addObject:@"100元"];
        //        [arrayValue addObject:@"200元"];
        //        [arrayValue addObject:@"300元"];
        //
        //
        //        array=arrayValue;
        //        tableShowed = NO;
        //
        //
        //        //初始化存放充值信息的字典，用来传值到下一个页面
        //        payInfoDic = [[NSMutableDictionary alloc] init];
        //        payNumVaue = [[NSMutableString alloc]init];
        
        //解决ios7界面上移  配色等问题
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars =NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
            self.navigationController.navigationBar.translucent = NO;
            classTableview.backgroundColor=[UIColor iOS7blueGradientStartColor];
            self.view .backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            
        }
        if([[[UIDevice currentDevice]systemVersion]floatValue]<7)
        {
            self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        }
        
    }
    
    //定义存放soap返回数据的数组，适用于缴费列表接口
    resultArray = [[NSMutableArray alloc] init];
    payMentArray = [[NSMutableArray alloc] init];
    
    return self;
}

- (void)viewDidDisappear:(BOOL)animated{
    [phoneText resignFirstResponder];
}


#pragma mark UesrTouche

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] != classTableview) {
        [UIView animateWithDuration:0.3 animations:^{self.classTableview.center = CGPointMake(viewWidth/2, viewHeight*3/2);}];
    }
    if ([touch view] != classTableview) {
        [phoneText resignFirstResponder];
    }
}

#pragma mark textefield delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return  YES;//NO进入不了编辑模式
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (![phoneText.text isEqualToString:@""]) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    NSLog(@"进入编辑模式时调用");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (![phoneText.text isEqualToString:@""]){
        phoneText.placeholder = @"请输入号码";
    }
    [textField resignFirstResponder];
    return YES;//NO 退出不了编辑模式
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //官方 取消第一响应者（就是退出编辑模式收键盘）
    [textField resignFirstResponder];
    return YES;
}

#pragma mark soapFeedback

- (void)payMentListFeedback:(NSNotification *)note{
    
    
    resultArray = (NSMutableArray*)[[note userInfo] objectForKey:@"1"];
    
    NSString * str = [[NSString alloc]init];
    int len = 0;
    for(int i = 0; i < resultArray.count; i++) {
        str = [resultArray[i] objectForKey:@"payMoney"];
        len = [str length];
        payMentArray[i] = [str substringToIndex:len-3];
    }
    NSLog(@"== payMentArray.count=%d==", payMentArray.count);
    
    
    classTableview=[[UITableView alloc]initWithFrame:CGRectMake(viewWidth/10, viewHeight/2, viewWidth*4/5, 300)style:UITableViewStylePlain];
    
    classTableview.delegate=self;
    classTableview.dataSource=self;
    classTableview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:classTableview];
    classTableview.center=CGPointMake(viewWidth/2, viewHeight*1.5);
    array=[[NSMutableArray alloc]init];
    
    
    
    array= payMentArray;
    tableShowed = NO;
    
    
    //初始化存放充值信息的字典，用来传值到下一个页面
    payInfoDic = [[NSMutableDictionary alloc] init];
    payNumVaue = [[NSMutableString alloc]init];
    
    
}

- (void)toPayPage{
    
    NSString * number;// = [[[NSString alloc]init]autorelease];
    
    if ([phoneText.text isEqualToString:@""]) {
        [ConnectionAPI showAlertWithTitle:@"请输入手机号" AndMessages:@"手机号码不能为空,请检查后重新输入！"];
    }else{
        number = [phoneText.text substringWithRange:NSMakeRange(0,1)];
        if (phoneText.text.length != 11 || ![number isEqualToString:@"1"]) {
            [ConnectionAPI showAlertWithTitle:@"号码错误" AndMessages:@"手机号码错误,请检查后重新输入！"];
        }
        else if ([payNumVaue isEqualToString:@""]){
            [ConnectionAPI showAlertWithTitle:@"提示" AndMessages:@"请输入充值金额！"];
        } else {
            
            [payInfoDic setObject:phoneText.text forKey:@"phoneNum"];
            [payInfoDic setObject:payNumVaue forKey:@"payNum"];
            
            
            PayViewController * payCtrl = [[PayViewController alloc]init];
            
            [self.navigationController pushViewController:payCtrl animated:YES];
            
            [payCtrl release];
            
        }
        
    }
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated{
    [inputFeedback resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{self.classTableview.center = CGPointMake(viewWidth/2, viewHeight*3/2);}];
    tableShowed = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil)
    {
        //cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault:CellIdentifier];
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
        
    }
    // if(indexPath.section==0)
    //{
    cell.imageView.image=[arrayImage objectAtIndex:[indexPath row]];
    //}
    cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
    cell.textLabel.text=[array objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:viewHeight/25];
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // NSString *header=
    return @"充值金额";
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"充值金额";
}
-(void)showTables
{
    
    
    if (tableShowed) {
        [UIView animateWithDuration:0.3 animations:^{self.classTableview.center = CGPointMake(viewWidth/2, viewHeight*3/2);}];
        tableShowed = NO;
    }else{
        [UIView animateWithDuration:0.3 animations:^{self.classTableview.center = CGPointMake(viewWidth/2, viewHeight/2);}];
        tableShowed = YES;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [UIView animateWithDuration:0.3 animations:^{self.classTableview.center = CGPointMake(viewWidth/2, viewHeight*1.5);}];
    tableShowed = NO;
    selectedString = [array objectAtIndex:indexPath.row];
    
    //获取充值金额，并赋值给payNumValue
    //payNumVaue = [[NSString alloc]initWithString:selectedString ];
    [self.payNumVaue setString:@""];
    [self.payNumVaue appendString: selectedString];
    
    [payNumButton setTitle:selectedString forState:UIControlStateNormal];
    
    
}



- (void)linkMan{
    //获取通讯录权限
    ABAddressBookRef addressBooks = ABAddressBookCreateWithOptions(NULL, NULL);
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL) {
        
        // we're on iOS 6
        NSLog(@"on iOS 6 or later, trying to grant access permission");
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    for(int i = 0; i < CFArrayGetCount(results); i++){
        ABRecordRef person = CFArrayGetValueAtIndex(results, i);
        NSMutableDictionary * dic = [[[NSMutableDictionary alloc]init]autorelease];
        NSMutableString * str = [[[NSMutableString alloc]init]autorelease];
        //读取firstname
        NSString *firstname = (NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        if(firstname != nil){
            [str appendString:firstname];
            //NSLog(@"firstname:%@",firstname);
        }
        //读取lastname
        NSString *lastname = (NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
        if(lastname != nil){
            [str appendString:lastname];
            //NSLog(@"lastname:%@",lastname);
        }
        [dic setObject:str forKey:@"name"];
        
        //获取的联系人单一属性:Generic phone number
        ABMultiValueRef tmpPhones = ABRecordCopyValue(person, kABPersonPhoneProperty);
        NSString * phoneNumber = (NSString *)ABMultiValueCopyValueAtIndex(tmpPhones, 0);
        if(phoneNumber == NULL) {
            NSLog(@"continue");
            continue;
        }
        [dic setObject:phoneNumber forKey:@"phoneNumber"];
        [addressBook.uerInfoArray addObject:dic];
    }
    [self.navigationController pushViewController:addressBook animated:YES];
}


@end
