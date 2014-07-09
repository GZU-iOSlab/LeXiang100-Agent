//
//  NSObject+PayInfo.h
//  LeXiang100 Agent
//
//  Created by flying on 14-7-8.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  PayInfo : NSObject

{
    NSString * phoneNum;//手机号码
    NSString * payNum;//充值金额

}

@property(nonatomic,retain) NSString *phoneNum;
@property(nonatomic,retain) NSString *payNum;
@end
