//
//  ATMentaOverseasBannerDelegate.h
//  ATMentaOverseasAdapter
//
//  Created by vlion on 2026/2/2.
//

#import <Foundation/Foundation.h>
#import "ATMentaOverseasAdapterCommonHeader.h"

@interface ATMentaOverseasBannerDelegate : NSObject<MentaMediationBannerDelegate>

@property (nonatomic, strong, nonnull) ATBannerAdStatusBridge *adStatusBridge;

@end
 
