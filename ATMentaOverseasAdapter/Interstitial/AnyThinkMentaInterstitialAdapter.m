//
//  AnyThinkMentaInterstitialAdapter.h
//  ATMentaOverseasAdapter
//
//  Created by vlion on 2026/2/2.
//

#import "AnyThinkMentaInterstitialAdapter.h"
#import "ATMentaOverseasInterstitialDelegate.h"

@interface AnyThinkMentaInterstitialAdapter()

@property (nonatomic, strong) MentaMediationInterstitial *interstitialAd;
@property (nonatomic, strong) ATMentaOverseasInterstitialDelegate * interstitialDelegate;

@end


@implementation AnyThinkMentaInterstitialAdapter

#pragma mark - Ad load
- (void)loadADWithArgument:(ATAdMediationArgument *)argument {
    ATMentaOverseasParam *param = [[ATMentaOverseasParam alloc] initWithDictionary:argument.serverContentDic];
    if (param.slotError) {
        NSLog(@"%@ 广告位Id为空", NSStringFromClass(self.class));
        return;
    }
    
    self.interstitialAd = [[MentaMediationInterstitial alloc] initWithPlacementID:param.slotId];
    self.interstitialAd.delegate = self.interstitialDelegate;
    [self.interstitialAd loadAd];
}
 
#pragma mark - Ad show
- (void)showInterstitialInViewController:(UIViewController *)viewController {
    [self.interstitialAd showAdFromRootViewController:viewController];
}
 
#pragma mark - Ad ready
- (BOOL)adReadyInterstitialWithInfo:(NSDictionary *)info {
    return self.interstitialAd.isAdReady;
}

#pragma mark - C2S Win Loss
- (void)didReceiveBidResult:(ATBidWinLossResult *)result {
    if (result.bidResultType == ATBidWinLossResultTypeWin) {
        [self sendWin:result];
        return;
    }
    [self sendLoss:result];
}
 
- (void)sendWin:(ATBidWinLossResult *)result {
    NSMutableDictionary *infoDict = [ATMentaOverseasBaseAdapter getWinInfoResult:result];
    [self.interstitialAd sendWinnerNotificationWith:infoDict];
}

- (void)sendLoss:(ATBidWinLossResult *)result {
    NSMutableDictionary *infoDict = [ATMentaOverseasBaseAdapter getLossInfoResult:result];
    [self.interstitialAd sendLossNotificationWithWinnerPrice:result.winPrice info:infoDict];
}

#pragma mark - lazy
- (ATMentaOverseasInterstitialDelegate *)interstitialDelegate{
    if (_interstitialDelegate == nil) {
        _interstitialDelegate = [[ATMentaOverseasInterstitialDelegate alloc] init];
        _interstitialDelegate.adStatusBridge = self.adStatusBridge;
    }
    return _interstitialDelegate;
}

@end
