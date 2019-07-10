//
//  CBClient.m
//  DryCargoCamp
//
//  Created by caobo56 on 2019/4/11.
//  Copyright © 2019 caobo56. All rights reserved.
//

#import "CBClient.h"
 
#define CB_TIMEOUT 20.0f

@interface CBClient ()

@property (nonatomic, strong) NSURLSession *session;

@end


@implementation CBClient

+ (instancetype)client {
    static CBClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[CBClient alloc] init];
    });
    return client;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        // app名称
        NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        NSString *app_ShortVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        NSString *userAgent = [NSString stringWithFormat:@"%@/%@, iOS/%@",
                               app_Name,app_ShortVersion,
                               [[NSProcessInfo processInfo] operatingSystemVersionString]];
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        _session.configuration.HTTPAdditionalHeaders = @{@"User-Agent": userAgent};
    }
    return self;
}


-(void)sendUrl:(NSString*)urlStr method:(NSString*)method params:(NSDictionary*)param token:(NSString *)token completion:(NetworkCompletion)completion{
    
    __block NSError* errOut = nil;
    
    NSString * urlstr;
    
    if ([urlStr hasPrefix:@"https:/"] || [urlStr hasPrefix:@"http:/"]) {
        urlstr = urlStr;
    }else {
        NSDictionary* ui= @{@"statusCode":@(0),
                            @"errorMsg":[CBClient NetWorkErrorMsg:NetworkErrCode_ReqURLError]};
        errOut = [NSError errorWithDomain:CBNetworkErrorDomain code:(NetworkErrCode_ReqURLError) userInfo:ui];
        completion(errOut,@"");
        return;
    }
    
    NSMutableURLRequest *request = CreateRequest(urlstr, method, param, token);

    @try {
        [[_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

            if (error) {
                if (httpResponse.statusCode != 200) {
                    NSDictionary* ui= @{@"statusCode":@(httpResponse.statusCode),
                                        @"errorMsg":[CBClient NetWorkErrorMsg:NetworkErrCode_RespSCNot200],
                                        @"data":[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                    errOut = [NSError errorWithDomain:CBNetworkErrorDomain code:(NetworkErrCode_RespSCNot200) userInfo:ui];
                }
            }
            
            if (!errOut) {
                if (!data) {
                    NSDictionary* ui= @{@"statusCode":@(httpResponse.statusCode),
                                        @"errorMsg":[CBClient NetWorkErrorMsg:NetworkErrCode_ReqParamError],
                                        @"data":[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]};
                    errOut = [NSError errorWithDomain:CBNetworkErrorDomain code:(NetworkErrCode_ReqParamError) userInfo:ui];
                }
            }
            
            dispatch_sync(dispatch_get_main_queue(), ^{
#if DEBUG
                NSLog(@"data:%@",data);
                NSLog(@"error:%@",error);
#endif
                completion(errOut,data);
            });

        }] resume];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }
}


#pragma mark - CreateRequest

static NSMutableURLRequest * CreateRequest(NSString* url,NSString* method,NSDictionary* param,NSString* token){
    
    if ([method isEqualToString:CBNetworkMethod_Get] || [method isEqualToString:CBNetworkMethod_Delete]) {
        if (param) {
            NSArray * keys = [param allKeys];
            if ([keys count] > 0) {
                NSMutableArray * arr = [NSMutableArray arrayWithCapacity:[keys count]];
                for (NSString * key in keys) {
                    [arr addObject:[NSString stringWithFormat:@"%@ = %@",key,CBEncodeToPercentEscapeString([param[key] description])]];
                }
                url = [url stringByAppendingFormat:@"?%@",[arr componentsJoinedByString:@"&"]];
            }
        }
    }
    
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [req setTimeoutInterval:CB_TIMEOUT];
    if (token) {
        [req setValue:token forHTTPHeaderField:@"token"];
    }
//    [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"Basic dWMtbW9iaWxlOmNhb2JvMTIzNDU2" forHTTPHeaderField:@"Authorization"];
    //验证本地数据与远程数据是否相同，如果不同则下载远程数据，否则使用本地数据
    [req setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    
    [req setHTTPMethod:method];
    
    if ([method isEqualToString:CBNetworkMethod_Post] || [method isEqualToString:CBNetworkMethod_Put]) {
        if (param) {
            NSArray * keys = [param allKeys];
            if ([keys count] > 0) {
                NSData* dataC = [NSJSONSerialization dataWithJSONObject:param options:0 error:NULL];
                [req setHTTPBody:dataC];
            }
        }
    }
    
#ifdef DEBUG
    NSLog(@"%@:%@\n%@\nToken=%@",method,url,param,token);
#endif
    return req;
}

NSString * CBEncodeToPercentEscapeString(NSString *input)
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                 (CFStringRef)input,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8));
}

/**
 NetworkErrCode_Unknown=0,
 NetworkErrCode_ReqParamError,
 NetworkErrCode_ReqURLError,
 NetworkErrCode_RespSCNot200
 
 @param input ErrorType
 @return NetWorkErrorMsg
 */
+(NSString* )NetWorkErrorMsg:(NSInteger)input{
    NSString * errorMsg = @"";
    
    switch (input) {
        case NetworkErrCode_Unknown:
            errorMsg = @"未知类型错误！";
            break;
        case NetworkErrCode_ReqParamError:
            errorMsg = @"后台服务访问出错！";
            break;
        case NetworkErrCode_ReqURLError:
            errorMsg = @"访问地址不存在！";
            break;
        case NetworkErrCode_RespSCNot200:
            errorMsg = @"服务器访问异常！";
            break;
        default:
            break;
    }
    return errorMsg;
}

+(NSString *)decode:(NSData*)data by:(NetworkDecodeType)type{
    NSString *string = @"";
    if (type == NetworkDecodeType_UTF8) {
        string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }else if (type == NetworkDecodeType_GBK){
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        string = [[NSString alloc] initWithData:data encoding:gbkEncoding];
    }else if (type == NetworkDecodeType_GB2312){
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        string = [[NSString alloc] initWithData:data encoding:gbkEncoding];
    }else{
        string = nil;
    }
    return string;
}

@end
