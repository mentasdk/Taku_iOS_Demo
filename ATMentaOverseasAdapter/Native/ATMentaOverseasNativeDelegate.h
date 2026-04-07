//
//  ATMentaOverseasNativeDelegate.h
//  ATMentaOverseasAdapter
//
//  Created by vlion on 2026/2/2.
//

#import <Foundation/Foundation.h>
#import "ATMentaOverseasAdapterCommonHeader.h"

@interface ATMentaOverseasNativeDelegate : NSObject<MentaMediationNativeExpressDelegate, MentaNativeSelfRenderDelegate>

@property (nonatomic, strong) ATNativeAdStatusBridge *adStatusBridge;
@property (nonatomic, strong) ATAdMediationArgument *adMediationArgument;

@end
