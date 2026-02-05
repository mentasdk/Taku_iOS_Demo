//
//  ATMentaInterstitialDelegate.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import <Foundation/Foundation.h>
#import "ATMentaAdapterCommonHeader.h"

@interface ATMentaInterstitialDelegate : NSObject<MentaUnifiedInterstitialAdDelegate>

@property (nonatomic, strong, nonnull) ATInterstitialAdStatusBridge *adStatusBridge;

@property (nonatomic, assign) NSInteger ecpm;

@end
