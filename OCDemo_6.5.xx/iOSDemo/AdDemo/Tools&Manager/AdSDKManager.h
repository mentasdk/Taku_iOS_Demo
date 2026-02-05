//
//  AdSDKManager.h
//  iOSDemo
//
//  Created by ltz on 2025/3/26.
//

#import <Foundation/Foundation.h>
#import <AnyThinkSDK/AnyThinkSDK.h> 

///初始化完成回调
typedef void (^AdManagerInitFinishBlock)(void);

//在后台的应用ID
#define kTakuAppID  @"a66139b008c636"

//在后台的应用维度AppKey，或者是账号维度AppKey
#define kTakuAppKey @"aed503d8200feb80e5ac7f005980f011f"

//冷启动开屏超时时间
#define FirstAppOpen_Timeout 8

//冷启动开屏广告位ID
#define FirstAppOpen_PlacementID @"b1fh1t2hri6ojr"

@interface AdSDKManager : NSObject

+ (instancetype)sharedManager;
 
/// 应用若在欧盟地区发行，使用本方法初始化
- (void)initSDK_EU:(AdManagerInitFinishBlock)block;

/// 初始化SDK
- (void)initSDK;

#pragma mark - 开屏广告相关

/// 启动开屏广告
- (void)startSplashAd;
 
@end


