//
//  ATMentaOverseasRewardVideoDelegate.h
//  ATMentaOverseasAdapter
//
//  Created by vlion on 2026/2/2.
//

#import "ATMentaOverseasRewardVideoDelegate.h"

@implementation ATMentaOverseasRewardVideoDelegate

// 广告素材加载成功
- (void)menta_rewardVideoDidLoad:(MentaMediationRewardVideo *)rewardVideo {
    
}

// 广告素材加载失败
- (void)menta_rewardVideoLoadFailedWithError:(NSError *)error rewardVideo:(MentaMediationRewardVideo *)rewardVideo {
    [self.adStatusBridge atOnAdLoadFailed:error adExtra:nil];
}

// 广告素材渲染成功
// 此时可以获取 ecpm
- (void)menta_rewardVideoRenderSuccess:(MentaMediationRewardVideo *)rewardVideo {
    NSDictionary *extraDic = [ATMentaOverseasBaseAdapter getC2SInfo:rewardVideo.eCPM ? rewardVideo.eCPM.doubleValue : 0];
    [self.adStatusBridge atOnRewardedAdLoadedExtra:extraDic];
}

// 广告素材渲染失败
- (void)menta_rewardVideoRenderFailureWithError:(NSError *)error rewardVideo:(MentaMediationRewardVideo *)rewardVideo {
    
}

// 激励视频广告即将展示
- (void)menta_rewardVideoWillPresent:(MentaMediationRewardVideo *)rewardVideo {
    
}

// 激励视频广告展示失败
- (void)menta_rewardVideoShowFailWithError:(NSError *)error rewardVideo:(MentaMediationRewardVideo *)rewardVideo {
    [self.adStatusBridge atOnAdShowFailed:error extra:nil];
}

// 激励视频广告曝光
- (void)menta_rewardVideoExposed:(MentaMediationRewardVideo *)rewardVideo {
    [self.adStatusBridge atOnAdShow:nil];
}

// 激励视频广告点击
- (void)menta_rewardVideoClicked:(MentaMediationRewardVideo *)rewardVideo {
    [self.adStatusBridge atOnAdClick:nil];
}

// 激励视频广告跳过
- (void)menta_rewardVideoSkiped:(MentaMediationRewardVideo *)rewardVideo {
    
}

// 激励视频达到奖励节点
- (void)menta_rewardVideoDidEarnReward:(MentaMediationRewardVideo *)rewardVideo {
    [self.adStatusBridge atOnRewardedVideoAdRewarded];
}

// 激励视频播放完成
- (void)menta_rewardVideoPlayCompleted:(MentaMediationRewardVideo *)rewardVideo {
    [self.adStatusBridge atOnAdVideoEnd:nil];
}

// 激励视频广告关闭
-(void)menta_rewardVideoClosed:(MentaMediationRewardVideo *)rewardVideo {
    [self.adStatusBridge atOnAdClosed:nil];
}

@end
