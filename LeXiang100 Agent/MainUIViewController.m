//
//  MainViewController.m
//  LeXiang100 Agent
//
//  Created by ZengYifei on 14-6-24.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//


#import "MainUIViewController.h"

@interface MainUIViewController ()

@end

@implementation MainUIViewController

extern ConnectionAPI * soap;
extern TestData * testData;
extern BOOL testDataOn;


extern NSNotificationCenter *nc;
extern NSMutableDictionary * userDic;

@synthesize classTableview;
@synthesize array;



#define iOS7  ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0)?YES:NO
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?YES:NO
#define isPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)?YES:NO
#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height


#define firstX   0
# define firstY  viewHeight/50

//#endif

#define iconSizeX   viewWidth/1.06
#define iconSizeY  viewHeight/7.0
#define boo NO
#if boo
#define xe 33
#else
#define xe 44
#endif



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [nc addObserver:self selector:@selector(payPressedFeedback:) name:@"queryAllPayMoneysResponse" object:nil];
        
        
        self.view.frame = [[UIScreen mainScreen] bounds];
        
        NSLog(@"!!%f",self.view.frame.size.height);
        
        self.title = @"中国移动通信-乐享100";
        // UIImage * loginImg = [UIImage imageNamed:@"main_title_login_normal.png"];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"个人信息" style:UIBarButtonItemStyleBordered target:self action:@selector(showTable)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStyleBordered target:self action:@selector(exitSys:)];
        self.view.backgroundColor = [UIColor whiteColor];
        
        //营销活动
        UIImage * markingImg = [UIImage imageNamed:@"main_marketing_normal.jpg"];
        //UIImage * markingImgPressed = [UIImage imageNamed:@"main_marketing_press.jpg"];
        
        buttonMarketing = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonMarketing setBackgroundImage:markingImg forState:UIControlStateNormal];
        //[buttonMarketing setImage:markingImgPressed forState:UIControlStateHighlighted];
        
        buttonMarketing.frame = CGRectMake(firstY, firstY, iconSizeX, iconSizeY);
        [self.view addSubview:buttonMarketing];
        buttonMarketing.userInteractionEnabled = YES;
        [buttonMarketing addTarget:self action:@selector(marketingPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //充值缴费
        UIImage * payImg = [UIImage imageNamed:@"main_pay_normal.jpg"];
        //UIImage * payImgPressed = [UIImage imageNamed:@"main_pay_press.jpg"];
        
        buttonPay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonPay setBackgroundImage:payImg forState:UIControlStateNormal];
        //[buttonPay setImage:payImg forState:UIControlStateNormal];
        buttonPay.frame = CGRectMake(firstY, firstY + iconSizeY, iconSizeX, iconSizeY);
        [self.view addSubview:buttonPay];
        buttonPay.userInteractionEnabled = YES;
        [buttonPay addTarget:self action:@selector(payPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //信控充值
        UIImage * creditImg = [UIImage imageNamed:@"main_credit_normal.jpg"];
        //UIImage * creditImgPressed = [UIImage imageNamed:@"main_credit_press.jpg"];
        
        buttonCredit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonCredit setBackgroundImage:creditImg forState:UIControlStateNormal];
        //[buttonCredit setImage:creditImgPressed forState:UIControlStateHighlighted];
        buttonCredit.frame = CGRectMake(firstY, firstY + iconSizeY * 2, iconSizeX, iconSizeY);
        [self.view addSubview:buttonCredit];
        buttonCredit.userInteractionEnabled = YES;
        [buttonCredit addTarget:self action:@selector(creditPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        //选号入网
        UIImage * pickImge = [UIImage imageNamed:@"main_pick_normal.jpg"];
        //UIImage * pickImgePressed = [UIImage imageNamed:@"main_pick_press.jpg"];
        
        buttonPick = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonPick setBackgroundImage:pickImge forState:UIControlStateNormal];
        //[buttonPick setImage:pickImgePressed forState:UIControlStateHighlighted];
        buttonPick.frame = CGRectMake(firstY, firstY + iconSizeY * 3, iconSizeX, iconSizeY);
        [self.view addSubview:buttonPick];
        buttonPick.userInteractionEnabled = YES;
        [buttonPick addTarget:self action:@selector(pickPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        //缴费查询
        UIImage * paidImg = [UIImage imageNamed:@"main_pay_history_normal.JPG"];
        //UIImage * paidImgPressed = [UIImage imageNamed:@"main_pay_history_normal.JPG"];
        
        buttonPaid = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonPaid setBackgroundImage:paidImg forState:UIControlStateNormal];
        //[buttonPaid setImage:paidImgPressed forState:UIControlStateHighlighted];
        buttonPaid.frame = CGRectMake(firstY, firstY + iconSizeY * 4, iconSizeX, iconSizeY);
        [self.view addSubview:buttonPaid];
        buttonPaid.userInteractionEnabled = YES;
        [buttonPaid addTarget:self action:@selector(paidPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        //检查更新
        UIImage * updateImg = [UIImage imageNamed:@"main_update_normal.JPG"];
        //UIImage * updateImgPressed = [UIImage imageNamed:@"main_update_press.JPG"];
        
        buttonUpdate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonUpdate setBackgroundImage:updateImg forState:UIControlStateNormal];
        //[buttonUpdate setImage:updateImgPressed forState:UIControlStateHighlighted];
        buttonUpdate.frame = CGRectMake(firstY, firstY + iconSizeY * 5, iconSizeX, iconSizeY);
        [self.view addSubview:buttonUpdate];
        buttonUpdate.userInteractionEnabled = YES;
        [buttonUpdate addTarget:self action:@selector(updatePressed:) forControlEvents:UIControlEventTouchUpInside];
        
        //页面初始化
        pay = [[PayValueViewController alloc] init];
        marketingTableView = [[MariketingTableViewController alloc] init];
        update = [[UpdateCheckingViewController alloc]init];
        payRecord = [[PayRecordViewController alloc]init];
        
        //解决ios界面上移
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars =NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
            self.navigationController.navigationBar.translucent = NO;
            self.view.backgroundColor = [UIColor lightTextColor];
            UIImage * metal = [UIImage imageNamed:@"metal.jpg"];
            UIImageView *imgViewMetal = [[UIImageView alloc] initWithImage:metal];
            imgViewMetal.frame = CGRectMake(0, 0, viewWidth, viewHeight);
            [self.view addSubview:imgViewMetal];
            [self.view sendSubviewToBack:imgViewMetal];
        }
        
        //针对iPad的界面调整
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            
            buttonMarketing.frame = CGRectMake(firstY*2-viewWidth/30, firstY, iconSizeX, iconSizeY);
            buttonPay.frame = CGRectMake(firstY*2-viewWidth/30, firstY + iconSizeY, iconSizeX, iconSizeY);
            buttonCredit.frame = CGRectMake(firstY*2-viewWidth/30, firstY + iconSizeY * 2, iconSizeX, iconSizeY);
            buttonPick.frame =  CGRectMake(firstY*2-viewWidth/30, firstY + iconSizeY * 3, iconSizeX, iconSizeY);
            buttonPaid.frame =  CGRectMake(firstY*2-viewWidth/30, firstY + iconSizeY * 4, iconSizeX, iconSizeY);
            buttonUpdate.frame =  CGRectMake(firstY*2-viewWidth/30, firstY + iconSizeY * 5, iconSizeX, iconSizeY);
            
         
        }

        
        
    }

    return self;
}

- (void)test{
    [soap payMoneyToCustPhoneWithInterface:@"payMoneyToCustPhone" Parameter1:@"opPhone" OpPhone:@"123" Parameter2:@"payMoney" PayMoney:@"payMoney" Parameter3:@"payMoney" CustPhone:@"payMoney" Parameter4:@"payMoney" BossPwd:@"payMoney" Parameter5:@"payMoney" Token:@"payMoney"];
}

+ (void)testDataMode{
    if (testDataOn == YES) {
        testDataOn = NO;
    }else
        testDataOn = YES;
}

- (void)dealloc{
    [super dealloc];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    classTableview.hidden =YES;
    tableShowed = NO;
}

- (void)viewWillAppear:(BOOL)animated{
    classTableview.hidden =YES;
    tableShowed = NO;
}



- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
	return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
	return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
	return UIInterfaceOrientationPortrait;
}

