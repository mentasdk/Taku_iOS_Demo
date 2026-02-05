//
//  ATMentaInterstitialDelegate.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import "ATMentaInterstitialDelegate.h"

@implementation ATMentaInterstitialDelegate

/// 广告策略服务加载成功
- (void)menta_didFinishLoadingInterstitialADPolicy:(MentaUnifiedInterstitialAd *_Nonnull)interstitialAd {
    
}

/// 插屏广告源数据拉取成功
- (void)menta_interstitialAdDidLoad:(MentaUnifiedInterstitialAd *_Nonnull)interstitialAd {
    
}

/// 插屏广告视频下载成功
- (void)menta_interstitialAdMaterialDidLoad:(MentaUnifiedInterstitialAd *_Nonnull)interstitialAd {
    NSDictionary * extraDic = [ATMentaBaseAdapter getC2SInfo:self.ecpm];
    [self.adStatusBridge atOnInterstitialAdLoadedExtra:extraDic];
}

/// 插屏广告加载失败
- (void)menta_interstitialAd:(MentaUnifiedInterstitialAd *_Nonnull)interstitialAd
            didFailWithError:(NSError * _Nullable)error
                 description:(NSDictionary *_Nonnull)description {
    [self.adStatusBridge atOnAdLoadFailed:error adExtra:nil];
}

/// 插屏广告被点击了
- (void)menta_interstitialAdDidClick:(MentaUnifiedInterstitialAd *_Nonnull)interstitialAd {
    [self.adStatusBridge atOnAdClick:nil];
}

/// 插屏广告关闭了
- (void)menta_interstitialAdDidClose:(MentaUnifiedInterstitialAd *_Nonnull)interstitialAd {
    [self.adStatusBridge atOnAdClosed:nil];
}

/// 插屏将要展现
- (void)menta_interstitialAdWillVisible:(MentaUnifiedInterstitialAd *_Nonnull)interstitialAd {
    
}

/// 插屏广告曝光成功
- (void)menta_interstitialAdDidExpose:(MentaUnifiedInterstitialAd *_Nonnull)interstitialAd {
    [self.adStatusBridge atOnAdShow:nil];
}

/// 插屏广告曝光失败
- (void)menta_interstitialAd:(MentaUnifiedInterstitialAd *_Nonnull)interstitialAd didFailToExposeWithError:(nullable NSError *)error {
    [self.adStatusBridge atOnAdShowFailed:error extra:nil];
}

/// 插屏广告 展现的广告信息 曝光之前会触发该回调
- (void)menta_interstitialAd:(MentaUnifiedInterstitialAd *_Nonnull)interstitialAd bestTargetSourcePlatformInfo:(NSDictionary *_Nonnull)info {
    NSNumber *price = info[BEST_SOURCE_PRICE];
    self.ecpm = (price ? price.integerValue : 0);
}

@end
