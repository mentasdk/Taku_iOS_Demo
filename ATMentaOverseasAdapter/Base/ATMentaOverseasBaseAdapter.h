//
//  ATMentaOverseasBaseAdapter.h
//  ATMentaOverseasAdapter
//
//  Created by vlion on 2026/2/2.
//

#import <Foundation/Foundation.h>
#import "ATMentaOverseasAdapterCommonHeader.h"

@interface ATMentaOverseasBaseAdapter : ATBaseMediationAdapter

//C2S flow needed
+ (NSMutableDictionary *)getLossInfoResult:(ATBidWinLossResult *)winLossResult;

//C2S flow needed
+ (NSMutableDictionary *)getWinInfoResult:(ATBidWinLossResult *)winLossResult;

//C2S flow needed
+ (NSMutableDictionary *)getC2SInfo:(double)ecpm;
 
@end
