//
//  UpadtePwdViewController.h
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-22.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//


#import <UIKit/UIKit.h>


#import "connectionAPI.h"
#import "UIColorForiOS7Colors.h"

#import "UpadtePwdViewController.h"
#import "ConnectionAPI.h"
#import "MainUIViewController.h"


@interface UpadtePwdViewController : UIViewController<UITextFieldDelegate>
{
    UITextField * newPwdTextField;
    UITextField *confirmPwdTexField;
  
}



@end
