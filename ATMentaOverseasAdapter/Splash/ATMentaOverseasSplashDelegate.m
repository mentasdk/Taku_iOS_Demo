//
//  ATMentaOverseasSplashDelegate.h
//  ATMentaOverseasAdapter
//
//  Created by vlion on 2026/2/2.
//

#import "ATMentaOverseasSplashDelegate.h"
#import "ATMentaOverseasInitAdapter.h"

@implementation ATMentaOverseasSplashDelegate

// 广告素材加载成功
- (void)menta_splashAdDidLoad:(MentaMediationSplash *)splash {
    
}

// 广告素材加载失败
- (void)menta_splashAdLoadFailedWithError:(NSError *)error splash:(MentaMediationSplash *)splash {
    [self.adStatusBridge atOnAdLoadFailed:error adExtra:nil];
}

// 广告素材渲染成功
// 此时可以获取 ecpm
- (void)menta_splashAdRenderSuccess:(MentaMediationSplash *)splash {
    NSDictionary *extraDic = [ATMentaOverseasBaseAdapter getC2SInfo:splash.eCPM ? splash.eCPM.doubleValue : 0];
    [self.adStatusBridge atOnSplashAdLoadedExtra:extraDic];
}

// 广告素材渲染失败
- (void)menta_splashAdRenderFailureWithError:(NSError *)error splash:(MentaMediationSplash *)splash {
    
}

// 开屏广告即将展示
- (void)menta_splashAdWillPresent:(MentaMediationSplash *)splash {
    
}

// 开屏广告展示失败
- (void)menta_splashAdShowFailWithError:(NSError *)error splash:(MentaMediationSplash *)splash {
    [self.adStatusBridge atOnAdShowFailed:error extra:nil];
}

// 开屏广告曝光
- (void)menta_splashAdExposed:(MentaMediationSplash *)splash {
    [self.adStatusBridge atOnAdShow:nil];
}

// 开屏广告点击
- (void)menta_splashAdClicked:(MentaMediationSplash *)splash {
    [self.adStatusBridge atOnAdClick:nil];
}

// 开屏广告关闭
-(void)menta_splashAdClosed:(MentaMediationSplash *)splash {
    [self.adStatusBridge atOnAdClosed:nil];
}

@end
