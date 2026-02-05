//
//  AnyThinkMentaNativeAdapterInland.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import "AnyThinkMentaNativeAdapterInland.h"
#import "ATMentaNativeDelegate.h"

@interface AnyThinkMentaNativeAdapterInland()

@property (nonatomic, strong) MentaUnifiedNativeExpressAd *nativeExpressAd;
@property (nonatomic, strong) MentaUnifiedNativeAd *nativeAd;
@property (nonatomic, strong) ATMentaNativeDelegate *nativeDelegate;
 
@end


@implementation AnyThinkMentaNativeAdapterInland

#pragma mark - init
- (void)loadADWithArgument:(ATAdMediationArgument *)argument {
    dispatch_async(dispatch_get_main_queue(), ^{
        ATMentaParam *param = [[ATMentaParam alloc] initWithDictionary:argument.serverContentDic];
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
            MUNativeExpressConfig *config = [[MUNativeExpressConfig alloc] init];
            config.adSize = adSize;
            config.slotId = param.slotId;
            config.viewController = argument.viewController;
            config.materialFillMode = MentaNativeExpressAdMaterialFillMode_ScaleAspectFill;

            self.nativeExpressAd = [[MentaUnifiedNativeExpressAd alloc] initWithConfig:config];
            self.nativeExpressAd.delegate = self.nativeDelegate;
            [self.nativeExpressAd loadAd];
        } else {
            // 自渲染
            MUNativeConfig *config = [[MUNativeConfig alloc] init];
            config.adSize = adSize;
            config.slotId = param.slotId;
            config.viewController = argument.viewController;
            
            self.nativeAd = [[MentaUnifiedNativeAd alloc] initWithConfig:config];
            self.nativeAd.delegate = self.nativeDelegate;
            [self.nativeAd loadAd];
        }
    });
}

#pragma mark - Ad ready
- (BOOL)adReadyInterstitialWithInfo:(NSDictionary *)info {
    BOOL isValid = NO;
    if (self.nativeExpressAd) {
        isValid = self.nativeExpressAd.isAdValid;
    } else if (self.nativeAd) {
        isValid = self.nativeAd.isAdValid;
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
    if (self.nativeExpressAd) {
        [self.nativeExpressAd sendWinNotification];
    } else if (self.nativeAd) {
        [self.nativeAd sendWinNotification];
    }
}

- (void)sendLoss:(ATBidWinLossResult *)result {
    NSMutableDictionary *infoDict = [ATMentaBaseAdapter getLossInfoResult:result];
    if (self.nativeExpressAd) {
        [self.nativeExpressAd sendLossNotificationWithInfo:infoDict];
    } else if (self.nativeAd) {
        [self.nativeAd sendLossNotificationWithInfo:infoDict];
    }
}
 
#pragma mark - lazy
- (ATMentaNativeDelegate *)nativeDelegate{
    if (_nativeDelegate == nil) {
        _nativeDelegate = [[ATMentaNativeDelegate alloc] init];
        _nativeDelegate.adStatusBridge = self.adStatusBridge;
    }
    return _nativeDelegate;
}

@end
