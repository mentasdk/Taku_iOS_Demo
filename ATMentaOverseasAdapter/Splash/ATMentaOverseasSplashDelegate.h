//
//  ATMentaOverseasSplashDelegate.h
//  ATMentaOverseasAdapter
//
//  Created by vlion on 2026/2/2.
//

#import <Foundation/Foundation.h>
#import "ATMentaOverseasAdapterCommonHeader.h"

@interface ATMentaOverseasSplashDelegate : NSObject<MentaMediationSplashDelegate>

@property (nonatomic, strong, nullable) ATSplashAdStatusBridge *adStatusBridge;

@property (nonatomic, strong, nullable) UIView *splashView;
@property (nonatomic, strong, nullable) UIView *containerView;

@end
 
