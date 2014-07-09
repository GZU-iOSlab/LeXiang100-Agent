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



@synthesize resultArray;
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
        self.view.frame = [[UIScreen mainScreen] bounds];
        
        NSLog(@"!!%f",self.view.frame.size.height);
        
        self.title = @"中国移动通信-乐享100";
       

        
    // UIImage * loginImg = [UIImage imageNamed:@"main_title_login_normal.png"];

        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"个人信息" style:UIBarButtonItemStyleBordered target:self action:@selector(showTable)];
  
        UITextView * background = [[[UITextView alloc]init]autorelease];
        background.frame = self.view.frame;
        
        
        //背景框
        UITextField * backgroundText = [[UITextField alloc]initWithFrame:CGRectMake(viewWidth/35, viewHeight/60, viewWidth/1.1, viewHeight/1.2) ];
        
        backgroundText.enabled = NO;
        backgroundText.borderStyle = UITextBorderStyleRoundedRect;
        backgroundText.backgroundColor = [UIColor clearColor];
        backgroundText.autoresizesSubviews = YES;
        [self.view addSubview:backgroundText];
        backgroundText.delegate = self;
        [self.view addSubview:backgroundText];
        
        
        //营销活动
        UIImage * markingImg = [UIImage imageNamed:@"main_marketing_normal.jpg"];
        UIImage * markingImgPressed = [UIImage imageNamed:@"main_marketing_press.jpg"];
        
        buttonMarketing = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonMarketing setBackgroundImage:markingImg forState:UIControlStateNormal];
        [buttonMarketing setImage:markingImgPressed forState:UIControlStateHighlighted];
        
        buttonMarketing.frame = CGRectMake(firstY, firstY, iconSizeX, iconSizeY);
        [self.view addSubview:buttonMarketing];
        buttonMarketing.userInteractionEnabled = YES;
        [buttonMarketing addTarget:self action:@selector(marketingPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //充值缴费
        UIImage * payImg = [UIImage imageNamed:@"main_pay_normal.jpg"];
        UIImage * payImgPressed = [UIImage imageNamed:@"main_pay_press.jpg"];
        
        buttonPay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonPay setBackgroundImage:payImg forState:UIControlStateNormal];
        [buttonPay setImage:payImgPressed forState:UIControlStateHighlighted];
        buttonPay.frame = CGRectMake(firstY, firstY + iconSizeY, iconSizeX, iconSizeY);
        [self.view addSubview:buttonPay];
        buttonPay.userInteractionEnabled = YES;
        [buttonPay addTarget:self action:@selector(payPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //信控充值
        UIImage * creditImg = [UIImage imageNamed:@"main_credit_normal.jpg"];
        UIImage * creditImgPressed = [UIImage imageNamed:@"main_credit_press.jpg"];
        
        buttonCredit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonCredit setBackgroundImage:creditImg forState:UIControlStateNormal];
        [buttonCredit setImage:creditImgPressed forState:UIControlStateHighlighted];
        buttonCredit.frame = CGRectMake(firstY, firstY + iconSizeY * 2, iconSizeX, iconSizeY);
        [self.view addSubview:buttonCredit];
        buttonCredit.userInteractionEnabled = YES;
        [buttonCredit addTarget:self action:@selector(creditPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        //选号入网
        UIImage * pickImge = [UIImage imageNamed:@"main_pick_normal.jpg"];
        UIImage * pickImgePressed = [UIImage imageNamed:@"main_pick_press.jpg"];
        
        buttonPick = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonPick setBackgroundImage:pickImge forState:UIControlStateNormal];
        [buttonPick setImage:pickImgePressed forState:UIControlStateHighlighted];
        buttonPick.frame = CGRectMake(firstY, firstY + iconSizeY * 3, iconSizeX, iconSizeY);
        [self.view addSubview:buttonPick];
        buttonPick.userInteractionEnabled = YES;
        [buttonPick addTarget:self action:@selector(pickPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        //缴费查询
        UIImage * paidImg = [UIImage imageNamed:@"main_pay_history_normal.JPG"];
        UIImage * paidImgPressed = [UIImage imageNamed:@"main_pay_history_normal.JPG"];
        
        buttonPaid = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonPaid setBackgroundImage:paidImg forState:UIControlStateNormal];
        [buttonPaid setImage:paidImgPressed forState:UIControlStateHighlighted];
        buttonPaid.frame = CGRectMake(firstY, firstY + iconSizeY * 4, iconSizeX, iconSizeY);
        [self.view addSubview:buttonPaid];
        buttonPay.userInteractionEnabled = YES;
        
        //检查更新
        UIImage * updateImg = [UIImage imageNamed:@"main_update_normal.JPG"];
        UIImage * updateImgPressed = [UIImage imageNamed:@"main_update_press.JPG"];
        
        buttonUpdate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [buttonUpdate setBackgroundImage:updateImg forState:UIControlStateNormal];
        [buttonUpdate setImage:updateImgPressed forState:UIControlStateHighlighted];
        buttonUpdate.frame = CGRectMake(firstY, firstY + iconSizeY * 5, iconSizeX, iconSizeY);
        [self.view addSubview:buttonUpdate];
        buttonPay.userInteractionEnabled = YES;
        
        
        
        
    
        
        
       
        
        
        
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
            
             //classTableview.center=CGPointMake(viewWidth*3/2, viewHeight/5);
            
            classTableview=[[UITableView alloc]initWithFrame:CGRectMake(viewWidth/2.2, viewHeight/100, viewWidth/2.8, viewHeight/6) style:UITableViewStylePlain];
            
            classTableview.delegate=self;
            classTableview.dataSource=self;
            classTableview.backgroundColor=[UIColor whiteColor];
            [self.view addSubview:classTableview];
            classTableview.center=CGPointMake(viewWidth*3/2, viewHeight/10);
            NSMutableArray *arrayValue=[[NSMutableArray alloc]init];
            [arrayValue addObject:@"   工号 : 88888888"];
            [arrayValue addObject:@"手机号: 18286057264"];
            [arrayValue addObject:@"       密码修改  "];
            [arrayValue addObject:@"          注销    "];
            array=arrayValue;
            tableShowed = NO;

        } else {
            classTableview=[[UITableView alloc]initWithFrame:CGRectMake(viewWidth/2.5, viewHeight/4, viewWidth/2, viewHeight/3.2)style:UITableViewStylePlain];
            
            classTableview.delegate=self;
            classTableview.dataSource=self;
            classTableview.backgroundColor=[UIColor whiteColor];
            [self.view addSubview:classTableview];
            classTableview.center=CGPointMake(viewWidth*3/2, viewHeight/5);
            NSMutableArray *arrayValue=[[NSMutableArray alloc]init];
            [arrayValue addObject:@" 工号 : 88888888"];
            [arrayValue addObject:@"手机号: 18286057264"];
            [arrayValue addObject:@"         密码修改  "];
            [arrayValue addObject:@"            注销    "];
            array=arrayValue;
            tableShowed = NO;
        }
    }
    return self;
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

#pragma mark ButtonClick

//营销活动
-(void)marketingPressed:(id)sender {
    
   
   TableLevle2TableViewController *tableContrl = [[TableLevle2TableViewController alloc] init];
    [self.navigationController pushViewController:tableContrl animated:YES];
}
//充值缴费
-(void)payPressed:(id)sender{
    
    PayValueViewController *pay = [[PayValueViewController alloc] init];
   [self.navigationController pushViewController:pay animated:YES];
}
//控充值
-(void)creditPressed:(id)sender {
    
    [[[[UIAlertView alloc] initWithTitle:@"提示" message:@"模块建设中" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil]autorelease]show];
    
//    PayValueViewController *payValue = [[[PayValueViewController alloc] init]autorelease];
//    [self.navigationController pushViewController:payValue animated:YES];
}
//选号入网
-(void)pickPressed:(id)sender {
    
    [[[[UIAlertView alloc] initWithTitle:@"提示" message:@"模块建设中" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil]autorelease]show];
}

#pragma mark - alertview 协议


- (void)showAlerView{
    testAlert = [[UIAlertView alloc]initWithTitle:@"点击了"
                                          message:nil
                                         delegate:nil
                                cancelButtonTitle:@"取消"
                                otherButtonTitles:@"确定",nil];
    testAlert.alertViewStyle = UIAlertViewStyleDefault;
    testAlert.delegate = self;
    [testAlert show];
    [testAlert release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

- (void) dimissAlert:(UIAlertView *)alert
{
    [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex]animated:YES];
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
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
   
    cell.imageView.image=[arrayImage objectAtIndex:[indexPath row]];
    //}
    cell.backgroundColor=[UIColor groupTableViewBackgroundColor];
    cell.textLabel.text=[array objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:viewHeight/40];
    return cell;
}
-(void)showTable
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (tableShowed) {
            [UIView animateWithDuration:0.3 animations:^{self.classTableview.center = CGPointMake(viewWidth*3/2, viewHeight/10);}];
            tableShowed = NO;
            self.classTableview.hidden = YES;
        }else{
            self.classTableview.hidden = NO;
            [UIView animateWithDuration:0.3 animations:^{self.classTableview.center = CGPointMake(viewWidth/1.2, viewHeight/10);}];
            tableShowed = YES;
        }
    }else {
        if (tableShowed) {
            [UIView animateWithDuration:0.3 animations:^{self.classTableview.center = CGPointMake(viewWidth*3/2, viewHeight/5);}];
            tableShowed = NO;
            self.classTableview.hidden = YES;
        }else{
            self.classTableview.hidden = NO;
            [UIView animateWithDuration:0.3 animations:^{self.classTableview.center = CGPointMake(viewWidth/1.3, viewHeight/5);}];
            tableShowed = YES;
        }
    }
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

- (void)dealloc{
    [super dealloc];
    
    
}

@end
