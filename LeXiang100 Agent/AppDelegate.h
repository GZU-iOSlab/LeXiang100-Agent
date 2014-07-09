//
//  AppDelegate.h
//  LeXiang100 Agent
//
//  Created by ZengYifei on 14-6-24.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MainUIViewController.h"
#import "PayInfo.h"

NSNotificationCenter *nc;
NSString * phoneNumber;
NSMutableString * service;
NSMutableDictionary * payInfoDic;



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *nav;
@property (strong, nonatomic) MainUIViewController * viewController;
@end
