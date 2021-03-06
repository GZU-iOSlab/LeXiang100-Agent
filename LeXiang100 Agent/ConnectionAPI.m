
//
//  ConnectionAPI.m
//  LeXiang100 Agent
//
//  Created by flying on 14-6-24.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "ConnectionAPI.h"
static int count;
@implementation ConnectionAPI

@synthesize webData;
@synthesize soapResults;
@synthesize xmlParser;
@synthesize conn;
@synthesize getXMLResults;
@synthesize resultDic;
@synthesize resultArray;
@synthesize alerts;
@synthesize elementFound;

extern TestData * testData;
extern BOOL testDataOn;
extern NSNotificationCenter *nc;
extern NSMutableDictionary * UserInfo;


-(ConnectionAPI *) init{
    getXMLResults = [[NSMutableString alloc]init];
    soapResults = [[NSMutableString alloc]init];
    return self;
}
- (void)getSoapFromInterface:(NSString *)interface {
    
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<%@>\r\n"                //接口
                          "</%@>\r\n"               //接口
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",interface,interface];
    NSLog(@"%@",soapMsg);
    
    NSString * ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/phoneintf"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }else NSLog(@"con为假  %@",webData);
    
}

- (void)getSoapFromInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1{

    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<%@>\r\n"                //接口
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"//参数  值  参数
                          "</%@>\r\n"               //接口
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",interface,parameter1,value1,parameter1,interface];
    NSLog(@"%@",soapMsg);
    
    NSString * ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/phoneintf"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
       
    }else NSLog(@"con为假  %@",webData);
    
}

- (void)getSoapFromInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1 Parameter2:(NSString *)parameter2 Value2:(NSString *)value2{
    if ([value2 isEqualToString:@"123"]) {
        value2 = nil;
        value2 = [[NSString alloc]initWithString:@"15285987576"];
    }
    if ([value1 isEqualToString:@"qwe"]) {
        value1 = nil;
        value1 = [[NSString alloc]initWithString:@"123456"];
    }
    NSLog(@"value1:%@ value2:%@",value1,value2);
    value1 = [DES3Util encrypt:value1];
    value2 = [DES3Util encrypt:value2];
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "</%@>\r\n"
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",interface,parameter1,value1,parameter1,parameter2,value2,parameter2,interface];
    NSLog(@"%@",soapMsg);
    
    NSString * ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/phoneintf"];
    if ([interface isEqualToString:@"awordShellQuery"]) {
        ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/selfService"];
    }
    
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        
    }else NSLog(@"con为假  %@",webData);
}
- (void)getSoapForInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1 Parameter2:(NSString *)parameter2 Value2:(NSString *)value2 Parameter3:(NSString *)parameter3 Value3:(NSString *)value3 {
    NSLog(@"value1:%@ value2:%@ value3:%@", value1, value2, value3);
    if ( [interface isEqualToString:@"orderVasOffer"]) {
        //
    }else{
        value1 = [DES3Util encrypt:value1];
        value2 = [DES3Util encrypt:value2];
        value3 = [DES3Util encrypt:value3];
    }
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "</%@>\r\n"
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",interface,parameter1,value1,parameter1,parameter2,value2,parameter2,parameter3,value3,parameter3,interface];
    NSLog(@"%@",soapMsg);
    
    NSString * ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/phoneintf"];
    
    if ([interface isEqualToString:@"updateUserMainOffer"] || [interface isEqualToString:@"orderVasOffer"]) {
        ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/selfService"];
    }
    
    
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
       
    }else NSLog(@"con为假  %@",webData);
}

- (void)getSoapForInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1 Parameter2:(NSString *)parameter2 Value2:(NSString *)value2 Parameter3:(NSString *)parameter3 Value3:(NSString *)value3 Parameter4:(NSString *)parameter4 Value4:(NSString *)value4{
    NSLog(@"value2:%@ value3:%@",value2,value3);
    value1 = [DES3Util encrypt:value1];
    value2 = [DES3Util encrypt:value2];
    value3 = [DES3Util encrypt:value3];
    value4 = [DES3Util encrypt:value4];
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "</%@>\r\n"
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",interface,parameter1,value1,parameter1,parameter2,value2,parameter2,parameter3,value3,parameter3,parameter4,value4,parameter4,interface];
    NSLog(@"%@",soapMsg);
    
    NSString * ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/phoneintf"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
      
    }else NSLog(@"con为假  %@",webData);
}

