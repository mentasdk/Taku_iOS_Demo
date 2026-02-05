//
//  ATMentaParam.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATMentaParam : NSObject

@property (nullable, nonatomic, copy, readonly) NSString *appId;
@property (nullable, nonatomic, copy, readonly) NSString *appKey;
@property (nullable, nonatomic, copy, readonly) NSString *slotId;
@property (nonatomic, assign, readonly) BOOL isExpressAd;

- (instancetype)initWithDictionary:(NSDictionary *)info;
- (nullable NSError *)appError;
- (nullable NSError *)slotError;

@end

NS_ASSUME_NONNULL_END
