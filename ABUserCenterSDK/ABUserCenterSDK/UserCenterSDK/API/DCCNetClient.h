//
//  DCCNetClient.h
//  DryCargoCamp
//
//  Created by caobo56 on 2019/4/10.
//  Copyright © 2019 caobo56. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface DCCNetClient : NSObject

+(void)getNetWorkWithUrl:(NSString*)url params:(NSDictionary*)param decodeType:(NetworkDecodeType)type token:(NSString *)token completion:(NetworkCompletion)completion;

+(void)postNetWorkWithUrl:(NSString*)url params:(NSDictionary*)param decodeType:(NetworkDecodeType)type token:(NSString *)token completion:(NetworkCompletion)completion;

+(void)deleteNetWorkWithUrl:(NSString*)url params:(NSDictionary*)param decodeType:(NetworkDecodeType)type token:(NSString *)token completion:(NetworkCompletion)completion;

+(void)putNetWorkWithUrl:(NSString*)url params:(NSDictionary*)param decodeType:(NetworkDecodeType)type token:(NSString *)token completion:(NetworkCompletion)completion;


@end

NS_ASSUME_NONNULL_END
