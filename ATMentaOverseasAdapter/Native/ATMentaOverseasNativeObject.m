//
//  ATMentaOverseasNativeObject.h
//  ATMentaOverseasAdapter
//
//  Created by vlion on 2026/2/2.
//

#import "ATMentaOverseasNativeObject.h"

@interface ATMentaOverseasNativeObject()

@property (nonatomic, strong) ATNativeAdRenderConfig *configuration;

@end

@implementation ATMentaOverseasNativeObject

#pragma mark - 推荐实现，释放资源
- (void)dealloc {
    
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
    if (self.feedAdMetaad && self.feedAdMetaad.selfRenderView) {
        [self.feedAdMetaad.selfRenderView menta_registerClickableViews:clickableViews
                                                        closeableViews:@[registerArgument.dislikeButton]];
        
        
        UIView *adView = self.feedAdMetaad.selfRenderView;
        if (!adView) {
            return;
        }
        
        adView.userInteractionEnabled = YES;
        adView.frame = container.bounds;
        [container insertSubview:adView atIndex:0];
    }
}

@end
