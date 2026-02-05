//
//  AnyThinkMentaSplashAdapterInland.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import "AnyThinkMentaSplashAdapterInland.h"
#import "ATMentaSplashDelegate.h"

@interface AnyThinkMentaSplashAdapterInland()

@property (nonatomic, strong) MentaUnifiedSplashAd *splashAd;
@property (nonatomic, strong) ATMentaSplashDelegate *splashDelegate;
 
@end


@implementation AnyThinkMentaSplashAdapterInland
  
#pragma mark - load Ad
- (void)loadADWithArgument:(ATAdMediationArgument *)argument {
    dispatch_async(dispatch_get_main_queue(), ^{
        ATMentaParam *param = [[ATMentaParam alloc] initWithDictionary:argument.serverContentDic];
        if (param.slotError) {
            NSLog(@"%@ 广告位Id为空", NSStringFromClass(self.class));
            return;
        }
        
        UIView *containerView = argument.localInfoDic[kATSplashExtraContainerViewKey];
        
        MUSplashConfig *config = MUSplashConfig.new;
        config.slotId = param.slotId;
        config.adSize = UIScreen.mainScreen.bounds.size;
        if (containerView && [containerView isKindOfClass:UIView.class]) {
            config.bottomView = containerView;
        }
        
        self.splashAd = [[MentaUnifiedSplashAd alloc] initWithConfig:config];
        self.splashAd.delegate = self.splashDelegate;
        [self.splashAd loadAd];
    });
}
 
// Ad ready
- (BOOL)adReadySplashWithInfo:(NSDictionary *)info {
    return self.splashAd.isAdValid;
}

// Ad show
- (void)showSplashAdInWindow:(UIWindow *)window inViewController:(UIViewController *)inViewController parameter:(NSDictionary *)parameter {
    [self.splashAd showInWindow:window];
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
    [self.splashAd sendWinNotification];
}

- (void)sendLoss:(ATBidWinLossResult *)result {
    NSMutableDictionary *infoDict = [ATMentaBaseAdapter getLossInfoResult:result];
    [self.splashAd sendLossNotificationWithInfo:infoDict];
}

#pragma mark - lazy
- (ATMentaSplashDelegate *)splashDelegate {
    if (_splashDelegate == nil) {
        _splashDelegate = [[ATMentaSplashDelegate alloc] init];
        _splashDelegate.adStatusBridge = self.adStatusBridge;
    }
    return _splashDelegate;
}

@end
