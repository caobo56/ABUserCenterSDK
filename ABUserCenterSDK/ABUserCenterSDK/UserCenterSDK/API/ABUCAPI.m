//
//  ABUCAPI.m
//  MUserCenter
//
//  Created by caobo56 on 2019/6/27.
//  Copyright © 2019 caobo56. All rights reserved.
//

#import "ABUCAPI.h"
#import "NSString+URL.h"

//static NSString * BasicURL = @"http://10.10.101.160:9000/api/";
static NSString * BasicURL = @"http://127.0.0.1:7777/api/";

static NSString * APILogin = @"oauth/token";
static NSString * APIUserInfo = @"oauth/userInfo";
static NSString * APIRefresh = @"oauth/refresh/accToken";
static NSString * APILogout = @"oauth/logout";
static NSString * APICheck = @"oauth/check/accToken";

@implementation ABUCAPI
+(void)loginWithParams:(NSDictionary*)param
            completion:(NetworkCompletion)completion{
    NSString * url = [NSString stringWithFormat:@"%@%@",BasicURL,APILogin];
    url = [url URLDecodedString];
    [DCCNetClient postNetWorkWithUrl:url params:param decodeType:NetworkDecodeType_UTF8 token:@"" completion:completion];
}

+(void)getUserInfoWithParams:(NSDictionary*)param
            completion:(NetworkCompletion)completion{
    NSString * url = [NSString stringWithFormat:@"%@%@",BasicURL,APIUserInfo];
    url = [url URLDecodedString];
    [DCCNetClient getNetWorkWithUrl:url params:param decodeType:NetworkDecodeType_UTF8 token:@"" completion:completion];
}

+(void)refreshAccTokenWithParams:(NSDictionary*)param
                  completion:(NetworkCompletion)completion{
    NSString * url = [NSString stringWithFormat:@"%@%@",BasicURL,APIRefresh];
    url = [url URLDecodedString];
    [DCCNetClient getNetWorkWithUrl:url params:param decodeType:NetworkDecodeType_UTF8 token:@"" completion:completion];
}

+(void)logoutWithParams:(NSDictionary*)param
                      completion:(NetworkCompletion)completion{
    NSString * url = [NSString stringWithFormat:@"%@%@",BasicURL,APILogout];
    url = [url URLDecodedString];
    [DCCNetClient postNetWorkWithUrl:url params:param decodeType:NetworkDecodeType_UTF8 token:@"" completion:completion];
}

+(void)checkAccTokenWithParams:(NSDictionary*)param
             completion:(NetworkCompletion)completion{
    NSString * url = [NSString stringWithFormat:@"%@%@",BasicURL,APICheck];
    url = [url URLDecodedString];
    [DCCNetClient postNetWorkWithUrl:url params:param decodeType:NetworkDecodeType_UTF8 token:@"" completion:completion];
}

@end
