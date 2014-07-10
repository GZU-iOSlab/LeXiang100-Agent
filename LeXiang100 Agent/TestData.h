//
//  TestData.h
//  LeXiang100 Agent
//
//  Created by ZengYifei on 14-7-10.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestData : NSObject
@property (nonatomic,retain) NSString * payment;                //缴费         接口1
@property (nonatomic,retain) NSString * paymentList;            //缴费金额      接口2
@property (nonatomic,retain) NSString * payRecordList;          //缴费记录      接口3
@property (nonatomic,retain) NSString * updateCheckList;        //更新         接口5
@property (nonatomic,retain) NSString * verify;                 //验证码       接口6
@property (nonatomic,retain) NSString * loginList;              //登陆         接口7
@property (nonatomic,retain) NSString * marketList;             //营销活动      接口8
@property (nonatomic,retain) NSString * activitiesList;         //活动办理      接口9
@property (nonatomic,retain) NSString * modifyPasswrldList;     //修改密码      接口10
@end
