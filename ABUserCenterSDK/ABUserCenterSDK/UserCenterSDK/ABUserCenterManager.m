//
//  ABUserCenterManager.m
//  MUserCenter
//
//  Created by caobo56 on 2019/6/18.
//  Copyright © 2019 caobo56. All rights reserved.
//

#import "ABUserCenterManager.h"

@interface ABUserCenterManager()

@end

@implementation ABUserCenterManager

static ABUserCenterManager *DefaultManager = nil;

+ (ABUserCenterManager *)sharedManager
{
    static ABUserCenterManager *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}

// 防止外部调用alloc 或者 new
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [ABUserCenterManager sharedManager];
}

// 防止外部调用copy
- (id)copyWithZone:(nullable NSZone *)zone {
    return [ABUserCenterManager sharedManager];
}

// 防止外部调用mutableCopy
- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [ABUserCenterManager sharedManager];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/**
 登录方法
 
 @param block LoginStateBlk 登录回调
 */
-(void)loginWith:(LoginStateBlk)block{
    
}

/**
 更新登录状态
 
 @param block LoginStateBlk 更新登录状态回调
 */
-(void)updateWith:(LoginStateBlk)block{
    
}

/**
 检查登录状态
 
 @param block LoginStateBlk 检查登录状态回调
 */
-(void)checkWith:(LoginStateBlk)block{
    
}

/**
 退出登录
 
 @param block LoginStateBlk 退出登录状态回调
 */
-(void)logoutWith:(LoginStateBlk)block{
    
}

/**
 获取AccToken
 
 @param block AccTokenBlk 获取AccToken回调
 */
-(void)getAccToken:(AccTokenBlk)block{
    
}

/**
 获取AccToken
 
 @param block AccTokenBlk 获取AccToken回调
 */
-(void)getUserInfoWith:(UserInfoBlk)block{
    
}

@end
