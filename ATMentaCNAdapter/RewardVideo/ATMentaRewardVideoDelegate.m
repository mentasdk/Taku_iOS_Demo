//
//  ATMentaRewardVideoDelegate.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import "ATMentaRewardVideoDelegate.h"

@implementation ATMentaRewardVideoDelegate

/// 广告策略服务加载成功
- (void)menta_didFinishLoadingRewardVideoADPolicy:(MentaUnifiedRewardVideoAd *_Nonnull)rewardVideoAd {
    
}

/// 激励视频广告源数据拉取成功
- (void)menta_rewardVideoAdDidLoad:(MentaUnifiedRewardVideoAd *_Nonnull)rewardVideoAd {
    
}

/// 激励视频广告视频下载成功
- (void)menta_rewardVideoAdMaterialDidLoad:(MentaUnifiedRewardVideoAd *_Nonnull)rewardVideoAd {
    NSDictionary *extraDic = [ATMentaBaseAdapter getC2SInfo:self.ecpm];
    [self.adStatusBridge atOnRewardedAdLoadedExtra:extraDic];
}

/// 激励视频加载失败
- (void)menta_rewardVideoAd:(MentaUnifiedRewardVideoAd *_Nonnull)rewardVideoAd
           didFailWithError:(NSError * _Nullable)error
                description:(NSDictionary *_Nonnull)description {
    [self.adStatusBridge atOnAdLoadFailed:error adExtra:nil];
}

/// 激励视频广告被点击了
- (void)menta_rewardVideoAdDidClick:(MentaUnifiedRewardVideoAd *_Nonnull)rewardVideoAd {
    [self.adStatusBridge atOnAdClick:nil];
}

/// 激励视频广告关闭了
- (void)menta_rewardVideoAdDidClose:(MentaUnifiedRewardVideoAd *_Nonnull)rewardVideoAd closeMode:(MentaRewardVideoAdCloseMode)mode {
    [self.adStatusBridge atOnAdClosed:nil];
}

/// 激励视频将要展现
- (void)menta_rewardVideoAdWillVisible:(MentaUnifiedRewardVideoAd *_Nonnull)rewardVideoAd {
    
}

/// 激励视频广告曝光成功
- (void)menta_rewardVideoAdDidExpose:(MentaUnifiedRewardVideoAd *_Nonnull)rewardVideoAd {
    [self.adStatusBridge atOnAdShow:nil];
}

/// 激励视频广告曝光失败
- (void)menta_rewardVideoAd:(MentaUnifiedRewardVideoAd *_Nonnull)rewardVideoAd didFailToExposeWithError:(nullable NSError *)error {
    [self.adStatusBridge atOnAdShowFailed:error extra:nil];
}

/// 激励视频广告播放达到激励条件回调
- (void)menta_rewardVideoAdDidRewardEffective:(MentaUnifiedRewardVideoAd *_Nonnull)rewardVideoAd {
    [self.adStatusBridge atOnRewardedVideoAdRewarded];
}

/// 激励视频广告播放完成回调
- (void)menta_rewardVideoAdDidPlayFinish:(MentaUnifiedRewardVideoAd *_Nonnull)rewardVideoAd {
    [self.adStatusBridge atOnAdVideoEnd:nil];
}

/// 激励视频广告 展现的广告信息 曝光之前会触发该回调
- (void)menta_rewardVideoAd:(MentaUnifiedRewardVideoAd *_Nonnull)rewardVideoAd bestTargetSourcePlatformInfo:(NSDictionary *_Nonnull)info {
    NSNumber *price = info[BEST_SOURCE_PRICE];
    self.ecpm = (price ? price.integerValue : 0);
}
 
@end
