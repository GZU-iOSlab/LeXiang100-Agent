//
//  MainViewController.h
//  LeXiang100 Agent
//
//  Created by ZengYifei on 14-6-24.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "loginViewController.h"
#import "UpdateCheckingViewController.h"
#import "PayRecordViewController.h"

@interface MainViewController : UIViewController{

    LoginViewController *login;
    UpdateCheckingViewController *update;
    PayRecordViewController *payRecord;
    
}
@end