-(BOOL) respondsToSelector : (SEL)aSelector {
    //printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);
    return [super respondsToSelector:aSelector];
}

#pragma mark soapFeedback

- (void)payPressedFeedback:(NSNotification *)note{
  
    
    self.resultArray = (NSMutableArray*)[[note userInfo] objectForKey:@"1"];
    
}

#pragma mark ButtonClick

//营销活动
-(void)marketingPressed:(id)sender {
    [self.navigationController pushViewController:marketingTableView animated:YES];
}
//充值缴费
-(void)payPressed:(id)sender {
  
    
    [soap queryAllPayMoneysWithInterface:@"queryAllPayMoneys" Parameter1:@"token" Token:[userDic objectForKey:@"token"]];
        [self.navigationController pushViewController:pay animated:YES];
}
//控充值
-(void)creditPressed:(id)sender {
    [[[[UIAlertView alloc] initWithTitle:@"提示" message:@"模块建设中" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil]autorelease]show];
}
//选号入网
-(void)pickPressed:(id)sender {
    
    [[[[UIAlertView alloc] initWithTitle:@"提示" message:@"模块建设中" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil]autorelease]show];
}

-(void)paidPressed:(id)sender{
    [self.navigationController pushViewController:payRecord animated:YES];
}

-(void)updatePressed:(id)sender{
    [self.navigationController pushViewController:update animated:YES];
    
}
//注销
-(void)exitSys:(id)sender{
   // LoginViewController *loginView = [[LoginViewController alloc] init];
    //[self.navigationController pushViewController:loginView animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - AlertView

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }else if (buttonIndex == 1){
        if([alertView isEqual:personAlert]) {
            UpadtePwdViewController * updateView = [[UpadtePwdViewController alloc]init];
           [self.navigationController pushViewController:updateView animated:YES];
            [updateView release];
        }
    }
}


