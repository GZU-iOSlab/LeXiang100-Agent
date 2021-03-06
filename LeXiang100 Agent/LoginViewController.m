//
//  LoginViewController.m
//  LeXiang100 Agent
//
//  Created by 任魏翔 on 14-7-3.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "LoginViewController.h"
#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height

#define firstX   viewWidth/10
#define secondX (viewWidth/10+viewWidth/3)
#define thirdX  (viewWidth/10+viewWidth/3*2)
#   define firstY (viewHeight/6)
#   define secondY (viewHeight/8+viewHeight/6.5)
#   define thirdY (viewHeight/8+viewHeight/6.5*2)
#   define fouthY (viewHeight/8+viewHeight/6.5*3)

@interface LoginViewController ()

@end



@implementation LoginViewController
extern NSNotificationCenter *nc;
extern ConnectionAPI * soap;
extern NSMutableDictionary * userDic;
@synthesize backgroundText;
@synthesize loginNameText;
@synthesize loginPasswordText;
@synthesize loginDPasswordText;
@synthesize UserInfoDic;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor=[UIColor scrollViewTexturedBackgroundColor];
        //self.navigationController.navigationBar.tintColor = [UIColor iOS7lightBlueColor];
        [nc addObserver:self selector:@selector(loginFeedback:) name:@"agentLogin" object:nil];
        [nc addObserver:self selector:@selector(timeCount) name:@"acquireAgentVerify" object:nil];
        mainView = [[MainUIViewController alloc]init];
        
       
        
        self.UserInfoDic = [[NSMutableDictionary alloc]init];
        
        //乐享图标
        UIImage * Image = [UIImage imageNamed:@"login_title.png"];
        UIImageView * imgView = [[UIImageView alloc]initWithImage:Image];
        imgView.frame = CGRectMake(viewWidth/2-viewWidth/6, viewHeight/16, viewWidth/3, viewWidth/6);
        [self.view addSubview:imgView];
        
        self.backgroundText = [[UITextField alloc]initWithFrame:CGRectMake(0, viewHeight/2-viewHeight/40, viewWidth*0.9, viewHeight/3)];
        self.backgroundText.borderStyle = UITextBorderStyleRoundedRect;
        self.backgroundText.backgroundColor = [UIColor lightTextColor];
        self.backgroundText.center=CGPointMake(viewWidth/2, viewHeight/2-viewHeight/8);
        self.backgroundText.delegate = self;
        [self.view addSubview:backgroundText];
        
        //手机号码标题
        UILabel * loginNameLabel = [[UILabel alloc]initWithFrame:CGRectMake( viewWidth/25 , viewHeight/40, viewWidth/5, viewHeight/18)];
        loginNameLabel.text = @"手机号码";
        loginNameLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        loginNameLabel.backgroundColor = [UIColor clearColor];
        [self.backgroundText addSubview:loginNameLabel];
        
        //手机号码输入
        self.loginNameText = [[UITextField alloc]initWithFrame:CGRectMake( viewWidth/4 , viewHeight/40, viewWidth*0.6, viewHeight/18)];
        self.loginNameText.borderStyle = UITextBorderStyleRoundedRect;
        //self.loginNameText.text=@"123";
        self.loginNameText.font = [UIFont systemFontOfSize:viewHeight/39];
        self.loginNameText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;  //垂直居中
        self.loginNameText.delegate = self;
        self.loginNameText.placeholder=@"注册乐享100的手机号码";
        self.loginNameText.clearButtonMode =UITextFieldViewModeWhileEditing;
        self.loginNameText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [self.loginNameText becomeFirstResponder];
        [self.backgroundText addSubview:self.loginNameText];
        
        //密码输入标题
        UILabel * loginPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake( viewWidth/25 , viewHeight/10, viewWidth/5, viewHeight/18)];
        loginPasswordLabel.text = @"登录密码";
        loginPasswordLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        loginPasswordLabel.backgroundColor = [UIColor clearColor];
        [self.backgroundText addSubview:loginPasswordLabel];
        
        
        //密码输入
        self.loginPasswordText = [[UITextField alloc]initWithFrame:CGRectMake( viewWidth/4 , viewHeight/10, viewWidth*0.6, viewHeight/18)];
        self.loginPasswordText.borderStyle = UITextBorderStyleRoundedRect;
        self.loginPasswordText.secureTextEntry = YES;
      //  self.loginPasswordText.text=@"qwe";
        self.loginPasswordText.delegate = self;
        self.loginPasswordText.placeholder=@"乐享100网站的登录密码";
        self.loginPasswordText.clearButtonMode =UITextFieldViewModeWhileEditing;
        self.loginPasswordText.font = [UIFont systemFontOfSize:viewHeight/39];
        self.loginPasswordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [self.backgroundText addSubview:self.loginPasswordText];
        
        //动态密码标题
        UILabel * loginDPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake( viewWidth/25 , viewHeight/10+viewHeight/15+viewHeight/100, viewWidth/5, viewHeight/18)];
        loginDPasswordLabel.text = @"动态密码";
        loginDPasswordLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        loginDPasswordLabel.backgroundColor = [UIColor clearColor];
        [self.backgroundText addSubview:loginDPasswordLabel];
        
        //动态密码输入
        self.loginDPasswordText = [[UITextField alloc]initWithFrame:CGRectMake( viewWidth/4 , viewHeight/10+viewHeight/20+viewHeight/40, viewWidth*0.4, viewHeight/18)];
        self.loginDPasswordText.borderStyle = UITextBorderStyleRoundedRect;
        //self.loginNameText.text=@"123";
        self.loginDPasswordText.font = [UIFont systemFontOfSize:viewHeight/39];
        self.loginDPasswordText.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.loginDPasswordText.delegate = self;
        self.loginDPasswordText.placeholder=@"动态密码";
        self.loginDPasswordText.clearButtonMode =UITextFieldViewModeWhileEditing;
        self.loginDPasswordText.keyboardType = UITextFieldViewModeWhileEditing;
        [self.backgroundText addSubview:self.loginDPasswordText];
        
        //获取动态密码按钮
        DPasswdBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        DPasswdBtn.frame = CGRectMake( viewWidth/2+viewWidth/6 , viewHeight/10+viewHeight/20+viewHeight/40, viewWidth*0.2, viewHeight/18);
        [DPasswdBtn setTitle:@"获 取" forState:UIControlStateNormal];
        DPasswdBtn.titleLabel.textColor=[UIColor whiteColor];
        //DPasswdBtn.center=CGPointMake(viewWidth/2-viewWidth/20, viewHeight/4+viewHeight/40);
        DPasswdBtn.backgroundColor=[UIColor colorWithRed:(188.0/255.0) green:(122.0/255.0) blue:(216.0/255.0) alpha:0];
         [DPasswdBtn addTarget:self action:@selector(getVerifyCode) forControlEvents:UIControlEventTouchUpInside];
        DPasswdBtn.titleLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        [self.backgroundText addSubview:DPasswdBtn];
        
        //倒计时动态码
        DPasswdLabel = [[UILabel alloc]init];
        DPasswdLabel.frame = CGRectMake( viewWidth/2+viewWidth/6 , viewHeight/10+viewHeight/20+viewHeight/40, viewWidth*0.185, viewHeight/18);
        DPasswdLabel.textAlignment = NSTextAlignmentCenter;
        DPasswdLabel.textColor = [UIColor blackColor];
        DPasswdLabel.backgroundColor = [UIColor iOS7silverGradientStartColor];
        DPasswdLabel.font  = [UIFont systemFontOfSize:viewHeight/40];
        DPasswdLabel.userInteractionEnabled = NO;
        DPasswdLabel.hidden = YES;
        [self.backgroundText addSubview:DPasswdLabel];
        
        //登录按钮
        loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        loginBtn.frame = CGRectMake( viewWidth/2, viewHeight/4.5, viewWidth*0.85, viewHeight/20);
        [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
        loginBtn.titleLabel.textColor=[UIColor whiteColor];
        loginBtn.center=CGPointMake(viewWidth/2-viewWidth/20, viewHeight/4+viewHeight/40);
        loginBtn.backgroundColor=[UIColor colorWithRed:(63.0/255.0) green:(165.0/255.0) blue:(173.0/255.0) alpha:0];
        loginBtn.titleLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        [loginBtn addTarget:self action:@selector(loginWithName:AndPassword:AndVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
        [self.backgroundText addSubview:loginBtn];
        
        //乐享版权标题
        UILabel *  copyright= [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/5, viewHeight/4+viewHeight/10, viewWidth/3, viewHeight/20)];
        copyright.text = @"乐享100 版权所有";
        copyright.font = [UIFont systemFontOfSize:viewHeight/60];
        copyright.center=CGPointMake(viewWidth/2, viewHeight*0.6);
        copyright.textAlignment = NSTextAlignmentCenter;
        copyright.backgroundColor = [UIColor clearColor];
        [self.view addSubview:copyright];
        
        //乐享版权
        UILabel *  copyright_c= [[[UILabel alloc]initWithFrame:CGRectMake(viewWidth/5, viewHeight/4+viewHeight/5, viewWidth/1.5, viewHeight/20)]autorelease];
        //copyright_c.center = CGPointMake(viewWidth/2, viewHeight/0.8);
        copyright_c.text = @"Copyright© 2010 乐享100.All Right Rreserved.";
        copyright_c.center=CGPointMake(viewWidth/2, viewHeight*0.65);
         copyright_c.font = [UIFont systemFontOfSize:viewHeight/60];
        copyright_c.backgroundColor = [UIColor clearColor];
        copyright_c.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:copyright_c];
        
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars =NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
            self.navigationController.navigationBar.translucent = NO;
            self.view.backgroundColor=[UIColor iOS7lightBlueColor];
            backgroundText.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
    }
    [self versionCheck];
    return self;
}

