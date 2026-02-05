//
//  ATMentaNativeObject.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import "ATMentaNativeObject.h"

@interface ATMentaNativeObject()

@property (nonatomic, strong) ATNativeAdRenderConfig *configuration;

@end

@implementation ATMentaNativeObject

#pragma mark - 推荐实现，释放资源
- (void)dealloc {
    if (self.feedAdMetaad) {
        [self.feedAdMetaad destoryNativeAdView];
    }
}

#pragma mark - 必须实现，获取配置并设置给自定义广告平台 SDK
- (void)setNativeADConfiguration:(ATNativeAdRenderConfig *)configuration {
    self.configuration = configuration;
}

#pragma mark - 必须实现，根据渲染类型注册容器
- (void)registerClickableViews:(NSArray<UIView *> *)clickableViews withContainer:(UIView *)container registerArgument:(ATNativeRegisterArgument *)registerArgument {
    if (self.nativeAdRenderType == ATNativeAdRenderExpress) {
        [self templateRender];
        return;
    }
    [self slefRenderRenderClickableViews:clickableViews withContainer:container registerArgument:registerArgument];
}

#pragma mark - 模板
- (void)templateRender {
    
}

#pragma mark - 自渲染
- (void)slefRenderRenderClickableViews:(NSArray<UIView *> *)clickableViews withContainer:(UIView *)container registerArgument:(ATNativeRegisterArgument *)registerArgument {
    if (self.feedAdMetaad) {
        [self.feedAdMetaad registerClickableViews:clickableViews
                                   closeableViews:@[registerArgument.dislikeButton]];
        
        
        UIView *adView = self.feedAdMetaad.nativeAdView;
        if (!adView) {
            return;
        }
        
        adView.userInteractionEnabled = YES;
        adView.frame = container.bounds;
        [container insertSubview:adView atIndex:0];
    }
}

@end
