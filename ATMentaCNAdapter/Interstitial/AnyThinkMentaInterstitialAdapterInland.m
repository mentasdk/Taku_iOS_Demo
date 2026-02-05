//
//  AnyThinkMentaInterstitialAdapterInland.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import "AnyThinkMentaInterstitialAdapterInland.h"
#import "ATMentaInterstitialDelegate.h"

@interface AnyThinkMentaInterstitialAdapterInland()

@property (nonatomic, strong) MentaUnifiedInterstitialAd *interstitialAd;
@property (nonatomic, strong) ATMentaInterstitialDelegate * interstitialDelegate;

@end


@implementation AnyThinkMentaInterstitialAdapterInland

#pragma mark - Ad load
- (void)loadADWithArgument:(ATAdMediationArgument *)argument {
    ATMentaParam *param = [[ATMentaParam alloc] initWithDictionary:argument.serverContentDic];
    if (param.slotError) {
        NSLog(@"%@ 广告位Id为空", NSStringFromClass(self.class));
        return;
    }
    
    MUInterstitialConfig *config = [[MUInterstitialConfig alloc] init];
    config.adSize = UIScreen.mainScreen.bounds.size;
    config.slotId = param.slotId;

    self.interstitialAd = [[MentaUnifiedInterstitialAd alloc] initWithConfig:config];
    self.interstitialAd.delegate = self.interstitialDelegate;
    [self.interstitialAd loadAd];
}
 
#pragma mark - Ad show
- (void)showInterstitialInViewController:(UIViewController *)viewController {
    [self.interstitialAd showAdFromViewController:viewController];
}
 
#pragma mark - Ad ready
- (BOOL)adReadyInterstitialWithInfo:(NSDictionary *)info {
    return self.interstitialAd.isAdValid;
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
    [self.interstitialAd sendWinNotification];
}

- (void)sendLoss:(ATBidWinLossResult *)result {
    NSMutableDictionary *infoDict = [ATMentaBaseAdapter getLossInfoResult:result];
    [self.interstitialAd sendLossNotificationWithInfo:infoDict];
}

#pragma mark - lazy
- (ATMentaInterstitialDelegate *)interstitialDelegate{
    if (_interstitialDelegate == nil) {
        _interstitialDelegate = [[ATMentaInterstitialDelegate alloc] init];
        _interstitialDelegate.adStatusBridge = self.adStatusBridge;
    }
    return _interstitialDelegate;
}

@end
