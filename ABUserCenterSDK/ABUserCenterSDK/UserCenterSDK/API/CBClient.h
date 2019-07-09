//
//  CBClient.h
//  DryCargoCamp
//
//  Created by caobo56 on 2019/4/11.
//  Copyright © 2019 caobo56. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString* const CBNetworkMethod_Get     =@"GET";
static NSString* const CBNetworkMethod_Post    =@"POST";
static NSString* const CBNetworkMethod_Put     =@"PUT";
static NSString* const CBNetworkMethod_Delete  =@"DELETE";

static NSString* const CBNetworkErrorDomain    =@"NetworkError";

enum {
    NetworkErrCode_Unknown = 0,
    NetworkErrCode_ReqParamError,
    NetworkErrCode_ReqURLError,
    NetworkErrCode_RespSCNot200,
    NetworkErrCode_IMGError
};

typedef enum NetworkDecodeType{
    NetworkDecodeType_UTF8,
    NetworkDecodeType_GBK,
    NetworkDecodeType_GB2312
}NetworkDecodeType;

typedef void(^NetworkCompletion)(NSError* error,id data);

@interface CBClient : NSObject

+ (instancetype)client;

-(void)sendUrl:(NSString*)urlStr method:(NSString*)method params:(NSDictionary*)param token:(NSString *)token completion:(NetworkCompletion)completion;

+(NSString* )NetWorkErrorMsg:(NSInteger)input;

+(NSString *)decode:(NSData*)data by:(NetworkDecodeType)type;

@end

NS_ASSUME_NONNULL_END
