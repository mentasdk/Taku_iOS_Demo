//
//  AnyThinkMentaBannerAdapter.h
//  ATMentaOverseasAdapter
//
//  Created by vlion on 2026/2/2.
//

#import "AnyThinkMentaBannerAdapter.h"
#import "ATMentaOverseasBannerDelegate.h"

@interface AnyThinkMentaBannerAdapter()

@property (nonatomic, strong) MentaMediationBanner *bannerAd;
@property (nonatomic, strong) ATMentaOverseasBannerDelegate * bannerDelegate;

@end


@implementation AnyThinkMentaBannerAdapter

#pragma mark - Ad load
- (void)loadADWithArgument:(ATAdMediationArgument *)argument {
    ATMentaOverseasParam *param = [[ATMentaOverseasParam alloc] initWithDictionary:argument.serverContentDic];
    if (param.slotError) {
        NSLog(@"%@ 广告位Id为空", NSStringFromClass(self.class));
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CGSize bannerSize = CGSizeMake(320, 50);
        if (!CGSizeEqualToSize(argument.bannerSize, CGSizeZero)) {
            bannerSize = argument.bannerSize;
        }
        
        self.bannerAd = [[MentaMediationBanner alloc] initWithPlacementID:param.slotId];
        self.bannerAd.delegate = self.bannerDelegate;
        [self.bannerAd loadAd];
    });
}

#pragma mark - Ad ready
- (BOOL)adReadyInterstitialWithInfo:(NSDictionary *)info {
    return self.bannerAd.isAdReady;
}

// Ad show
- (BOOL)callShowBannerView {
    return YES;
}

- (void)showBannerView:(UIView *)bannerView inView:(UIView *)view inViewController:(UIViewController *)viewController {
    if (bannerView && view) {
        [view addSubview:bannerView];
    }
}

#pragma mark - lazy
- (ATMentaOverseasBannerDelegate *)bannerDelegate{
    if (_bannerDelegate == nil) {
        _bannerDelegate = [[ATMentaOverseasBannerDelegate alloc] init];
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
    NSMutableDictionary *infoDict = [ATMentaOverseasBaseAdapter getWinInfoResult:result];
    [self.bannerAd sendWinnerNotificationWith:infoDict];
}

- (void)sendLoss:(ATBidWinLossResult *)result {
    NSMutableDictionary *infoDict = [ATMentaOverseasBaseAdapter getLossInfoResult:result];
    [self.bannerAd sendLossNotificationWithWinnerPrice:result.winPrice info:infoDict];
}

@end
