//
//  ATMentaBannerDelegate.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import <Foundation/Foundation.h>
#import "ATMentaAdapterCommonHeader.h"

@interface ATMentaBannerDelegate : NSObject<MentaUnifiedBannerAdDelegate>

@property (nonatomic, strong, nonnull) ATBannerAdStatusBridge *adStatusBridge;

@property (nonatomic, assign) NSInteger ecpm;

@end
 