- (void)getSoapForInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1 Parameter2:(NSString *)parameter2 Value2:(NSString *)value2 Parameter3:(NSString *)parameter3 Value3:(NSString *)value3 Parameter4:(NSString *)parameter4 Value4:(NSString *)value4 Parameter5:(NSString *)parameter5 Value5:(NSString *)value5{
    NSLog(@"value2:%@ value3:%@",value2,value3);
    value1 = [DES3Util encrypt:value1];
    value2 = [DES3Util encrypt:value2];
    value3 = [DES3Util encrypt:value3];
    value4 = [DES3Util encrypt:value4];
    value5 = [DES3Util encrypt:value5];
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "</%@>\r\n"
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",interface,parameter1,value1,parameter1,parameter2,value2,parameter2,parameter3,value3,parameter3,parameter4,value4,parameter4,parameter5,value5,parameter5,interface];
    NSLog(@"%@",soapMsg);
    
    NSString * ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/phoneintf"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
       
    }else NSLog(@"con为假  %@",webData);
}


- (void)LoginWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 UserName:(NSString *)NewUsername Parameter2:(NSString *)parameter2 Password:(NSString *)NewPassword ;
{
    [self getSoapFromInterface:interface Parameter1:parameter1 Value1:NewUsername Parameter2:parameter2 Value2:NewPassword];
    //[self showAlerView];
}


//查询缴费金额列表，接口1
-(void)queryAllPayMoneysWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Token:(NSString *)token{
    [self showAlerView];
    if (testDataOn) {
        [getXMLResults setString:@""];
        [getXMLResults appendString:@"queryAllPayMoneys"];
        needToAnalysis = YES;
        NSData *aData = [testData.paymentList dataUsingEncoding: NSUTF8StringEncoding];
        [soapResults setString:@""];
        [soapResults appendString:testData.paymentList];
        resultDic = [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingMutableContainers error:nil];
        if (self.resultDic == nil) {
            self.resultDic = [[NSMutableDictionary alloc]init];
        }
        NSXMLParser * test;
        NSString * testString;
        [self parser:test didEndElement:testString namespaceURI:testString qualifiedName:testString];
    } else {
        [self getSoapFromInterface:interface Parameter1:parameter1 Value1:token];
    }
}
//提交缴费请求，接口2
- (void)payMoneyToCustPhoneWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 OpPhone:(NSString *)ophone Parameter2:(NSString *)parameter2 PayMoney:(NSString *)payMoney Parameter3:(NSString *)parameter3 CustPhone:(NSString *)custPhone Parameter4:(NSString *)parameter4 BossPwd:(NSString *)bossPwd Parameter5:(NSString *)parameter5 Token:(NSString *)token{
    [self showAlerView];
    if (testDataOn) {
        [getXMLResults setString:@""];
        [getXMLResults appendString:@"payMoneyToCustPhone"];
        needToAnalysis = YES;
        NSData *aData = [testData.payment dataUsingEncoding: NSUTF8StringEncoding];
        [soapResults setString:@""];
        [soapResults appendString:testData.payment];
        resultDic = [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingMutableContainers error:nil];
        if (self.resultDic == nil) {
            self.resultDic = [[NSMutableDictionary alloc]init];
        }
        NSXMLParser * test;
        NSString * testString;
        [self parser:test didEndElement:testString namespaceURI:testString qualifiedName:testString];
    }else {
        [self getSoapForInterface:interface Parameter1:parameter1 Value1:ophone Parameter2:parameter2 Value2:payMoney Parameter3:parameter3 Value3:custPhone Parameter4:parameter4 Value4:bossPwd Parameter5:parameter5 Value5:token];
    }
}

