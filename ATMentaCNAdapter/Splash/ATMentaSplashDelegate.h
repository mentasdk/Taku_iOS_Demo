//
//  ATMentaSplashDelegate.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import <Foundation/Foundation.h>
#import "ATMentaAdapterCommonHeader.h"

@interface ATMentaSplashDelegate : NSObject<MentaUnifiedSplashAdDelegate>

@property (nonatomic, strong, nullable) ATSplashAdStatusBridge *adStatusBridge;

@property (nonatomic, strong, nullable) UIView *splashView;
@property (nonatomic, strong, nullable) UIView *containerView;

@property (nonatomic, assign) NSInteger ecpm;

@end
 
