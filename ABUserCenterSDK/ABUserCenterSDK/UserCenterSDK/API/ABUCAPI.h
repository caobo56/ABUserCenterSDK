//
//  ABUCAPI.h
//  MUserCenter
//
//  Created by caobo56 on 2019/6/27.
//  Copyright © 2019 caobo56. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCCNetClient.h"


@interface ABUCAPI : NSObject

//登录获取accToken
+(void)loginWithParams:(NSDictionary*)param
            completion:(NetworkCompletion)completion;

//根据accToken获取用户信息
+(void)getUserInfoWithParams:(NSDictionary*)param
                  completion:(NetworkCompletion)completion;

//refToken刷新accToken
+(void)refreshAccTokenWithParams:(NSDictionary*)param
                      completion:(NetworkCompletion)completion;

//根据accToken 让accToken失效
+(void)logoutWithParams:(NSDictionary*)param
             completion:(NetworkCompletion)completion;

//验证accToken是否有效
+(void)checkAccTokenWithParams:(NSDictionary*)param
                    completion:(NetworkCompletion)completion;


@end

