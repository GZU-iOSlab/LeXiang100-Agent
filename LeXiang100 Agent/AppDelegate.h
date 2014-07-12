//
//  AppDelegate.h
//  LeXiang100 Agent
//
//  Created by ZengYifei on 14-6-24.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MainUIViewController.h"
#import "LoginViewController.h"
#import "TestData.h"
#import "ConnectionAPI.h"
NSNotificationCenter *nc;
NSString * phoneNumber;
NSMutableString * service;
NSMutableDictionary * payInfoDic;
TestData * testData;
BOOL testDataOn;
ConnectionAPI * soap;
NSMutableDictionary * userDic;
NSMutableDictionary *staffName;
NSMutableDictionary *staffId;
NSMutableDictionary *phone;//代理商手机号
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *nav;
@property (strong, nonatomic) MainUIViewController * viewController;
@end
