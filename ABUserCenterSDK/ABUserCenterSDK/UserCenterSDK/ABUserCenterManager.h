//
//  ABUserCenterManager.h
//  MUserCenter
//
//  Created by caobo56 on 2019/6/18.
//  Copyright © 2019 caobo56. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum _UserState {
    UserDefaultState = 100,//默认状态
    UserLogin,//用户登录成功
    UserLogout,//用户退出登录
    UserOtherState//用户其他登录状态
} UserState;
//用户登录状态枚举

/**
 LoginStateBlk(登录状态回调)

 @param state state 登录状态
 @param err err 错误描述
 */
typedef void(^LoginStateBlk)(UserState state,NSError *err);

/**
 AccTokenBlk(获取AccToken回调)

 @param accToken accToken AccToken_String
 @param err err 错误描述
 */
typedef void(^AccTokenBlk)(NSString * accToken,NSError *err);

/**
 LogoutBlk(退出登录回调)

 @param state state 登录状态
 @param err err 错误描述
 */
typedef void(^LogoutBlk)(UserState state,NSError *err);

/**
 UserInfoBlk(用户信息回调)

 @param userInfo userInfo 用户信息
 @param err err 错误描述
 */
typedef void(^UserInfoBlk)(NSDictionary * userInfo,NSError *err);

@interface ABUserCenterManager : NSObject

/**
 用户中心单例实例化方法

 @return return ABUserCenterManager 用户中心全局单例
 */
+ (ABUserCenterManager *)sharedManager;

/**
 登录方法

 @param block LoginStateBlk 登录回调
 */
-(void)loginWith:(LoginStateBlk)block;

/**
 更新登录状态

 @param block LoginStateBlk 更新登录状态回调
 */
-(void)updateWith:(LoginStateBlk)block;

/**
 检查登录状态
 
 @param block LoginStateBlk 检查登录状态回调
 */
-(void)checkWith:(LoginStateBlk)block;

/**
 退出登录
 
 @param block LoginStateBlk 退出登录状态回调
 */
-(void)logoutWith:(LoginStateBlk)block;

/**
 获取AccToken

 @param block AccTokenBlk 获取AccToken回调
 */
-(void)getAccToken:(AccTokenBlk)block;

/**
 获取AccToken
 
 @param block AccTokenBlk 获取AccToken回调
 */
-(void)getUserInfoWith:(UserInfoBlk)block;

@end

NS_ASSUME_NONNULL_END
