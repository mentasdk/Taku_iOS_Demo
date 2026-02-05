//
//  ATMentaInitAdapter.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import "ATMentaInitAdapter.h"
#import <AdSupport/AdSupport.h>
@import MentaUnifiedSDK;

@implementation ATMentaInitAdapter
 
/// Init Ad SDK
/// - Parameter adInitArgument: server info
- (void)initWithInitArgument:(ATAdInitArgument *)adInitArgument {
    dispatch_async(dispatch_get_main_queue(), ^{
        ATMentaParam *param = [[ATMentaParam alloc] initWithDictionary:adInitArgument.serverContentDic];
        if (param.appError) {
            [self notificationNetworkInitFail:param.appError];
            return;
        }
        
        [MUAPI startWithAppID:param.appId appKey:param.appKey finishBlock:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                [self notificationNetworkInitSuccess];
            } else {
                [self notificationNetworkInitFail:param.appError];
            }
        }];
    });
}

#pragma mark - version
- (nullable NSString *)sdkVersion {
    return [MUAPI sdkVersion];
}

- (nullable NSString *)adapterVersion {
    return @"1.1.0";
}

@end
