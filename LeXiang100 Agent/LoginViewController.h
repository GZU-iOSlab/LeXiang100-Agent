//
//  LoginViewController.h
//  LeXiang100 Agent
//
//  Created by 任魏翔 on 14-7-3.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    
}
@property(nonatomic,strong)UITextField * backgroundText;
@property(nonatomic,strong)UITextField * loginNameText;
@property(nonatomic,strong)UITextField * loginPasswordText;
@property(nonatomic,strong)UITextField * loginDPasswordText;
@end