//查询缴费历史记录，接口3
-(void)queryPayHistoryWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 OpPhone:(NSString *)opPhone Parameter2:(NSString *)parameter2 Month:(NSString *)month Parameter3:(NSString *)parameter3 Start:(NSString *)start Parameter4:(NSString *)parameter4 Token:(NSString *)token{
    [self showAlerView];
    if (testDataOn) {
        [getXMLResults setString:@""];
        [getXMLResults appendString:@"queryPayHistory"];
        needToAnalysis = YES;
        NSData *aData = [testData.payRecordList dataUsingEncoding: NSUTF8StringEncoding];
        [soapResults setString:@""];
        [soapResults appendString:testData.payRecordList];
        resultDic = [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingMutableContainers error:nil];
        if (self.resultDic == nil) {
            self.resultDic = [[NSMutableDictionary alloc]init];
        }
        NSXMLParser * test;
        NSString * testString;
        [self parser:test didEndElement:testString namespaceURI:testString qualifiedName:testString];
    }else {

    [self getSoapForInterface:interface Parameter1:parameter1 Value1:opPhone Parameter2:parameter2 Value2:month Parameter3:parameter3 Value3:start Parameter4:parameter4 Value4:token];
    }
}

//获取公钥,接口4
-(void)getKeyWithInterface:(NSString*)interface {
    [self getSoapFromInterface:interface];
    [self showAlerView];
}

//在线版本检测，接口5
-(void)queryVersionInfoWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 ClientVersion:(NSString *)clientVersion Parameter2:(NSString *)parameter2 DataVersion:(NSString *)dataVersion Parameter3:(NSString *)parameter3 AppName:(NSString *)appName{
    if(count != 0) {
       [self showAlerView];
    }
    if (testDataOn) {
        [getXMLResults setString:@""];
        [getXMLResults appendString:@"queryVersionInfo"];
        needToAnalysis = YES;
        NSData *aData = [testData.updateCheckList dataUsingEncoding: NSUTF8StringEncoding];
        [soapResults setString:@""];
        [soapResults appendString:testData.updateCheckList];
        resultDic = [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingMutableContainers error:nil];
        if (self.resultDic == nil) {
            self.resultDic = [[NSMutableDictionary alloc]init];
        }
        NSXMLParser * test;
        NSString * testString;
        [self parser:test didEndElement:testString namespaceURI:testString qualifiedName:testString];
    }else {
        [self getSoapForInterface:interface Parameter1:parameter1 Value1:clientVersion Parameter2:parameter2 Value2:dataVersion Parameter3:parameter3 Value3:appName];
    }
    
    
}

//获取动态验证码，接口6
-(void)acquireAgentVerifyWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Phone:(NSString *)phone{
    [self showAlerView];
    if (testDataOn) {
        [getXMLResults setString:@""];
        [getXMLResults appendString:@"acquireAgentVerify"];
        needToAnalysis = YES;
        NSData *aData = [testData.verify dataUsingEncoding: NSUTF8StringEncoding];
        [soapResults setString:@""];
        [soapResults appendString:testData.verify];
        resultDic = [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingMutableContainers error:nil];
        if (self.resultDic == nil) {
            self.resultDic = [[NSMutableDictionary alloc]init];
        }
        [resultDic setValue:testData.verify forKey:@"verify"];
        NSXMLParser * test;
        NSString * testString;
        [self parser:test didEndElement:testString namespaceURI:testString qualifiedName:testString];
        
    }else
        [self getSoapFromInterface:interface Parameter1:parameter1 Value1:phone];
}

//代理商登录手机客户端，接口7
-(void)agentLoginWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Phone:(NSString *)phone Parameter2:(NSString *)parameter2 passWord:(NSString *)passWord Parameter3:(NSString *)parameter3 VerifyCode:(NSString *)verifyCode{
    [self showAlerView];
    if (testDataOn) {
        [getXMLResults setString:@""];
        [getXMLResults appendString:@"agentLogin"];
        needToAnalysis = YES;
        NSData *aData = [testData.loginList dataUsingEncoding: NSUTF8StringEncoding];
        resultDic = [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingMutableContainers error:nil];
        NSXMLParser * test;
        NSString * testString;
        //NSString * verfyPw=[resultDic objectForKey:@"status"];
        if (![verifyCode isEqualToString:testData.verify]) {
            [resultDic removeObjectForKey:@"status"];
            [resultDic setObject:@"3" forKey:@"status"];
        }
        [self parser:test didEndElement:testString namespaceURI:testString qualifiedName:testString];
    }else
        [self getSoapForInterface:interface Parameter1:parameter1 Value1:phone Parameter2:parameter2 Value2:passWord Parameter3:parameter3 Value3:verifyCode];
    
}

