//
//  ATMentaOverseasBannerDelegate.h
//  ATMentaOverseasAdapter
//
//  Created by vlion on 2026/2/2.
//

#import "ATMentaOverseasBannerDelegate.h"

@implementation ATMentaOverseasBannerDelegate

// 广告素材加载成功
- (void)menta_bannerAdDidLoad:(MentaMediationBanner *)banner {
    
}

// 广告素材加载失败
- (void)menta_bannerAdLoadFailedWithError:(NSError *)error banner:(MentaMediationBanner *)banner {
    [self.adStatusBridge atOnAdLoadFailed:error adExtra:nil];
}

// 广告素材渲染成功
// 此时可以获取 ecpm
- (void)menta_bannerAdRenderSuccess:(MentaMediationBanner *)banner bannerAdView:(UIView *)bannerAdView {
    NSDictionary *extraDic = [ATMentaOverseasBaseAdapter getC2SInfo:banner.eCPM ? banner.eCPM.doubleValue : 0];
    [self.adStatusBridge atOnBannerAdLoadedWithView:banner.bannerAdView adExtra:extraDic];
}

// 广告素材渲染失败
- (void)menta_bannerAdRenderFailureWithError:(NSError *)error banner:(MentaMediationBanner *)banner {
    
}

// 广告曝光
- (void)menta_bannerAdExposed:(MentaMediationBanner *)banner {
    [self.adStatusBridge atOnAdShow:nil];
}

// 广告点击
- (void)menta_bannerAdClicked:(MentaMediationBanner *)banner {
    [self.adStatusBridge atOnAdClick:nil];
}

// 广告关闭
-(void)menta_bannerAdClosed:(MentaMediationBanner *)banner {
    [self.adStatusBridge atOnAdClosed:nil];
}

@end
