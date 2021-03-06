//
//  SpecialOfferViewController.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-22.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "PayViewController.h"

@interface PayViewController ()

@end

@implementation PayViewController
#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height

extern NSNotificationCenter *nc;
extern NSString * phoneNumber;
extern NSString * service;
extern NSMutableDictionary * payInfoDic;
extern ConnectionAPI * soap;
extern NSMutableDictionary * userDic;

@synthesize alerts;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.title = @"话费充值";
        // self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"充值" style:UIBarButtonItemStyleBordered target:self action:@selector(confirmPay)];
        UITextView * background = [[[UITextView alloc]init]autorelease];
        background.frame = self.view.frame;
        //[self.view addSubview: background];
        
        
        //背景框
        UITextField * backgroundText = [[UITextField alloc]initWithFrame:CGRectMake(viewWidth/40, viewHeight/60, viewWidth-viewWidth/20, viewHeight/2) ];
        
        backgroundText.enabled = NO;
        backgroundText.borderStyle = UITextBorderStyleRoundedRect;
        backgroundText.backgroundColor = [UIColor lightTextColor];
        backgroundText.autoresizesSubviews = YES;
        [self.view addSubview:backgroundText];
        backgroundText.delegate = self;
        [self.view addSubview:backgroundText];
        
        UILabel * phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/20, viewHeight/30 + viewHeight/40, viewWidth/2.5, viewHeight/15)];
        phoneLabel.text = @"   手机号码:";
        phoneLabel.font = [UIFont boldSystemFontOfSize:viewHeight/30];
        phoneLabel.backgroundColor = [UIColor clearColor];
        phoneLabel.userInteractionEnabled = NO;
        
        
        [self.view addSubview:phoneLabel];
        
        UILabel * phoneLabelValue = [[[UILabel alloc]initWithFrame:CGRectMake(viewWidth/20 + viewHeight/4, viewHeight/30 + viewHeight/40, viewWidth/2, viewHeight/15)]autorelease];
        phoneLabelValue.text = [payInfoDic objectForKey:@"phoneNum"];
        phoneLabelValue.font = [UIFont boldSystemFontOfSize:viewHeight/30];
        phoneLabelValue.textColor = [UIColor redColor];
        phoneLabelValue.backgroundColor = [UIColor clearColor];
        phoneLabelValue.userInteractionEnabled = NO;
        [self.view addSubview:phoneLabelValue];
        
        UILabel * payNumLabel = [[[UILabel alloc]initWithFrame:CGRectMake(viewWidth/20, viewHeight/10 + viewHeight/40, viewWidth/2.5, viewHeight/15)]autorelease];
        payNumLabel.text = @"   充值金额:";
        payNumLabel.font = [UIFont boldSystemFontOfSize:viewHeight/30];
        
        payNumLabel.backgroundColor = [UIColor clearColor];
        payNumLabel.userInteractionEnabled = NO;
        [self.view addSubview:payNumLabel];
        
        UILabel * payNumLabelValue = [[[UILabel alloc]initWithFrame:CGRectMake(viewWidth/20 + viewHeight/4, viewHeight/10 + viewHeight/40, viewWidth/2,viewHeight/15)]autorelease];
        payNumLabelValue.text = [payInfoDic objectForKey:@"payNum"];
        payNumLabelValue.textColor = [UIColor redColor];
        payNumLabelValue.font = [UIFont boldSystemFontOfSize:viewHeight/30];
        payNumLabelValue.backgroundColor = [UIColor clearColor];
        payNumLabelValue.userInteractionEnabled = NO;
        [self.view addSubview:payNumLabelValue];
        
        //
        //        UITextField *phoneText =  [[UITextField alloc]initWithFrame:CGRectMake( viewWidth/32+viewWidth/20, viewHeight/10, viewWidth/2.5, viewHeight/15)];
        //        phoneText.placeholder = @"手机号码";
        //        phoneText.borderStyle = UITextBorderStyleRoundedRect;
        //        phoneText.backgroundColor = [UIColor clearColor];
        //        phoneText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        //        phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
        //
        bossPWD = [[UITextField alloc]initWithFrame:CGRectMake( viewWidth/20 + viewHeight/40, viewHeight/4, viewWidth/1.2, viewHeight/15)];
        bossPWD.placeholder = @"请输入BOSS工号密码";
        bossPWD.font = [UIFont systemFontOfSize:viewHeight/25];
        bossPWD.borderStyle = UITextBorderStyleRoundedRect;
        bossPWD.backgroundColor = [UIColor clearColor];
        bossPWD.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        bossPWD.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        bossPWD.delegate = self;
        
        bossPWD.secureTextEntry = YES;
        bossPWD.delegate = self;
        
        [self.view addSubview:bossPWD];
        
        
        UILabel * servicesLabel = [[UILabel alloc]initWithFrame:CGRectMake(viewWidth/32+viewWidth/41, viewHeight/7.5, viewWidth/2, viewHeight/20)];
        servicesLabel.text = @"请输入BOSS工号密码:";
        servicesLabel.font = [UIFont systemFontOfSize:viewHeight/40];
        servicesLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //        [self.view addSubview:servicesLabel];
        
        
        
        //        //解决ios7界面上移  配色等问题
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars =NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
            self.navigationController.navigationBar.translucent = NO;
            bossPWD.backgroundColor = [UIColor whiteColor];
            backgroundText.backgroundColor = [UIColor lightTextColor];
            backgroundText.frame = CGRectMake(viewWidth/40, viewHeight/60, viewWidth-viewWidth/20, viewHeight/2);
            servicesLabel.backgroundColor = [UIColor clearColor];
            self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
        //针对iPad的界面调整
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            backgroundText.frame = CGRectMake(viewWidth/40, viewHeight/60, viewWidth/1.1+viewWidth/30, viewHeight/2);
            bossPWD.frame = CGRectMake( viewWidth/32+viewWidth/40 , viewHeight/4, viewWidth/1.2, viewHeight/15);
            bossPWD.keyboardType = UIKeyboardTypeNumberPad;
            
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"aaaaaaaaaaaa%@", [payInfoDic objectForKey:@"phoneNum"]);
}

