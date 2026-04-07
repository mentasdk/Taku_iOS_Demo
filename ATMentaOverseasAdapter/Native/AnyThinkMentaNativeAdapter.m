//
//  AnyThinkMentaNativeAdapter.h
//  ATMentaOverseasAdapter
//
//  Created by vlion on 2026/2/2.
//

#import "AnyThinkMentaNativeAdapter.h"
#import "ATMentaOverseasNativeDelegate.h"

@interface AnyThinkMentaNativeAdapter()

@property (nonatomic, strong) MentaMediationNativeExpress *nativeExpressAd;
@property (nonatomic, strong) MentaMediationNativeSelfRender *nativeAd;
@property (nonatomic, strong) ATMentaOverseasNativeDelegate *nativeDelegate;
 
@end


@implementation AnyThinkMentaNativeAdapter

#pragma mark - init
- (void)loadADWithArgument:(ATAdMediationArgument *)argument {
    dispatch_async(dispatch_get_main_queue(), ^{
        ATMentaOverseasParam *param = [[ATMentaOverseasParam alloc] initWithDictionary:argument.serverContentDic];
        if (param.slotError) {
            NSLog(@"%@ 广告位Id为空", NSStringFromClass(self.class));
            return;
        }
        
        CGSize adSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width - 20, 300);
        if ([argument.localInfoDic[kATExtraInfoNativeAdSizeKey] respondsToSelector:@selector(CGSizeValue)]) {
            adSize = [argument.localInfoDic[kATExtraInfoNativeAdSizeKey] CGSizeValue];
        }
        
        self.nativeDelegate.adMediationArgument = argument;
        
        if (param.isExpressAd) {
            // 模板渲染
            self.nativeExpressAd = [[MentaMediationNativeExpress alloc] initWithPlacementID:param.slotId];
            self.nativeExpressAd.delegate = self.nativeDelegate;
            [self.nativeExpressAd loadAd];
        } else {
            // 自渲染
            self.nativeAd = [[MentaMediationNativeSelfRender alloc] initWithPlacementID:param.slotId];
            self.nativeAd.delegate = self.nativeDelegate;
            [self.nativeAd loadAd];
        }
    });
}

#pragma mark - Ad ready
- (BOOL)adReadyInterstitialWithInfo:(NSDictionary *)info {
    BOOL isValid = NO;
    if (self.nativeExpressAd) {
        isValid = self.nativeExpressAd.isAdReady;
    } else if (self.nativeAd) {
        isValid = YES;
    }
    
    return isValid;
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
    if (self.nativeExpressAd) {
        [self.nativeExpressAd sendWinnerNotificationWith:infoDict];
    } else if (self.nativeAd) {
        [self.nativeAd sendWinnerNotificationWith:infoDict];
    }
}

- (void)sendLoss:(ATBidWinLossResult *)result {
    NSMutableDictionary *infoDict = [ATMentaOverseasBaseAdapter getLossInfoResult:result];
    if (self.nativeExpressAd) {
        [self.nativeExpressAd sendLossNotificationWithWinnerPrice:result.winPrice info:infoDict];
    } else if (self.nativeAd) {
        [self.nativeAd sendLossNotificationWithWinnerPrice:result.winPrice info:infoDict];
    }
}
 
#pragma mark - lazy
- (ATMentaOverseasNativeDelegate *)nativeDelegate{
    if (_nativeDelegate == nil) {
        _nativeDelegate = [[ATMentaOverseasNativeDelegate alloc] init];
        _nativeDelegate.adStatusBridge = self.adStatusBridge;
    }
    return _nativeDelegate;
}

@end
