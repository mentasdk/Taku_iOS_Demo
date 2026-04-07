//
//  ATMentaOverseasInterstitialDelegate.h
//  ATMentaOverseasAdapter
//
//  Created by vlion on 2026/2/2.
//

#import "ATMentaOverseasInterstitialDelegate.h"

@implementation ATMentaOverseasInterstitialDelegate

// 广告素材加载成功
- (void)menta_interstitialDidLoad:(MentaMediationInterstitial *)interstitial {
    
}

// 广告素材加载失败
- (void)menta_interstitialLoadFailedWithError:(NSError *)error interstitial:(MentaMediationInterstitial *)interstitial {
    [self.adStatusBridge atOnAdLoadFailed:error adExtra:nil];
}

// 广告素材渲染成功
// 此时可以获取 ecpm
- (void)menta_interstitialRenderSuccess:(MentaMediationInterstitial *)interstitial {
    NSDictionary * extraDic = [ATMentaOverseasBaseAdapter getC2SInfo:interstitial.eCPM ? interstitial.eCPM.doubleValue : 0];
    [self.adStatusBridge atOnInterstitialAdLoadedExtra:extraDic];
}

// 广告素材渲染失败
- (void)menta_interstitialRenderFailureWithError:(NSError *)error interstitial:(MentaMediationInterstitial *)interstitial {
    
}

// 广告即将展示
- (void)menta_interstitialWillPresent:(MentaMediationInterstitial *)interstitial {
    
}

// 广告展示失败
- (void)menta_interstitialShowFailWithError:(NSError *)error interstitial:(MentaMediationInterstitial *)interstitial {
    [self.adStatusBridge atOnAdShowFailed:error extra:nil];
}

// 广告曝光
- (void)menta_interstitialExposed:(MentaMediationInterstitial *)interstitial {
    [self.adStatusBridge atOnAdShow:nil];
}

// 广告点击
- (void)menta_interstitialClicked:(MentaMediationInterstitial *)interstitial {
    [self.adStatusBridge atOnAdClick:nil];
}

// 视频播放完成
- (void)menta_interstitialPlayCompleted:(MentaMediationInterstitial *)interstitial {
    [self.adStatusBridge atOnAdVideoEnd:nil];
}

// 广告关闭
-(void)menta_interstitialClosed:(MentaMediationInterstitial *)interstitial {
    [self.adStatusBridge atOnAdClosed:nil];
}

@end
