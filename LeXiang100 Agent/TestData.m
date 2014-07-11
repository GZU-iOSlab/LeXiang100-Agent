//
//  TestData.m
//  LeXiang100 Agent
//
//  Created by ZengYifei on 14-7-10.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "TestData.h"

@implementation TestData
@synthesize payment,paymentList,payRecordList,updateCheckList,verify,loginList,marketList,modifyPasswrldList,activitiesList;
- (TestData*)init{
    //1缴费金额列表
    self.paymentList = [[NSString alloc]initWithString:@"[{\"id\":1,\"payMoney\":\"10.00\",\"status\":0,\"paySort\":1},{\"id\":2,\"payMoney\":\"20.00\",\"status\":0,\"paySort\":2},{\"id\":3,\"payMoney\":\"30.00\",\"status\":0,\"paySort\":3},{\"id\":4,\"payMoney\":\"50.00\",\"status\":0,\"paySort\":4},{\"id\":5,\"payMoney\":\"100.00\",\"status\":0,\"paySort\":5},{\"id\":6,\"payMoney\":\"200.00\",\"status\":0,\"paySort\":6},{\"id\":7,\"payMoney\":\"300.00\",\"status\":0,\"paySort\":7}]"];
    //2缴费
    self.payment = [[NSString alloc]initWithString:@"0"];
    //3缴费历史
    self.payRecordList = [[NSString alloc]initWithString:@"{\"records\":3,\"status\":2,\"payHistories\":[{\"id\":1,\"agentId\":100,\"staffId\":\"88888888\",\"staffName\":\"乐享测试2\",\"opPhone\":\"15085921612\",\"payTime\":\"2014-06-23 15:46:34\",\"payMoney\":100,\"bossMsgId\":\"1403509594993\",\"status\":2,\"statusDesc\":\"成功\",\"custPhone\":\"13738163467\"},{\"id\":2,\"agentId\":102,\"staffId\":\"88888888\",\"staffName\":\"乐享测试1\",\"opPhone\":\"18286057264\",\"payTime\":\"2014-06-24 16:15:49\",\"payMoney\":300,\"bossMsgId\":\"1403597749929\",\"status\":-99,\"statusDesc\":\"等待处理\",\"custPhone\":\"15599100620\"},{\"id\":2,\"agentId\":103,\"staffId\":\"88888888\",\"staffName\":\"欧强\",\"opPhone\":\"13765796660\",\"payTime\":\"2014-06-25 12:13:19\",\"payMoney\":10,\"bossMsgId\":\"1401807860279\",\"status\":1,\"statusDesc\":\"失败\",\"custPhone\":\"18798216696\"}]}"];
    //5版本检测借口
    self.updateCheckList = [[NSString alloc]initWithString:@"{\"phoneUpdateCfg\":{\"appName\":\"lx100-Agent\",\"id\":1,\"releaseDate\":\"2014-07-10\",\"releaseType\":1,\"releaseUser\":\"nieaw\",\"updateContent\":\"版本更新,新增加预开户激活动能.\",\"updateUrl\":\"http://www.gz.10086.cn/lx100/apk/lx100_android_agent_v1.0.0.apk\",\"versionCode\":\"1.0.1\"},\"status\":1}"];
    //6获取验证码
    self.verify = [[NSString alloc]initWithString:@"XT5Y"];
    //7登录接口
    self.loginList = [[NSString alloc]initWithString:@"{\"status\":4,\"token\":\"be93439a-4425-47de-b281-4f41afb7ff60\",\"staffName\":\"乐享测试1\",\"staffId\":\"88888888\",\"ifFirstLogin\":0}"];
    //8营销活动接口
    self.marketList = [[NSString alloc]initWithString:@"[{\"id\":3,\"cityCode\":\"851\",\"campaignName\":\"预交50元送50元话费（网龄3-12个月）\",\"campaignDesc\":\"预交50元送50元话费（网龄3-12个月）\",\"status\":0,\"offerId\":\"310000281701\",\"campSort\":1},{\"id\":4,\"cityCode\":\"851\",\"campaignName\":\"预交40元送50元话费（网龄12-36个月）\",\"campaignDesc\":\"预交40元送50元话费（网龄12-36个月）\",\"status\":0,\"offerId\":\"310000281702\",\"campSort\":2}]"];
    //9活动办理接口
    self.activitiesList = [[NSString alloc]initWithString:@"{\"X_RESULTINFO\":\"成功\",\"X_RESULTNUM\":\"1\",\"OrderResult\":[{\"ExpireDate\":\"20991231\",\"OfferId\":\"310000281701\",\"EffectDate\":\"20140801\",\"OperType\":\"0\"},{\"ExpireDate\":\"20991231\",\"OfferId\":\"310000281702\",\"EffectDate\":\"20140710\",\"OperType\":\"0\"}],\"OperType\":[\"0\",\"0\"],\"X_ORDERID\":\"20140710112308055191018626\",\"DoneCode\":\"85111412559870\",\"X_RESULTCODE\":\"0\"}"];
    //10代理商修改密码c
    self.modifyPasswrldList = [[NSString alloc]initWithString:@"0"];    //0成功  1该手机号不是代理商  -1服务端异常
    return self;
}

