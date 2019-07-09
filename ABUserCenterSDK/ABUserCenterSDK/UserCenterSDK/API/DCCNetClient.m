//
//  DCCNetClient.m
//  DryCargoCamp
//
//  Created by caobo56 on 2019/4/10.
//  Copyright © 2019 caobo56. All rights reserved.
//

#import "DCCNetClient.h"
#import "JsonHelper.h"

@implementation DCCNetClient


+(void)getNetWorkWithUrl:(NSString*)urlStr params:(NSDictionary*)param decodeType:(NetworkDecodeType)type token:(NSString *)token completion:(NetworkCompletion)completion{
    [DCCNetClient sendUrl:urlStr method:CBNetworkMethod_Get params:param decodeType:type token:token completion:completion];
}

+(void)postNetWorkWithUrl:(NSString*)urlStr params:(NSDictionary*)param decodeType:(NetworkDecodeType)type token:(NSString *)token completion:(NetworkCompletion)completion{
    [DCCNetClient sendUrl:urlStr method:CBNetworkMethod_Post params:param decodeType:type token:token completion:completion];
}

+(void)deleteNetWorkWithUrl:(NSString*)urlStr params:(NSDictionary*)param decodeType:(NetworkDecodeType)type token:(NSString *)token completion:(NetworkCompletion)completion{
    [DCCNetClient sendUrl:urlStr method:CBNetworkMethod_Delete params:param decodeType:type token:token completion:completion];
}

+(void)putNetWorkWithUrl:(NSString*)urlStr params:(NSDictionary*)param decodeType:(NetworkDecodeType)type token:(NSString *)token completion:(NetworkCompletion)completion{
    [DCCNetClient sendUrl:urlStr method:CBNetworkMethod_Put params:param decodeType:type token:token completion:completion];
}

+(void)sendUrl:(NSString*)urlStr method:(NSString*)method params:(NSDictionary*)param decodeType:(NetworkDecodeType)type token:(NSString *)token completion:(NetworkCompletion)completion{
    
    [[CBClient client]sendUrl:urlStr method:method params:param token:token completion:^(NSError * _Nonnull error, id  _Nonnull data) {
        
        if (error) {
            completion(error,data);
            return;
        }
        
        if (!data) {
            NSDictionary* ui=@{@"statusCode":@(200),
                               @"errorMsg":[CBClient NetWorkErrorMsg:NetworkErrCode_ReqParamError],
                               @"data":@""};
            
            NSError * errOut = [NSError errorWithDomain:CBNetworkErrorDomain code:(NetworkErrCode_ReqParamError) userInfo:ui];
            completion(errOut,data);
            return;
        }
        
        NSString * string = [CBClient decode:data by:type];
        NSLog(@"string = %@",string);
        if (!string) {
            NSDictionary* ui=@{
                               @"statusCode":@(200),
                               @"errorMsg":[CBClient NetWorkErrorMsg:NetworkErrCode_ReqParamError],
                               @"data":@"Response decode error"
                               };
            NSError * errOut = [NSError errorWithDomain:CBNetworkErrorDomain code:(NetworkErrCode_ReqParamError) userInfo:ui];
            completion(errOut,data);
            return;
        }
        
        NSDictionary * dict = [JsonHelper dictionaryWithJsonString:string];
        
        NSMutableDictionary * dataOut;
        if (!dict) {
            NSDictionary* ui=@{
                               @"statusCode":@(200),
                               @"errorMsg":[CBClient NetWorkErrorMsg:NetworkErrCode_ReqParamError],
                               @"data":@"This is not a json data！"
                               };
            NSError * errOut = [NSError errorWithDomain:CBNetworkErrorDomain code:(NetworkErrCode_ReqParamError) userInfo:ui];
            completion(errOut,string);
            return;
        }
        
        if ([dict isKindOfClass:[NSDictionary class]]) {
            dataOut = [NSMutableDictionary dictionaryWithDictionary:dict];
        }else if ([dict isKindOfClass:[NSArray class]]) {
            dataOut = [NSMutableDictionary dictionaryWithCapacity:1];
            [dataOut setObject:dict forKey:@"array"];
        } else {
            [dataOut setObject:dict forKey:@"data"];
        }
        completion(error,dataOut);
        
    }];
}

@end
