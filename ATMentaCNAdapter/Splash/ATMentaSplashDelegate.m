//
//  ATMentaSplashDelegate.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import "ATMentaSplashDelegate.h"
#import "ATMentaInitAdapter.h"

@implementation ATMentaSplashDelegate

/// 广告策略服务加载成功
- (void)menta_didFinishLoadingADPolicy:(MentaUnifiedSplashAd *_Nonnull)splashAd {
    
}

/// 开屏广告数据拉取成功
- (void)menta_splashAdDidLoad:(MentaUnifiedSplashAd *_Nonnull)splashAd {
    NSDictionary *extraDic = [ATMentaBaseAdapter getC2SInfo:self.ecpm];
    [self.adStatusBridge atOnSplashAdLoadedExtra:extraDic];
}

/// 开屏加载失败
- (void)menta_splashAd:(MentaUnifiedSplashAd *_Nonnull)splashAd didFailWithError:(NSError * _Nullable)error description:(NSDictionary *_Nonnull)description {
    [self.adStatusBridge atOnAdLoadFailed:error adExtra:nil];
}

/// 开屏广告被点击了
- (void)menta_splashAdDidClick:(MentaUnifiedSplashAd *_Nonnull)splashAd {
    [self.adStatusBridge atOnAdClick:nil];
}

/// 开屏广告关闭了
- (void)menta_splashAdDidClose:(MentaUnifiedSplashAd *_Nonnull)splashAd closeMode:(MentaSplashAdCloseMode)mode {
    [self.adStatusBridge atOnAdClosed:nil];
}

/// 开屏广告曝光成功
- (void)menta_splashAdDidExpose:(MentaUnifiedSplashAd *_Nonnull)splashAd {
    [self.adStatusBridge atOnAdShow:nil];
}

/// 开屏广告曝光失败
- (void)menta_splashAd:(MentaUnifiedSplashAd *_Nonnull)splashAd didFailToExposeWithError:(nullable NSError *)error {
    [self.adStatusBridge atOnAdShowFailed:error extra:nil];
}

/// 开屏广告 展现的广告信息 曝光之前会触发该回调
- (void)menta_splashAd:(MentaUnifiedSplashAd *_Nonnull)splashAd bestTargetSourcePlatformInfo:(NSDictionary *_Nonnull)info {
    NSNumber *price = info[BEST_SOURCE_PRICE];
    self.ecpm = (price ? price.integerValue : 0);
}

@end
