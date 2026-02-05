//
//  ATMentaBannerDelegate.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import "ATMentaBannerDelegate.h"

@implementation ATMentaBannerDelegate

/// 广告策略服务加载成功
- (void)menta_didFinishLoadingBannerADPolicy:(MentaUnifiedBannerAd *_Nonnull)bannerAd {
    
}

/// 横幅(banner)广告源数据拉取成功
- (void)menta_bannerAdDidLoad:(MentaUnifiedBannerAd *_Nonnull)bannerAd {
    
}

/// 横幅(banner)广告物料下载成功
- (void)menta_bannerAdMaterialDidLoad:(MentaUnifiedBannerAd *_Nonnull)bannerAd {
    NSDictionary *extraDic = [ATMentaBaseAdapter getC2SInfo:self.ecpm];
    [self.adStatusBridge atOnBannerAdLoadedWithView:bannerAd.fetchBannerView adExtra:extraDic];
}

/// 横幅(banner)广告加载失败
- (void)menta_bannerAd:(MentaUnifiedBannerAd *_Nonnull)bannerAd didFailWithError:(NSError * _Nullable)error description:(NSDictionary *_Nonnull)description {
    [self.adStatusBridge atOnAdLoadFailed:error adExtra:nil];
}

/// 横幅(banner)广告被点击了
- (void)menta_bannerAdDidClick:(MentaUnifiedBannerAd *_Nonnull)bannerAd adView:(UIView *_Nullable)adView {
    [self.adStatusBridge atOnAdClick:nil];
}

/// 横幅(banner)广告关闭了
- (void)menta_bannerAdDidClose:(MentaUnifiedBannerAd *_Nonnull)bannerAd adView:(UIView *_Nullable)adView {
    [self.adStatusBridge atOnAdClosed:nil];
}

/// 横幅(banner)将要展现
- (void)menta_bannerAdWillVisible:(MentaUnifiedBannerAd *_Nonnull)bannerAd adView:(UIView *_Nullable)adView {
    
}

/// 横幅(banner)广告曝光成功
- (void)menta_bannerAdDidExpose:(MentaUnifiedBannerAd *_Nonnull)bannerAd adView:(UIView *_Nullable)adView {
    [self.adStatusBridge atOnAdShow:nil];
}

/// 横幅(banner)广告曝光失败
- (void)menta_bannerAd:(MentaUnifiedBannerAd *_Nonnull)bannerAd didFailToExposeWithError:(nullable NSError *)error {
    [self.adStatusBridge atOnAdShowFailed:error extra:nil];
}

/// 横幅(banner)广告 展现的广告信息 曝光之前会触发该回调
- (void)menta_bannerAd:(MentaUnifiedBannerAd *_Nonnull)bannerAd bestTargetSourcePlatformInfo:(NSDictionary *_Nonnull)info {
    NSNumber *price = info[BEST_SOURCE_PRICE];
    self.ecpm = (price ? price.integerValue : 0);
}

@end
