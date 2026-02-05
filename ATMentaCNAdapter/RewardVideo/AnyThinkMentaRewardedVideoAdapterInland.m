//
//  AnyThinkMentaRewardedVideoAdapterInland.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import "AnyThinkMentaRewardedVideoAdapterInland.h"
#import "ATMentaRewardVideoDelegate.h"

@interface AnyThinkMentaRewardedVideoAdapterInland()

@property (nonatomic, strong) MentaUnifiedRewardVideoAd *rewardAd;
@property (nonatomic, strong) ATMentaRewardVideoDelegate *rewardedVideoDelegate;

@end


@implementation AnyThinkMentaRewardedVideoAdapterInland
 
#pragma mark - Ad load
- (void)loadADWithArgument:(ATAdMediationArgument *)argument {
    ATMentaParam *param = [[ATMentaParam alloc] initWithDictionary:argument.serverContentDic];
    if (param.slotError) {
        NSLog(@"%@ 广告位Id为空", NSStringFromClass(self.class));
        return;
    }
    
    MURewardVideoConfig *config = [[MURewardVideoConfig alloc] init];
    config.adSize = UIScreen.mainScreen.bounds.size;
    config.slotId = param.slotId;
    config.videoGravity = MentaRewardVideoAdViewGravity_ResizeAspect;
    
    self.rewardAd = [[MentaUnifiedRewardVideoAd alloc] initWithConfig:config];
    self.rewardAd.delegate = self.rewardedVideoDelegate;
    [self.rewardAd loadAd];
}
 
#pragma mark - Ad show
- (void)showRewardedVideoInViewController:(UIViewController *)viewController {
    [self.rewardAd showAdFromRootViewController:viewController];
}

#pragma mark - Ad ready
- (BOOL)adReadyRewardedWithInfo:(NSDictionary *)info {
    return self.rewardAd.isAdValid;
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
    [self.rewardAd sendWinNotification];
}

- (void)sendLoss:(ATBidWinLossResult *)result {
    NSMutableDictionary *infoDict = [ATMentaBaseAdapter getLossInfoResult:result];
    [self.rewardAd sendLossNotificationWithInfo:infoDict];
}

#pragma mark - lazy
- (ATMentaRewardVideoDelegate *)rewardedVideoDelegate{
    if (_rewardedVideoDelegate == nil) {
        _rewardedVideoDelegate = [[ATMentaRewardVideoDelegate alloc] init];
        _rewardedVideoDelegate.adStatusBridge = self.adStatusBridge;
    }
    return _rewardedVideoDelegate;
}

@end
