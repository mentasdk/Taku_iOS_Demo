//
//  ATMentaOverseasNativeDelegate.h
//  ATMentaOverseasAdapter
//
//  Created by vlion on 2026/2/2.
//

#import "ATMentaOverseasNativeDelegate.h"
#import "ATMentaOverseasNativeObject.h"

@interface ATMentaOverseasNativeDelegate()

@end


@implementation ATMentaOverseasNativeDelegate

#pragma mark - MentaMediationNativeExpressDelegate

// 广告素材加载成功
- (void)menta_nativeExpressAdDidLoad:(MentaMediationNativeExpress *)nativeExpress {
    
}

// 广告素材加载失败
- (void)menta_nativeExpressAdLoadFailedWithError:(NSError *)error nativeExpress:(MentaMediationNativeExpress *)nativeExpress {
    [self.adStatusBridge atOnAdLoadFailed:error adExtra:nil];
}

// 广告素材渲染成功
// 此时可以获取 ecpm
- (void)menta_nativeExpressAdRenderSuccess:(MentaMediationNativeExpress *)nativeExpress nativeExpressView:(UIView *)nativeExpressView {
    [self _expressRenderingFeedAds:@[nativeExpressView] price:(nativeExpress.eCPM ? nativeExpress.eCPM.doubleValue : 0)];
}

// 广告素材渲染失败
- (void)menta_nativeExpressAdRenderFailureWithError:(NSError *)error nativeExpress:(MentaMediationNativeExpress *)nativeExpress {
    
}

// 广告曝光
- (void)menta_nativeExpressAdExposed:(MentaMediationNativeExpress *)nativeExpress {
    [self.adStatusBridge atOnAdShow:nil];
}

// 广告点击
- (void)menta_nativeExpressrAdClicked:(MentaMediationNativeExpress *)nativeExpress {
    [self.adStatusBridge atOnAdClick:nil];
}

// 广告关闭
-(void)menta_nativeExpressAdClosed:(MentaMediationNativeExpress *)nativeExpress {
    [self.adStatusBridge atOnAdClosed:nil];
}

#pragma mark - MentaNativeSelfRenderDelegate

- (void)menta_nativeSelfRenderLoadSuccess:(NSArray<MentaMediationNativeSelfRenderModel *> *)nativeSelfRenderAds
                         nativeSelfRender:(MentaMediationNativeSelfRender *)nativeSelfRender {
    [self _selfRenderingFeedAds:nativeSelfRenderAds];
}

- (void)menta_nativeSelfRenderLoadFailure:(NSError *)error
                         nativeSelfRender:(MentaMediationNativeSelfRender *)nativeSelfRender {
    [self.adStatusBridge atOnAdLoadFailed:error adExtra:nil];
}

- (void)menta_nativeSelfRenderViewExposed {
    [self.adStatusBridge atOnAdShow:nil];
}

- (void)menta_nativeSelfRenderViewClicked {
    [self.adStatusBridge atOnAdClick:nil];
}

- (void)menta_nativeSelfRenderViewClosed {
    [self.adStatusBridge atOnAdClosed:nil];
}

#pragma mark - 自定义方法

- (void)_selfRenderingFeedAds:(NSArray <MentaMediationNativeSelfRenderModel *> *)feedAds {
    NSMutableArray *offerArray = [NSMutableArray array];
    NSDictionary *infoDic = [ATMentaOverseasBaseAdapter getC2SInfo:(feedAds.firstObject.eCPM ? feedAds.firstObject.eCPM.doubleValue : 0)];
    
    [feedAds enumerateObjectsUsingBlock:^(MentaMediationNativeSelfRenderModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ATMentaOverseasNativeObject *nativeObject = [[ATMentaOverseasNativeObject alloc] init];
        nativeObject.feedAdMetaad = obj;
        nativeObject.nativeAdRenderType = ATNativeAdRenderSelfRender;
        nativeObject.title = obj.title;
        nativeObject.mainText = obj.des;
        nativeObject.ctaText = nil;
        nativeObject.rating = 0;
        nativeObject.appPrice = 0;
        nativeObject.iconUrl = obj.iconURL;
        nativeObject.imageUrl = obj.materialURL;
        
        if (obj.materialURL) {
            NSMutableArray *imageList = [NSMutableArray arrayWithCapacity:1];
            [imageList addObject:obj.materialURL];
            nativeObject.imageList = imageList;
        }
        
        //设置一个期望的默认值
        CGRect mediaViewFrame = CGRectMake(0,
                                           0,
                                           UIScreen.mainScreen.bounds.size.width,
                                           100);
        
        //取开发者load的时候，通过kATExtraInfoMediaViewFrameKey传入的
        NSValue *mediaViewFrameV = self.adMediationArgument.localInfoDic[kATExtraInfoMediaViewFrameKey];
        
        if ([mediaViewFrameV respondsToSelector:@selector(CGRectValue)]) {
            mediaViewFrame = [mediaViewFrameV CGRectValue];
        }
        
        //根据自定义广告平台SDK素材类型，设置是否是视频素材
        if (obj.isVideo && obj.selfRenderView && obj.selfRenderView.mediaView) {
            //设置为视频素材
            nativeObject.isVideoContents = YES;
            nativeObject.videoDuration = obj.selfRenderView.mediaView.videoDuration;
            [obj.selfRenderView.mediaView muteEnable:([self.adMediationArgument.serverContentDic[@"video_muted"] intValue] == 0 ? NO : YES)];
            
            //获取自定义广告平台 SDK的媒体视图并赋值给我们
            nativeObject.mediaView = obj.selfRenderView.mediaView;
        }
        
        [offerArray addObject:nativeObject];
    }];
    
    [self.adStatusBridge atOnNativeAdLoadedArray:offerArray adExtra:infoDic];
}

- (void)_expressRenderingFeedAds:(NSArray<UIView *> *)feedAds price:(double)price {
    NSMutableArray *offerArray = [NSMutableArray array];
    NSDictionary *infoDic = [ATMentaOverseasBaseAdapter getC2SInfo:price];
    
    [feedAds enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ATMentaOverseasNativeObject *nativeObject = [[ATMentaOverseasNativeObject alloc] init];
        nativeObject.templateView = obj;
        nativeObject.nativeAdRenderType = ATNativeAdRenderExpress;
        nativeObject.nativeExpressAdViewWidth = obj.frame.size.width;
        nativeObject.nativeExpressAdViewHeight = obj.frame.size.height;
        //nativeObject.isVideoContents = obj.isVideo;
        
        [offerArray addObject:nativeObject];
    }];
    
    [self.adStatusBridge atOnNativeAdLoadedArray:offerArray adExtra:infoDic];
}

@end