-(void)showTable {
    
    staffId = [NSString stringWithFormat:@"工  号:%@ \n    手机号:%@",[userDic objectForKey:@"staffId"], [userDic objectForKey:@"phone"]];
    NSLog(@"===========satffid%@", [userDic objectForKey:@"staffId"]);
    personAlert = [[UIAlertView alloc]initWithTitle:@"个人信息" message:staffId delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改密码", nil];
    personAlert.delegate = self;
    [personAlert show];
    [personAlert release];
    
}

#pragma mark tableview delegate
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
    cell.imageView.image=[arrayImage objectAtIndex:[indexPath row]];
    //}
    cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
    cell.textLabel.text=[array objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:viewHeight/40];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UIView animateWithDuration:0.3 animations:^{self.classTableview.center = CGPointMake(viewWidth/1.3, viewHeight/5);}];
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}



#pragma mark UesrTouche

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] != classTableview) {
        [UIView animateWithDuration:0.3 animations:^{self.classTableview.center = CGPointMake(viewWidth/2, viewHeight*3/2);}];
    }
    
    
}


#pragma mark textefield delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == messageText) {
        return NO;
    }
    return  YES;//NO进入不了编辑模式
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == messageText) {
        [messageText resignFirstResponder];
    }
    NSLog(@"进入编辑模式时调用");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;//NO 退出不了编辑模式
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField.text isEqualToString: @""]) {
        textField.placeholder = @"业务搜索（中文或拼音首字母）";
    }
    NSLog(@"退出编辑模式");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //官方 取消第一响应者（就是退出编辑模式收键盘）
    [textField resignFirstResponder];
    return YES;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UIView animateWithDuration:0.3 animations:^{self.classTableview.center = CGPointMake(viewWidth/2, viewHeight*3/2);}];
    tableShowed = NO;
}


-(void)viewDidAppear:(BOOL)animated{
    //[self restoreOriginalTableView];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