-(void)versionCheck {
    NSDictionary * dic = [self readFileDic];
    NSDictionary * phoneUpdateCfg = [dic objectForKey:@"phoneUpdateCfg"];
    NSString * versionCode = [phoneUpdateCfg objectForKey:@"versionCode"];
    NSString * dataVersion = [phoneUpdateCfg objectForKey:@"dataVersion"];
    NSString * appName = [phoneUpdateCfg objectForKey:@"appName"];
    
    NSLog(@"%@===%@===%@",versionCode,dataVersion, appName );
    [soap queryVersionInfoWithInterface:@"queryVersionInfo" Parameter1:@"clientVersion" ClientVersion:versionCode Parameter2:@"dataVersion" DataVersion:dataVersion Parameter3:@"appName" AppName:appName];
}
#pragma mark readfile

-(NSDictionary *)readFileDic
{
    NSLog(@"To Read Vsersion Data........\n");
    //filePath 表示程序目录下指定文件
    NSString *filePath = [self documentsPath:@"version.txt"];
    //从filePath 这个指定的文件里读
    NSDictionary * collectBusiArray = [NSDictionary dictionaryWithContentsOfFile:filePath];//[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];//[NSArray arrayWithContentsOfFile:filePath];
    //NSLog(@"%@",[collectBusiArray objectAtIndex:0] );
    return collectBusiArray;
    return collectBusiArray;
}