- (void)viewDidDisappear:(BOOL)animated{
    [bossPWD resignFirstResponder];
}

#pragma mark UesrTouche

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] != bossPWD) {
        [bossPWD resignFirstResponder];
    }
}


#pragma mark - alertview 协议

-(void)showAlertView {
    confirmPayAlert = [[UIAlertView alloc]initWithTitle:@"确认充值"
                                                message:@"确认充值吗?"
                                               delegate:self
                                      cancelButtonTitle:@"取消"
                                      otherButtonTitles:@"确认",nil];
    
    confirmPayAlert.delegate = self;
    [confirmPayAlert show];
    [confirmPayAlert release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self dimissAlert:alerts]; ;
    } else{
        
        [soap payMoneyToCustPhoneWithInterface:@"payMoneyToCustPhone" Parameter1:@"ophone" OpPhone:[userDic objectForKey:@"phone"] Parameter2:@"payMoney" PayMoney:[payInfoDic objectForKey:@"payNum"] Parameter3:@"custPhone" CustPhone:[payInfoDic objectForKey:@"phoneNum"] Parameter4:@"bossPwd" BossPwd:bossPWD.text Parameter5:@"tobken" Token:[userDic objectForKey:@"token"]];
        NSLog(@"==%@==%@==",[userDic objectForKey:@"phone"], [userDic objectForKey:@"token"]);
    }
}

- (void) dimissAlert:(UIAlertView *)alert
{
    if(self.alerts)
    {
        [self.alerts dismissWithClickedButtonIndex:[alert cancelButtonIndex]animated:YES];
    }
}

#pragma mark textefield delegate


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return  YES;//NO进入不了编辑模式
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (![bossPWD.text isEqualToString:@""]) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    NSLog(@"进入编辑模式时调用");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (![bossPWD.text isEqualToString:@""]){
        bossPWD.placeholder = @"请输入工号密码";
    }
    [textField resignFirstResponder];
    return YES;//NO 退出不了编辑模式
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //官方 取消第一响应者（就是退出编辑模式收键盘）
    [textField resignFirstResponder];
    return YES;
}



- (void)confirmPay{
    
    
    [self showAlertView];
    
    
}



-(BOOL) respondsToSelector : (SEL)aSelector {
    printf("SELECTOR: %s\n", [NSStringFromSelector(aSelector) UTF8String]);
    return [super respondsToSelector:aSelector];
}




- (void)dealloc{
    [super dealloc];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
