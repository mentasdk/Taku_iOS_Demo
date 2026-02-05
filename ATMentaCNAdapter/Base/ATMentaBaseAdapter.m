//
//  ATMentaBaseAdapter.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import "ATMentaBaseAdapter.h"

@implementation ATMentaBaseAdapter

#pragma mark - adapter init class name define
- (Class)initializeClassName {
    return [ATMentaInitAdapter class];
}

#pragma mark - tools
+ (NSMutableDictionary *)getC2SInfo:(NSInteger)ecpm {
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
    
    NSString *priceStr = [NSString stringWithFormat:@"%ld", ecpm];
    if ([priceStr doubleValue] < 0) {
        priceStr = @"0";
    }
    
    [infoDic AT_setDictValue:priceStr key:ATAdSendC2SBidPriceKey];
    [infoDic AT_setDictValue:@(ATBiddingCurrencyTypeCNYCents) key:ATAdSendC2SCurrencyTypeKey];

    return infoDic;
}

+ (NSMutableDictionary *)getLossInfoResult:(ATBidWinLossResult *)winLossResult {
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
    [infoDic AT_setDictValue:winLossResult.winPrice key:MU_M_L_WIN_PRICE];
    //竞败原因 (1：竞争力不足 101：未参与竞价 10001：其他)
    [infoDic AT_setDictValue:@(winLossResult.lossReasonType).stringValue key:@"lossReason"];
    //竞胜方渠道ID (1：美数其他非bidding广告位 2：第三方ADN 3：自售广告主 4：美数其他bidding广告位)
    [infoDic AT_setDictValue:(winLossResult.userInfoDic[kATWinLossAdWinnerNetworkFirmID] ?: @"") key:@"winADN"];
    return infoDic;
}

+ (NSMutableDictionary *)getWinInfoResult:(ATBidWinLossResult *)winLossResult {
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
    //通常需要回传二价
    [infoDic AT_setDictValue:winLossResult.secondPrice key:@"secondPrice"];
    return infoDic;
}

@end
