//
//  ATMentaNativeDelegate.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import <Foundation/Foundation.h>
#import "ATMentaAdapterCommonHeader.h"

@interface ATMentaNativeDelegate : NSObject<MentaUnifiedNativeExpressAdDelegate, MentaUnifiedNativeAdDelegate>

@property (nonatomic, strong) ATNativeAdStatusBridge *adStatusBridge;
@property (nonatomic, strong) ATAdMediationArgument *adMediationArgument;

@end
