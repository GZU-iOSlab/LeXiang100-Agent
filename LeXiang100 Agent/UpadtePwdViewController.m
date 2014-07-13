//
//  UpadtePwdViewController.m
//  LeXiang100 Agent
//
//  Created by flying on 14-7-12.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "UpadtePwdViewController.h"

@interface UpadtePwdViewController ()

@end

@implementation UpadtePwdViewController


extern NSNotificationCenter *nc;
extern ConnectionAPI * soap;

#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [nc addObserver:self selector:@selector(updateFeedback:) name:@"updateAgentPwd" object:nil];
        

       self.title = @"密码修改";
        self.view.backgroundColor = [UIColor lightGrayColor];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleBordered target:self action:@selector(confirmUpdate:)];
        self.navigationItem.rightBarButtonItem.enabled = NO;
        UITextView * background = [[[UITextView alloc]init]autorelease];
        background.frame = self.view.frame;
        //[self.view addSubview: background];
        
            //背景框
        UITextField * backgroundText = [[[UITextField alloc]initWithFrame:CGRectMake(viewWidth/40, viewHeight/60, viewWidth-viewWidth/20, viewHeight/2) ]autorelease];
        backgroundText.enabled = NO;
        backgroundText.borderStyle = UITextBorderStyleRoundedRect;
        backgroundText.backgroundColor = [UIColor lightTextColor];
        backgroundText.autoresizesSubviews = YES;
        [self.view addSubview:backgroundText];
        
        newPwdTextField = [[UITextField alloc]initWithFrame:CGRectMake( viewWidth/6 , viewHeight/5, viewWidth/1.5, viewHeight/15)];
        newPwdTextField.delegate = self;
        newPwdTextField.placeholder = @"请输入新密码";
        newPwdTextField.font = [UIFont systemFontOfSize:viewHeight/25];
        newPwdTextField.borderStyle = UITextBorderStyleRoundedRect;
        newPwdTextField.backgroundColor = [UIColor lightTextColor];
        newPwdTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        newPwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        newPwdTextField.secureTextEntry = YES;
        
        [self.view addSubview:newPwdTextField];
        
        confirmPwdTexField = [[UITextField alloc]initWithFrame:CGRectMake( viewWidth/6 , viewHeight/4+viewHeight/15, viewWidth/1.5, viewHeight/15)];
        confirmPwdTexField.delegate = self;
        confirmPwdTexField.placeholder = @"请再次输入确认";
        confirmPwdTexField.font = [UIFont systemFontOfSize:viewHeight/25];
        confirmPwdTexField.borderStyle = UITextBorderStyleRoundedRect;
        confirmPwdTexField.backgroundColor = [UIColor lightTextColor];
        confirmPwdTexField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        confirmPwdTexField.clearButtonMode = UITextFieldViewModeWhileEditing;
        confirmPwdTexField.secureTextEntry = YES;
        [self.view addSubview:confirmPwdTexField];
  
    }
    return self;
}

- (void)updateFeedback:(NSNotification *)note{
    
    [self.navigationController popViewControllerAnimated:YES];
 }
-(void)confirmUpdate:(id)sender {
   
    if([confirmPwdTexField.text isEqualToString:newPwdTextField.text]) {
      [soap updateAgentPwdWithInterface:@"updateAgentPwd" Parameter1:@"phone" Phone:@"15116401932" Parameter2:@"newPwd" NewPwd:@"123456"];
    } else if([confirmPwdTexField.text isEqualToString:@""] || [newPwdTextField.text isEqualToString:@""]){
        [ConnectionAPI showAlertWithTitle:@"提示信息" AndMessages:@"不能为空，请输入后再确认！"];
    }
    else{
      [[[[UIAlertView alloc] initWithTitle:@"提示" message:@"密码输入不一致，请重新输入！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil]autorelease]show];
    }
}
#pragma mark UesrTouche

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    if ([touch view] != newPwdTextField) {
        [newPwdTextField resignFirstResponder];
    }
    if([touch view] != confirmPwdTexField){
        [confirmPwdTexField resignFirstResponder];
    }
}

#pragma mark textefield delegate


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return  YES;//NO进入不了编辑模式
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
 
    NSLog(@"进入编辑模式时调用");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    if (![newPwdTextField.text isEqualToString:@""]){
        newPwdTextField.placeholder = @"请输入新密码";
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    if (![confirmPwdTexField.text isEqualToString:@""]){
        confirmPwdTexField.placeholder = @"请输入确认";
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    if (![newPwdTextField.text isEqualToString:@""] && ![confirmPwdTexField.text isEqualToString:@""]) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    [textField resignFirstResponder];
    return YES;//NO 退出不了编辑模式
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    //官方 取消第一响应者（就是退出编辑模式收键盘）
    [textField resignFirstResponder];
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



@end
