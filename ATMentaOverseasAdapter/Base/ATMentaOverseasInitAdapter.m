//
//  ATMentaOverseasInitAdapter.h
//  ATMentaOverseasAdapter
//
//  Created by vlion on 2026/2/2.
//

#import "ATMentaOverseasInitAdapter.h"
#import <AdSupport/AdSupport.h>
@import MentaVlionGlobal;

@implementation ATMentaOverseasInitAdapter
 
/// Init Ad SDK
/// - Parameter adInitArgument: server info
- (void)initWithInitArgument:(ATAdInitArgument *)adInitArgument {
    dispatch_async(dispatch_get_main_queue(), ^{
        ATMentaOverseasParam *param = [[ATMentaOverseasParam alloc] initWithDictionary:adInitArgument.serverContentDic];
        if (param.appError) {
            [self notificationNetworkInitFail:param.appError];
            return;
        }
        
        [MentaAdSDK.shared startWithAppID:param.appId
                                   appKey:param.appKey
                              finishBlock:^(BOOL success, NSError * _Nullable error) {
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
    return [MentaAdSDK.shared sdkVersion];
}

- (nullable NSString *)adapterVersion {
    return @"7.01.02";
}

@end
