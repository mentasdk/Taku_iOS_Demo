//
//  AnyThinkMentaBannerAdapterInland.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import "AnyThinkMentaBannerAdapterInland.h"
#import "ATMentaBannerDelegate.h"

@interface AnyThinkMentaBannerAdapterInland()

@property (nonatomic, strong) MentaUnifiedBannerAd *bannerAd;
@property (nonatomic, strong) ATMentaBannerDelegate * bannerDelegate;

@end


@implementation AnyThinkMentaBannerAdapterInland

#pragma mark - Ad load
- (void)loadADWithArgument:(ATAdMediationArgument *)argument {
    ATMentaParam *param = [[ATMentaParam alloc] initWithDictionary:argument.serverContentDic];
    if (param.slotError) {
        NSLog(@"%@ 广告位Id为空", NSStringFromClass(self.class));
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CGSize bannerSize = CGSizeMake(320, 50);
        if (!CGSizeEqualToSize(argument.bannerSize, CGSizeZero)) {
            bannerSize = argument.bannerSize;
        }
        
        MUBannerConfig *config = [[MUBannerConfig alloc] init];
        config.adSize = bannerSize;
        config.slotId = param.slotId;

        self.bannerAd = [[MentaUnifiedBannerAd alloc] initWithConfig:config];
        self.bannerAd.delegate = self.bannerDelegate;
        [self.bannerAd loadAd];
    });
}

#pragma mark - Ad ready
- (BOOL)adReadyInterstitialWithInfo:(NSDictionary *)info {
    return self.bannerAd.isAdValid;
}

// Ad show
- (BOOL)callShowBannerView {
    return YES;
}

- (void)showBannerView:(UIView *)bannerView inView:(UIView *)view inViewController:(UIViewController *)viewController {
    [self.bannerAd showInContainer:view];
}

#pragma mark - lazy
- (ATMentaBannerDelegate *)bannerDelegate{
    if (_bannerDelegate == nil) {
        _bannerDelegate = [[ATMentaBannerDelegate alloc] init];
        _bannerDelegate.adStatusBridge = self.adStatusBridge;
    }
    return _bannerDelegate;
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
    [self.bannerAd sendWinNotification];
}

- (void)sendLoss:(ATBidWinLossResult *)result {
    NSMutableDictionary *infoDict = [ATMentaBaseAdapter getLossInfoResult:result];
    [self.bannerAd sendLossNotificationWithInfo:infoDict];
}

@end
