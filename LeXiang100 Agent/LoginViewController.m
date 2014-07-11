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
@synthesize backgroundText;
@synthesize loginNameText;
@synthesize loginPasswordText;
@synthesize loginDPasswordText;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view .backgroundColor=[UIColor scrollViewTexturedBackgroundColor];
        
        [nc addObserver:self selector:@selector(loginFeedback:) name:@"agentLogin" object:nil];
        mainView = [[MainUIViewController alloc]init];
        
        //乐享图标
        UIImage * Image = [UIImage imageNamed:@"login_title.png"];
        UIImageView * imgView = [[UIImageView alloc]initWithImage:Image];
        imgView.frame = CGRectMake(viewWidth/2-viewWidth/8, viewHeight/6, viewWidth/3, viewWidth/6);
        
        [self.view addSubview:imgView];
        
        self.backgroundText = [[UITextField alloc]initWithFrame:CGRectMake(0, viewHeight/2-viewHeight/40, viewWidth*0.9, viewHeight/3)];
        self.backgroundText.borderStyle = UITextBorderStyleRoundedRect;
        self.backgroundText.backgroundColor = [UIColor lightTextColor];
        self.backgroundText.center=CGPointMake(viewWidth/2, viewHeight/2-viewHeight/40);
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
        self.loginNameText.font = [UIFont systemFontOfSize:viewHeight/60];
        self.loginNameText.delegate = self;
        self.loginNameText.placeholder=@"乐享100注册的手机号码";
        self.loginNameText.clearButtonMode =UITextFieldViewModeWhileEditing;
        self.loginNameText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
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
        self.loginPasswordText.font = [UIFont systemFontOfSize:viewHeight/60];
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
        self.loginDPasswordText.font = [UIFont systemFontOfSize:viewHeight/60];
        self.loginDPasswordText.delegate = self;
        self.loginDPasswordText.placeholder=@"动态密码";
        self.loginDPasswordText.clearButtonMode =UITextFieldViewModeWhileEditing;
        self.loginDPasswordText.keyboardType = UITextFieldViewModeWhileEditing;
        [self.backgroundText addSubview:self.loginDPasswordText];
        
        //获取动态密码按钮
        UIButton * DPasswdBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        DPasswdBtn.frame = CGRectMake( viewWidth/2+viewWidth/6 , viewHeight/10+viewHeight/20+viewHeight/40, viewWidth*0.2, viewHeight/18);
        [DPasswdBtn setTitle:@"获 取" forState:UIControlStateNormal];
        DPasswdBtn.titleLabel.textColor=[UIColor whiteColor];
        //DPasswdBtn.center=CGPointMake(viewWidth/2-viewWidth/20, viewHeight/4+viewHeight/40);
        DPasswdBtn.backgroundColor=[UIColor colorWithRed:(188.0/255.0) green:(122.0/255.0) blue:(216.0/255.0) alpha:0];
        DPasswdBtn.titleLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        [self.backgroundText addSubview:DPasswdBtn];
        
        //登录按钮
        UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
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
        copyright.center=CGPointMake(viewWidth/2, viewHeight*0.7);
        copyright.textAlignment = NSTextAlignmentCenter;
        copyright.backgroundColor = [UIColor clearColor];
        [self.view addSubview:copyright];
        
        //乐享版权
        UILabel *  copyright_c= [[[UILabel alloc]initWithFrame:CGRectMake(viewWidth/5, viewHeight/4+viewHeight/5, viewWidth/1.5, viewHeight/20)]autorelease];
        //copyright_c.center = CGPointMake(viewWidth/2, viewHeight/0.8);
        copyright_c.text = @"Copyright© 2010 乐享100.All Right Rreserved.";
        copyright_c.center=CGPointMake(viewWidth/2, viewHeight*0.75);
         copyright_c.font = [UIFont systemFontOfSize:viewHeight/60];
        copyright_c.backgroundColor = [UIColor clearColor];
        copyright_c.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:copyright_c];
        
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            self.view .backgroundColor=[UIColor lightTextColor];
            backgroundText.backgroundColor = [UIColor groupTableViewBackgroundColor];
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

- (void)loginWithName:(NSString *)name AndPassword:(NSString *)password AndVerifyCode:(NSString *)verifyCode{
    [soap agentLoginWithInterface:@"agentLogin" Parameter1:@"phone" Phone:@"15585867996" Parameter2:@"passWord" passWord:@"123456" Parameter3:@"verifyCode" VerifyCode:@"xvyf"];
}

- (void)loginFeedback:(NSNotification *)note{
    [self.navigationController pushViewController:mainView animated:YES];
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