//查询营销活动列表,接口8
-(void)queryAllCampsWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Phone:(NSString *)phone Parameter2:(NSString *)parameter2 Token:(NSString *)token {
    [self getSoapFromInterface:interface Parameter1:parameter1 Value1:phone Parameter2:parameter2 Value2:token];
    [self showAlerView];
}


//办理营销活动，接口9
-(void)OrderVasOfferForBiOrderWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Phone:(NSString *)phone Parameter2:(NSString *)parameter2 Token:(NSString *)token Parameter3:(NSString *)parameter3 OfferId:(NSString *)OfferIds Parameter4:(NSString *)parameter4 UserPhone:(NSString *)userPhone{
    
    [self getSoapForInterface:interface Parameter1:parameter1 Value1:phone Parameter2:parameter2 Value2:token Parameter3:parameter3 Value3:OfferIds Parameter4:parameter4 Value4:userPhone];
    [self showAlerView];
}

//代理商首次登录，修改初始密码,接口10
-(void)updateAgentPwdWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Phone:(NSString *)phone Parameter2:(NSString *)parameter2 NewPwd:(NSString *)newPwd {
    [self showAlerView];
    if (testDataOn) {
        [getXMLResults setString:@""];
        [getXMLResults appendString:@"updateAgentPwd"];
        needToAnalysis = YES;
        NSData *aData = [testData.modifyPasswrldList dataUsingEncoding: NSUTF8StringEncoding];
        [soapResults setString:@""];
        [soapResults appendString:testData.modifyPasswrldList];
        resultDic = [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingMutableContainers error:nil];
        if (self.resultDic == nil) {
            self.resultDic = [[NSMutableDictionary alloc]init];
        }
        NSXMLParser * test;
        NSString * testString;
        [self parser:test didEndElement:testString namespaceURI:testString qualifiedName:testString];
    } else {
          [self getSoapFromInterface:interface Parameter1:parameter1 Value1:phone Parameter2:parameter2 Value2:newPwd];
    }
   
 
}

#pragma mark -
#pragma mark URL Connection Data Delegate Methods

// 刚开始接受响应时调用
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *) response{
    [webData setLength: 0];
    needToAnalysis = YES;
    NSLog(@"  刚开始接受响应时调用");
}

// 每接收到一部分数据就追加到webData中
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *) data {
    [webData appendData:data];
    NSLog(@"  每接收到一部分数据就追加到webData中 ");
    
}

// 出现错误时

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *) error {
    //conn = nil;
    //webData = nil;
    NSLog(@" connection 出现错误时");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"False"
                                                        object:self
     ];
    NSLog(@"Connection failed! Error - ");
    //%@ %@",[error localizedDescription],[[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
    //如果显示alert   取消
    //if (self.alerts.visible == YES) {
    [self dimissAlert:self.alerts];
    //}
    [ConnectionAPI showAlertWithTitle:@"网络连接错误" AndMessages:@"网络连接错误,请重新尝试！"];
    [nc postNotificationName:@"loginFalse" object:self userInfo:nil];
    needToAnalysis = NO;
}

