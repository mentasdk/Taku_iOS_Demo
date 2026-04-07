//
//  ATMentaOverseasRewardVideoDelegate.h
//  ATMentaOverseasAdapter
//
//  Created by vlion on 2026/2/2.
//

#import <Foundation/Foundation.h>
#import "ATMentaOverseasAdapterCommonHeader.h"

@interface ATMentaOverseasRewardVideoDelegate : NSObject<MentaMediationRewardVideoDelegate>

@property (nonatomic, strong) ATRewardedAdStatusBridge * adStatusBridge;

@end