//1、获取缴费金额列表
//[{&quot;id&quot;:1,&quot;payMoney&quot;:&quot;10.00&quot;,&quot;status&quot;:0,&quot;paySort&quot;:1},{&quot;id&quot;:2,&quot;payMoney&quot;:&quot;20.00&quot;,&quot;status&quot;:0,&quot;paySort&quot;:2},{&quot;id&quot;:3,&quot;payMoney&quot;:&quot;30.00&quot;,&quot;status&quot;:0,&quot;paySort&quot;:3},{&quot;id&quot;:4,&quot;payMoney&quot;:&quot;50.00&quot;,&quot;status&quot;:0,&quot;paySort&quot;:4},{&quot;id&quot;:5,&quot;payMoney&quot;:&quot;100.00&quot;,&quot;status&quot;:0,&quot;paySort&quot;:5},{&quot;id&quot;:6,&quot;payMoney&quot;:&quot;200.00&quot;,&quot;status&quot;:0,&quot;paySort&quot;:6},{&quot;id&quot;:7,&quot;payMoney&quot;:&quot;300.00&quot;,&quot;status&quot;:0,&quot;paySort&quot;:7}]
//
//2、查询缴费历史
//{&quot;records&quot;:3,&quot;status&quot;:2,&quot;payHistories&quot;:[{&quot;id&quot;:1,&quot;agentId&quot;:100,&quot;staffId&quot;:&quot;88888888&quot;,&quot;staffName&quot;:&quot;乐享测试2&quot;,&quot;opPhone&quot;:&quot;15085921612&quot;,&quot;payTime&quot;:&quot;2014-06-23 15:46:34&quot;,&quot;payMoney&quot;:100,&quot;bossMsgId&quot;:&quot;1403509594993&quot;,&quot;status&quot;:2,&quot;statusDesc&quot;:&quot;成功&quot;,&quot;custPhone&quot;:&quot;13738163467&quot;},{&quot;id&quot;:2,&quot;agentId&quot;:102,&quot;staffId&quot;:&quot;88888888&quot;,&quot;staffName&quot;:&quot;乐享测试1&quot;,&quot;opPhone&quot;:&quot;18286057264&quot;,&quot;payTime&quot;:&quot;2014-06-24 16:15:49&quot;,&quot;payMoney&quot;:300,&quot;bossMsgId&quot;:&quot;1403597749929&quot;,&quot;status&quot;:-99,&quot;statusDesc&quot;:&quot;等待处理&quot;,&quot;custPhone&quot;:&quot;15599100620&quot;},{&quot;id&quot;:2,&quot;agentId&quot;:103,&quot;staffId&quot;:&quot;88888888&quot;,&quot;staffName&quot;:&quot;欧强&quot;,&quot;opPhone&quot;:&quot;13765796660&quot;,&quot;payTime&quot;:&quot;2014-06-25 12:13:19&quot;,&quot;payMoney&quot;:10,&quot;bossMsgId&quot;:&quot;1401807860279&quot;,&quot;status&quot;:1,&quot;statusDesc&quot;:&quot;失败&quot;,&quot;custPhone&quot;:&quot;18798216696&quot;}]}
//
//3、检测版本
//{&quot;phoneUpdateCfg&quot;:{&quot;appName&quot;:&quot;lx100-Agent&quot;,&quot;id&quot;:1,&quot;releaseDate&quot;:&quot;2014-07-10&quot;,&quot;releaseType&quot;:1,&quot;releaseUser&quot;:&quot;nieaw&quot;,&quot;updateContent&quot;:&quot;版本更新,新增加预开户激活动能.&quot;,&quot;updateUrl&quot;:&quot;http://www.gz.10086.cn/lx100/apk/lx100_android_agent_v1.0.0.apk&quot;,&quot;versionCode&quot;:&quot;1.0.1&quot;},&quot;status&quot;:1}
//    
//    4、登录接口
//    {&quot;status&quot;:4,&quot;token&quot;:&quot;be93439a-4425-47de-b281-4f41afb7ff60&quot;,&quot;staffName&quot;:&quot;乐享测试1&quot;,&quot;staffId&quot;:&quot;88888888&quot;,&quot;ifFirstLogin&quot;:0}
//    
//    5、查询营销活动信息
//    [{&quot;id&quot;:3,&quot;cityCode&quot;:&quot;851&quot;,&quot;campaignName&quot;:&quot;预交50元送50元话费（网龄3-12个月）&quot;,&quot;campaignDesc&quot;:&quot;预交50元送50元话费（网龄3-12个月）&quot;,&quot;status&quot;:0,&quot;offerId&quot;:&quot;310000281701&quot;,&quot;campSort&quot;:1},{&quot;id&quot;:4,&quot;cityCode&quot;:&quot;851&quot;,&quot;campaignName&quot;:&quot;预交40元送50元话费（网龄12-36个月）&quot;,&quot;campaignDesc&quot;:&quot;预交40元送50元话费（网龄12-36个月）&quot;,&quot;status&quot;:0,&quot;offerId&quot;:&quot;310000281702&quot;,&quot;campSort&quot;:2}]
//    
//    6、活动办理接口
//    {&quot;X_RESULTINFO&quot;:&quot;成功&quot;,&quot;X_RESULTNUM&quot;:&quot;1&quot;,&quot;OrderResult&quot;:[{&quot;ExpireDate&quot;:&quot;20991231&quot;,&quot;OfferId&quot;:&quot;310000281701&quot;,&quot;EffectDate&quot;:&quot;20140801&quot;,&quot;OperType&quot;:&quot;0&quot;},{&quot;ExpireDate&quot;:&quot;20991231&quot;,&quot;OfferId&quot;:&quot;310000281702&quot;,&quot;EffectDate&quot;:&quot;20140710&quot;,&quot;OperType&quot;:&quot;0&quot;}],&quot;OperType&quot;:[&quot;0&quot;,&quot;0&quot;],&quot;X_ORDERID&quot;:&quot;20140710112308055191018626&quot;,&quot;DoneCode&quot;:&quot;85111412559870&quot;,&quot;X_RESULTCODE&quot;:&quot;0&quot;}


@end