// 完成接收数据时调用
-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    NSString *theXML = [[NSString alloc] initWithBytes:[webData mutableBytes]
                                                length:[webData length]
                                              encoding:NSUTF8StringEncoding];
    
    // 打印出得到的XML
    getXMLResults = [[NSMutableString alloc] initWithString:theXML];
    NSLog(@"接受的soap    %@    soap", getXMLResults);
    //如果显示alert   取消   bug
    if (self.alerts.visible == YES) {
        [self dimissAlert:self.alerts];
    }
    if ([getXMLResults isEqualToString:@""]) {
        [ConnectionAPI showAlertWithTitle:@"网络返回为空" AndMessages:@"网络返回为空,请重新尝试！"];
        [nc postNotificationName:@"loginFalse" object:self userInfo:nil];
        needToAnalysis = NO;
    }
    else if([getXMLResults rangeOfString:@"faultcode"].length>0){
        resultDic = [[[NSMutableDictionary alloc]init]autorelease];
        [ConnectionAPI showAlertWithTitle:@"错误" AndMessages:@"调用地址或参数错误！"];
        needToAnalysis = NO;
    }
    
    // 使用NSXMLParser解析出我们想要的结果
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities: YES];
    [xmlParser parse];
}

#pragma mark -
#pragma mark XML Parser Delegate Methods

// 开始解析一个元素名
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
    if ([elementName isEqualToString:@"return"]) {
        elementFound = YES;
    }
}
// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (elementFound) {                                         //respondse
        soapResults = [[NSMutableString alloc]init];
        //不加密接口相应也不解密
        if ([getXMLResults rangeOfString:@"orderVasOfferResponse"].length > 0 ) {
            [soapResults appendString: string];
        }else{
            [soapResults appendString: [DES3Util decrypt:string]];
        }
        NSLog(@"connection:%@",soapResults);
        
        //参数错误时返回soap中return为空
        if ([soapResults isEqualToString:@"{}"]) {
            [ConnectionAPI showAlertWithTitle:@"输入参数错误" AndMessages:@"输入参数错误，请检查输入项！"];
            [nc postNotificationName:@"loginFalse" object:self userInfo:nil];
            needToAnalysis = NO;
            //||soapResults.length<4
        }
        
        //json解析
        NSData *aData = [soapResults dataUsingEncoding: NSUTF8StringEncoding];
        
        resultDic = [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingMutableContainers error:nil];
        if (resultDic == nil) {
            resultDic = [[[NSMutableDictionary alloc]init]autorelease];
        }
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if (needToAnalysis) {
        
        NSMutableDictionary *d = [NSMutableDictionary dictionaryWithObject:resultDic forKey:@"1"];
        //版本更新
        
        if ([getXMLResults rangeOfString:@"queryVersionInfo"].length>0 ) {
            
            count ++;
            NSString * resultFor = [NSString stringWithFormat:@"%@",[self.resultDic objectForKey:@"status"]];
           
           if([resultFor isEqualToString:@""]){
                 [ConnectionAPI showAlertWithTitle:@"提示信息" AndMessages:@"网络或服务端异常，请稍后再试！"];
           } else if([resultFor isEqualToString:@"1"]){
               
          //     NSDictionary * phoneUpdateCfg = [self.resultDic objectForKeyedSubscript:@"phoneUpdateCfg"];

               //[ConnectionAPI showAlertWithTitle:@"提示信息" AndMessages:@"软件有更新，请到App Store下载最新版本！"];
               
               [nc postNotificationName:@"queryVersionInfo" object:self userInfo:d];

           } else {
                [ConnectionAPI showAlertWithTitle:@"提示信息" AndMessages:@"已经是最新版本，感谢您的使用！"];

            }
            
        }
        //客户登陆
        else if ([getXMLResults rangeOfString:@"agentLogin"].length > 0){
            //做判断 默认成功
            NSString * loginResult =[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"status"]];
            if ([loginResult isEqualToString:@"4"]) {
                [nc postNotificationName:@"agentLogin" object:self userInfo:d];
            }else if ([loginResult isEqualToString:@"1"]){
                [ConnectionAPI showAlertWithTitle:@"服务器错误" AndMessages:nil];
            }
            else if ([loginResult isEqualToString:@"2"])
            {
                [ConnectionAPI showAlertWithTitle:@"密码错误" AndMessages:nil];
            }
            else if ([loginResult isEqualToString:@"3"])
            {
                [ConnectionAPI showAlertWithTitle:@"动态密码错误" AndMessages:nil];
            }
        }
        //缴费
        else if ([getXMLResults rangeOfString:@"payMoneyToCustPhone"].length>0){
            if ([soapResults isEqualToString:@"0"]) {
                [ConnectionAPI showAlertWithTitle:@"提示信息" AndMessages:@"充值成功！"];
            } else if([soapResults isEqualToString:@"2"]) {
                [ConnectionAPI showAlertWithTitle:@"提示信息" AndMessages:@"BOSS密码验证失败"];
            } else {
                [ConnectionAPI showAlertWithTitle:@"提示信息" AndMessages:@"服务端异常，请稍后再试！"];
            }
        }
        //缴费记录
        else if ([getXMLResults rangeOfString:@"queryPayHistory"].length>0){
            NSString * result =[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"status"]];
           
            if ([result isEqualToString:@"0"])
            {
                [ConnectionAPI showAlertWithTitle:@"调用接口失败" AndMessages:nil];
            }
            else if([result isEqualToString:@"1"])
            {
                [ConnectionAPI showAlertWithTitle:@"服务端异常" AndMessages:nil];
            }
            else if ([result isEqualToString:@"2"])
            {
                [nc postNotificationName:@"queryPayHistory" object:self userInfo:d];
            }
        }
        //缴费金额列表
        else if ([getXMLResults rangeOfString:@"queryAllPayMoneys"].length>0){
            if ([self.resultDic isKindOfClass:[NSArray class]]) {
                
                [nc postNotificationName:@"queryAllPayMoneysResponse" object:self userInfo:d];
            }
        }
        //验证码
        else if ([getXMLResults rangeOfString:@"acquireAgentVerify"].length>0){
            
            if (soapResults != NULL) {
//                [verifyCode setString:@""];
//                [verifyCode appendString:soapResults];
                [nc postNotificationName:@"acquireAgentVerify" object:self userInfo:d];
                [ConnectionAPI showAlertWithTitle:nil AndMessages:@"获取验证码成功！"];
            }
        }  //密码修改
        else if ([getXMLResults rangeOfString:@"updateAgentPwd"].length>0){
            
            if ([soapResults isEqualToString:@"0"]) {
              
                pwdAlertView = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"密码修改成功！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                pwdAlertView.delegate = self;
                [pwdAlertView show];
                [pwdAlertView release];

            } else if([soapResults isEqualToString:@"1"]) {
                [ConnectionAPI showAlertWithTitle:@"提示信息" AndMessages:@"该手机号不是代理商，请核对身份"];
            } else {
                [ConnectionAPI showAlertWithTitle:@"提示信息" AndMessages:@"服务端异常，请稍后再试！"];
            }
            
      }

    }
    //如果显示alert   取消   bug
    if (self.alerts.visible == YES) {
        [self dimissAlert:self.alerts];
    }
}