-(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
}

- (void)viewWillAppear:(BOOL)animated{

    [loginNameText becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


-(void)getVerifyCode {
    if ([loginNameText.text isEqualToString:@""]) {
        [ConnectionAPI showAlertWithTitle:@"提示" AndMessages:@"请输入手机号码！"];
    } else {
        [soap acquireAgentVerifyWithInterface:@"acquireAgentVerify" Parameter1:@"phone" Phone:loginNameText.text];
    }
}
- (void)loginWithName:(NSString *)name AndPassword:(NSString *)password AndVerifyCode:(NSString *)verifyCode{
    if ([loginNameText.text  isEqual: @""]) {
        [ConnectionAPI showAlertWithTitle:nil AndMessages:@"手机号码不能为空"];
       
        
    }else if ([loginPasswordText.text  isEqual: @""]){
        [ConnectionAPI showAlertWithTitle:nil AndMessages:@"密码不能为空"];
        
    }
    else if([loginDPasswordText.text isEqualToString:@""])
    {
        [ConnectionAPI showAlertWithTitle:nil AndMessages:@"动态密码不能为空"];
    }else if ((![[loginNameText.text substringToIndex:1] isEqualToString:@"1"])||loginNameText.text.length!=11)
    {
        [ConnectionAPI showAlertWithTitle:nil AndMessages:@"请输入正确的手机号码"];
    }
    else
    {
        [soap agentLoginWithInterface:@"agentLogin" Parameter1:@"opPhone" Phone:loginNameText.text Parameter2:@"passWord" passWord:loginPasswordText.text Parameter3:@"verifyCode" VerifyCode:loginDPasswordText.text];
        [loginPasswordText resignFirstResponder];
        [loginNameText resignFirstResponder];
        [loginDPasswordText resignFirstResponder];
        
        loginNameText.text = @"";
        loginPasswordText.text = @"";
        loginDPasswordText.text = @"";
        
    }
}

/*- (void)getDPw:(NSString *)name
{
    [soap acquireAgentVerifyWithInterface::@"agentLogin" Parameter1:@"phone" Phone:loginNameText.text];
}*/

- (void)loginFeedback:(NSNotification *)note{


    [self.UserInfoDic setDictionary:[[note userInfo] objectForKey:@"1" ]];
    [userDic setDictionary:self.UserInfoDic];
    [userDic setObject:self.loginNameText.text forKey:@"phone"];

    if ([[UserInfoDic objectForKey:@"ifFirstLogin"]intValue] == 0) {
        UpadtePwdViewController * updateView = [[UpadtePwdViewController alloc] init];
       [self.navigationController pushViewController:updateView animated:YES];
        [updateView release];
       
   } else {
          [self.navigationController pushViewController:mainView animated:YES];
     
    }
}

#pragma mark UesrTouche

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if ([touch view] == DPasswdLabel) {
        if ([loginNameText.text isEqualToString:@""]) {
            [ConnectionAPI showAlertWithTitle:@"提示" AndMessages:@"请输入手机号码！"];
        } else {
            [soap acquireAgentVerifyWithInterface:@"acquireAgentVerify" Parameter1:@"phone" Phone:loginNameText.text];
        }
    }
    NSLog(@"touch");
}

- (void)timeCount{
    //开启定时器
    [timer setFireDate:[NSDate distantPast]];
    timer =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(secondsCount) userInfo:nil repeats:YES];
    secondCount = 60;
    DPasswdLabel.hidden = NO;
    DPasswdBtn.hidden = YES;
}

- (void)secondsCount{
    if (secondCount != 0) {
        DPasswdLabel.text = [NSString stringWithFormat:@"%d", secondCount];
        NSLog(@"%d",secondCount);
        secondCount--;
    }else if(secondCount == 0){
        //关闭定时器
        [timer setFireDate:[NSDate distantFuture]];
        DPasswdLabel.hidden = YES;
        DPasswdBtn.hidden = NO;
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == backgroundText) {
        return NO;
    }
    return  YES;//NO进入不了编辑模式
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"进入编辑模式时调用");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;//NO 退出不了编辑模式
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //官方 取消第一响应者（就是退出编辑模式收键盘）
    [textField resignFirstResponder];
    return YES;
}


@end
