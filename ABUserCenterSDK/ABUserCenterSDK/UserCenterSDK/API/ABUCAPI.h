//
//  ABUCAPI.h
//  MUserCenter
//
//  Created by caobo56 on 2019/6/27.
//  Copyright © 2019 caobo56. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UCNetClient.h"


@interface ABUCAPI : NSObject

//登录获取accToken
//{"username":"ab10002","password":"abic@123","grant_type":"password"}
+(void)loginWithParams:(NSDictionary*)param
            completion:(NetworkCompletion)completion;

//refToken刷新accToken
//{"grant_type":"refresh_token","refresh_token":"5e6b4c3c-6c63-4ce9-83d8-b7e71ad04ec0"}
+(void)refreshAccTokenWithParams:(NSDictionary*)param
                      completion:(NetworkCompletion)completion;

//验证accToken是否有效
//token:3c5f0b32-0368-4296-b2d6-7d7f7d0daeae
+(void)checkAccTokenWithParams:(NSDictionary*)param
                    completion:(NetworkCompletion)completion;

//根据accToken获取用户信息
//token:3c5f0b32-0368-4296-b2d6-7d7f7d0daeae
+(void)getUserInfoWithParams:(NSDictionary*)param
                  completion:(NetworkCompletion)completion;


//根据accToken 让accToken失效
+(void)logoutWithParams:(NSDictionary*)param
             completion:(NetworkCompletion)completion;


@end

