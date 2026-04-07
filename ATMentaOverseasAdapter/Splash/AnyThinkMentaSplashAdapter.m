//
//  AnyThinkMentaSplashAdapterInland.h
//  ATMentaOverseasAdapter
//
//  Created by vlion on 2026/2/2.
//

#import "AnyThinkMentaSplashAdapter.h"
#import "ATMentaOverseasSplashDelegate.h"

@interface AnyThinkMentaSplashAdapter()

@property (nonatomic, strong) MentaMediationSplash *splashAd;
@property (nonatomic, strong) ATMentaOverseasSplashDelegate *splashDelegate;
 
@end


@implementation AnyThinkMentaSplashAdapter
  
#pragma mark - load Ad
- (void)loadADWithArgument:(ATAdMediationArgument *)argument {
    dispatch_async(dispatch_get_main_queue(), ^{
        ATMentaOverseasParam *param = [[ATMentaOverseasParam alloc] initWithDictionary:argument.serverContentDic];
        if (param.slotError) {
            NSLog(@"%@ 广告位Id为空", NSStringFromClass(self.class));
            return;
        }
        
        self.splashAd = [[MentaMediationSplash alloc] initWithPlacementID:param.slotId];
        self.splashAd.delegate = self.splashDelegate;
        [self.splashAd loadSplashAd];
    });
}
 
// Ad ready
- (BOOL)adReadySplashWithInfo:(NSDictionary *)info {
    return self.splashAd.isAdReady;
}

// Ad show
- (void)showSplashAdInWindow:(UIWindow *)window inViewController:(UIViewController *)inViewController parameter:(NSDictionary *)parameter {
    [self.splashAd showAdInWindow:window];
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
    [self.splashAd sendWinnerNotificationWith:infoDict];
}

- (void)sendLoss:(ATBidWinLossResult *)result {
    NSMutableDictionary *infoDict = [ATMentaOverseasBaseAdapter getLossInfoResult:result];
    [self.splashAd sendLossNotificationWithWinnerPrice:result.winPrice info:infoDict];
}

#pragma mark - lazy
- (ATMentaOverseasSplashDelegate *)splashDelegate {
    if (_splashDelegate == nil) {
        _splashDelegate = [[ATMentaOverseasSplashDelegate alloc] init];
        _splashDelegate.adStatusBridge = self.adStatusBridge;
    }
    return _splashDelegate;
}

@end