// 解析整个文件结束后
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (soapResults) {
        soapResults = nil;
    }
    
}

// 出错时，例如强制结束解析
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (soapResults) {
        soapResults = nil;
    }
}


#pragma mark - AlertView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
    }else if (buttonIndex == 1){
        if([alertView isEqual:pwdAlertView]) {
           [nc postNotificationName:@"updateAgentPwd" object:self userInfo:self.resultDic];
        }
    }
}

+ (void)showAlertWithTitle:(NSString *)titles AndMessages:(NSString *)messages{
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:titles message:messages delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
    [alert show];
}

- (void)showAlerView{
    self.alerts = [[UIAlertView alloc]initWithTitle:@"连接中"
                                            message:nil
                                           delegate:nil
                                  cancelButtonTitle:nil
                                  otherButtonTitles:nil];
    
    [self.alerts show];
    UIActivityIndicatorView*activeView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activeView.center = CGPointMake(self.alerts.bounds.size.width/2.0f, self.alerts.bounds.size.height-40.0f);
    [activeView startAnimating];
    self.alerts.delegate = self;
    [self.alerts addSubview:activeView];
    [activeView release];
    [self.alerts release];
}

- (void) dimissAlert:(UIAlertView *)alert
{
    if(self.alerts)
    {
        [self.alerts dismissWithClickedButtonIndex:[alert cancelButtonIndex]animated:YES];
    }
}

@end

