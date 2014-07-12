//
//  NSObject+ConnectionAPI.h
//  LeXiang100 Agent
//
//  Created by flying on 14-6-24.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DES3Util.h"
#import "TestData.h"
#import <math.h>

@interface ConnectionAPI : NSObject<NSXMLParserDelegate, NSURLConnectionDelegate>{
    
    BOOL needToAnalysis;
}
@property (strong, nonatomic) NSMutableData *webData;
@property (strong, nonatomic) NSMutableString *soapResults;
@property (strong, nonatomic) NSXMLParser *xmlParser;
@property (nonatomic) BOOL elementFound;
@property (strong, nonatomic) NSURLConnection *conn;
@property (strong, nonatomic) NSMutableString *getXMLResults;
@property (strong, nonatomic) NSMutableDictionary *resultDic;
@property (strong, nonatomic) NSArray *resultArray;
@property (strong, nonatomic) UIAlertView * alerts;

//- (void)getSoapFromInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1;
//- (void)getSoapFromInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1 Parameter2:(NSString *)parameter2 Value2:(NSString *)value2;
//- (void)getSoapForInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1 Parameter2:(NSString *)parameter2 Value2:(NSString *)value2 Parameter3:(NSString *)parameter3 Value3:(NSString *)value3;
//- (void)getSoapForInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1 Parameter2:(NSString *)parameter2 Value2:(NSString *)value2 Parameter3:(NSString *)parameter3 Value3:(NSString *)value3 Parameter4:(NSString *)parameter4 Value4:(NSString *)value4;
//- (void)getSoapForInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1 Parameter2:(NSString *)parameter2 Value2:(NSString *)value2 Parameter3:(NSString *)parameter3 Value3:(NSString *)value3 Parameter4:(NSString *)parameter4 Value4:(NSString *)value4 Parameter5:(NSString *)parameter5 Value5:(NSString *)value5;

//查询缴费金额列表，接口1
-(void)queryAllPayMoneysWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Token:(NSString *)token;
//提交缴费请求，接口2
- (void)payMoneyToCustPhoneWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 OpPhone:(NSString *)ophone Parameter2:(NSString *)parameter2 PayMoney:(NSString *)payMoney Parameter3:(NSString *)parameter3 CustPhone:(NSString *)custPhone Parameter4:(NSString *)parameter4 BossPwd:(NSString *)bossPwd Parameter5:(NSString *)parameter5 Token:(NSString *)token;
//查询缴费历史记录，接口3
-(void)queryPayHistoryWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 OpPhone:(NSString *)opPhone Parameter2:(NSString *)parameter2 Month:(NSString *)month Parameter3:(NSString *)parameter3 Start:(NSString *)start Parameter4:(NSString *)parameter4 Token:(NSString *)token;
//获取公钥,接口4
-(void)getKeyWithInterface:(NSString*)interface;
//在线版本检测，接口5
-(void)queryVersionInfoWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 ClientVersion:(NSString *)clientVersion Parameter2:(NSString *)parameter2 DataVersion:(NSString *)dataVersion Parameter3:(NSString *)parameter3 AppName:(NSString *)appName;
//获取动态验证码，接口6
-(void)acquireAgentVerifyWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Phone:(NSString *)phone;
//代理商登录手机客户端，接口7
-(void)agentLoginWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Phone:(NSString *)phone Parameter2:(NSString *)parameter2 passWord:(NSString *)passWord Parameter3:(NSString *)parameter3 VerifyCode:(NSString *)verifyCode;
//查询营销活动列表,接口8
-(void)queryAllCampsWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Phone:(NSString *)phone Parameter2:(NSString *)parameter2 Token:(NSString *)token;
//办理营销活动，接口9
-(void)OrderVasOfferForBiOrderWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Phone:(NSString *)phone Parameter2:(NSString *)parameter2 Token:(NSString *)token Parameter3:(NSString *)parameter3 OfferId:(NSString *)OfferIds Parameter4:(NSString *)parameter4 UserPhone:(NSString *)userPhone;
//代理商首次登录，修改初始密码,接口10
-(void)updateAgentPwdWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Phone:(NSString *)phone Parameter2:(NSString *)parameter2 NewPwd:(NSString *)newPwd;



+ (void)showAlertWithTitle:(NSString *)titles AndMessages:(NSString *)messages;
- (void) dimissAlert:(UIAlertView *)alert;
@end
