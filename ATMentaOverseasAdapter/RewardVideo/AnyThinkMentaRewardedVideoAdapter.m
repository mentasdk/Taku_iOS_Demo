//
//  AnyThinkMentaRewardedVideoAdapter.h
//  ATMentaOverseasAdapter
//
//  Created by vlion on 2026/2/2.
//

#import "AnyThinkMentaRewardedVideoAdapter.h"
#import "ATMentaOverseasRewardVideoDelegate.h"

@interface AnyThinkMentaRewardedVideoAdapter()

@property (nonatomic, strong) MentaMediationRewardVideo *rewardAd;
@property (nonatomic, strong) ATMentaOverseasRewardVideoDelegate *rewardedVideoDelegate;

@end


@implementation AnyThinkMentaRewardedVideoAdapter
 
#pragma mark - Ad load
- (void)loadADWithArgument:(ATAdMediationArgument *)argument {
    ATMentaOverseasParam *param = [[ATMentaOverseasParam alloc] initWithDictionary:argument.serverContentDic];
    if (param.slotError) {
        NSLog(@"%@ 广告位Id为空", NSStringFromClass(self.class));
        return;
    }
    
    self.rewardAd = [[MentaMediationRewardVideo alloc] initWithPlacementID:param.slotId];
    self.rewardAd.delegate = self.rewardedVideoDelegate;
    [self.rewardAd loadAd];
}
 
#pragma mark - Ad show
- (void)showRewardedVideoInViewController:(UIViewController *)viewController {
    [self.rewardAd showAdFromRootViewController:viewController];
}

#pragma mark - Ad ready
- (BOOL)adReadyRewardedWithInfo:(NSDictionary *)info {
    return self.rewardAd.isAdReady;
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
    [self.rewardAd sendWinnerNotificationWith:infoDict];
}

- (void)sendLoss:(ATBidWinLossResult *)result {
    NSMutableDictionary *infoDict = [ATMentaOverseasBaseAdapter getLossInfoResult:result];
    [self.rewardAd sendLossNotificationWithWinnerPrice:result.winPrice info:infoDict];
}

#pragma mark - lazy
- (ATMentaOverseasRewardVideoDelegate *)rewardedVideoDelegate{
    if (_rewardedVideoDelegate == nil) {
        _rewardedVideoDelegate = [[ATMentaOverseasRewardVideoDelegate alloc] init];
        _rewardedVideoDelegate.adStatusBridge = self.adStatusBridge;
    }
    return _rewardedVideoDelegate;
}

@end
