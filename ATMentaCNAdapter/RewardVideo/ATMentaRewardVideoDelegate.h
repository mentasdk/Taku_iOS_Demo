//
//  ATMentaRewardVideoDelegate.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import <Foundation/Foundation.h>
#import "ATMentaAdapterCommonHeader.h"

@interface ATMentaRewardVideoDelegate : NSObject<MentaUnifiedRewardVideoDelegate>

@property (nonatomic, strong) ATRewardedAdStatusBridge * adStatusBridge;

@property (nonatomic, assign) NSInteger ecpm;

@end
