//
//  ATMentaNativeDelegate.h
//  AnyThinkMentaCustomAdapterInland
//
//  Created by vlion on 2026/2/2.
//

#import "ATMentaNativeDelegate.h"
#import "ATMentaNativeObject.h"

@interface ATMentaNativeDelegate()

@end


@implementation ATMentaNativeDelegate

#pragma mark - MentaUnifiedNativeExpressAdDelegate

/// 广告策略服务加载成功
- (void)menta_didFinishLoadingADPolicy:(MentaUnifiedNativeExpressAd *_Nonnull)nativeExpressAd {
    
}

/**
 广告数据回调
 @param unifiedNativeAdDataObjects 广告数据数组
 */
- (void)menta_nativeExpressAdLoaded:(NSArray<MentaUnifiedNativeExpressAdObject *> * _Nullable)unifiedNativeAdDataObjects
                    nativeExpressAd:(MentaUnifiedNativeExpressAd *_Nonnull)nativeExpressAd {
    
}


/**
信息流广告加载失败
@param nativeExpressAd MentaUnifiedNativeExpressAd 实例,
@param error 错误
*/
- (void)menta_nativeExpressAd:(MentaUnifiedNativeExpressAd *_Nonnull)nativeExpressAd
             didFailWithError:(NSError * _Nullable)error
                  description:(NSDictionary *_Nonnull)description {
    [self.adStatusBridge atOnAdLoadFailed:error adExtra:nil];
}

/**
 信息流渲染成功
 @param nativeExpressAd MentaUnifiedNativeExpressAd 实例,
 */
- (void)menta_nativeExpressAdViewRenderSuccess:(MentaUnifiedNativeExpressAd *_Nonnull)nativeExpressAd
                         nativeExpressAdObject:(MentaUnifiedNativeExpressAdObject *_Nonnull)nativeExpressAdObj {
    [self _expressRenderingFeedAds:@[nativeExpressAdObj]];
}

/**
 信息流渲染失败
 @param nativeExpressAd MentaUnifiedNativeExpressAd 实例,
 */
- (void)nativeExpressAdViewRenderFail:(MentaUnifiedNativeExpressAd *_Nonnull)nativeExpressAd
                nativeExpressAdObject:(MentaUnifiedNativeExpressAdObject *_Nonnull)nativeExpressAdObj {
    
}

/**
 广告曝光成功回调
 @param nativeExpressAd MentaUnifiedNativeExpressAd 实例,
 */
- (void)menta_nativeExpressAdViewWillExpose:(MentaUnifiedNativeExpressAd *_Nullable)nativeExpressAd
                      nativeExpressAdObject:(MentaUnifiedNativeExpressAdObject *_Nonnull)nativeExpressAdObj {
    [self.adStatusBridge atOnAdShow:nil];
}

/**
 广告曝光失败回调
 @param nativeExpressAd MentaUnifiedNativeExpressAd 实例
 */
- (void)menta_nativeExpressAd:(MentaUnifiedNativeExpressAd *_Nullable)nativeExpressAd
     didFailToExposeWithError:(nullable NSError *)error {
    [self.adStatusBridge atOnAdShowFailed:error extra:nil];
}

/**
 广告点击回调,
 @param nativeExpressAd MentaUnifiedNativeExpressAd 实例,
 */
- (void)menta_nativeExpressAdViewDidClick:(MentaUnifiedNativeExpressAd *_Nullable)nativeExpressAd
                    nativeExpressAdObject:(MentaUnifiedNativeExpressAdObject *_Nonnull)nativeExpressAdObj {
    [self.adStatusBridge atOnAdClick:nil];
}

/**
 广告点击关闭回调 UI的移除和数据的解绑 需要在该回调中进行
 @param nativeExpressAd MentaUnifiedNativeExpressAd 实例,
 */
- (void)menta_nativeExpressAdDidClose:(MentaUnifiedNativeExpressAd *_Nonnull)nativeExpressAd
                nativeExpressAdObject:(MentaUnifiedNativeExpressAdObject *_Nonnull)nativeExpressAdObj {
    [self.adStatusBridge atOnAdClosed:nil];
}

#pragma mark - MentaUnifiedNativeAdDelegate

/**
 广告数据回调

 @param unifiedNativeAdDataObjects 广告数据数组
 */
- (void)menta_nativeAdLoaded:(NSArray<MentaNativeObject *> * _Nullable)unifiedNativeAdDataObjects nativeAd:(MentaUnifiedNativeAd *_Nullable)nativeAd {
    [self _selfRenderingFeedAds:unifiedNativeAdDataObjects];
}

/// 信息流自渲染加载失败
- (void)menta_nativeAd:(MentaUnifiedNativeAd *_Nonnull)nativeAd didFailWithError:(NSError * _Nullable)error description:(NSDictionary *_Nonnull)description {
    [self.adStatusBridge atOnAdLoadFailed:error adExtra:nil];
}

/**
 广告曝光成功回调
 @param nativeAd MentaUnifiedNativeAd 实例,
 @param adView 广告View
 */
- (void)menta_nativeAdViewWillExpose:(MentaUnifiedNativeAd *_Nullable)nativeAd adView:(UIView<MentaNativeAdViewProtocol> *_Nonnull)adView {
    [self.adStatusBridge atOnAdShow:nil];
}

/**
 广告曝光失败回调
 @param nativeAd MentaUnifiedNativeAd 实例
 @param error 错误
 */
- (void)menta_nativeAd:(MentaUnifiedNativeAd *_Nullable)nativeAd didFailToExposeWithError:(nullable NSError *)error {
    [self.adStatusBridge atOnAdShowFailed:error extra:nil];
}

/**
 广告点击回调,

 @param nativeAd MentaUnifiedNativeAd 实例,
 */
- (void)menta_nativeAdViewDidClick:(MentaUnifiedNativeAd *_Nullable)nativeAd adView:(UIView<MentaNativeAdViewProtocol> *_Nullable)adView {
    [self.adStatusBridge atOnAdClick:nil];
}

/**
 广告点击关闭回调 UI的移除和数据的解绑 需要在该回调中进行

 @param nativeAd MentaUnifiedNativeAd 实例,
 */
- (void)menta_nativeAdDidClose:(MentaUnifiedNativeAd *_Nonnull)nativeAd adView:(UIView<MentaNativeAdViewProtocol> *_Nullable)adView {
    [self.adStatusBridge atOnAdClosed:nil];
}

/**
 广告详情页面即将展示回调, 当广告位落地页广告时会触发

 @param nativeAd MentaUnifiedNativeAd 实例,
 */
- (void)menta_nativeAdDetailViewWillPresentScreen:(MentaUnifiedNativeAd *_Nullable)nativeAd adView:(UIView<MentaNativeAdViewProtocol> *_Nonnull)adView {
    
}

/**
 广告详情页关闭回调,即落地页关闭回调, 当关闭弹出的落地页时 触发

 @param nativeAd MentaUnifiedNativeAd 实例,
 */
- (void)menta_nativeAdDetailViewClosed:(MentaUnifiedNativeAd *_Nullable)nativeAd adView:(UIView<MentaNativeAdViewProtocol> *_Nonnull)adView {
    [self.adStatusBridge atOnAdDetailClosed:nil];
}

/**
 信息流自渲染视频播放结束

 @param nativeAd MentaUnifiedNativeAd 实例,
 */
- (void)menta_nativeAdDidPlayFinished:(MentaUnifiedNativeAd *_Nullable)nativeAd adView:(UIView<MentaNativeAdViewProtocol> *_Nonnull)adView {
    [self.adStatusBridge atOnAdVideoEnd:nil];
}

/**
 信息流自渲染视频播放失败

 @param nativeAd MentaUnifiedNativeAd 实例,
 */
- (void)menta_nativeAdDidPlayFailed:(MentaUnifiedNativeAd *_Nullable)nativeAd adView:(UIView<MentaNativeAdViewProtocol> *_Nonnull)adView error:(NSError *_Nullable)error {
    [self.adStatusBridge atOnAdDidFailToPlayVideo:error extra:nil];
}

#pragma mark - 自定义方法

- (void)_selfRenderingFeedAds:(NSArray <MentaNativeObject *> *)feedAds {
    NSMutableArray *offerArray = [NSMutableArray array];
    NSDictionary *infoDic = [ATMentaBaseAdapter getC2SInfo:feedAds.firstObject.dataObject.price.integerValue];
    
    [feedAds enumerateObjectsUsingBlock:^(MentaNativeObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MentaNativeAdDataObject *ad = obj.dataObject;
        
        ATMentaNativeObject *nativeObject = [[ATMentaNativeObject alloc] init];
        nativeObject.feedAdMetaad = obj;
        nativeObject.nativeAdRenderType = ATNativeAdRenderSelfRender;
        nativeObject.title = ad.title;
        nativeObject.mainText = ad.desc;
        nativeObject.ctaText = nil;
        nativeObject.rating = 0;
        nativeObject.appPrice = 0;
        nativeObject.videoDuration = ad.videoDuration;
        nativeObject.iconUrl = ad.iconUrl;
        
        if (ad.materialList && ad.materialList.count) {
            MentaNativeAdMaterialObject *material = ad.materialList.firstObject;
            nativeObject.mainImageWidth = material.materialWidth;
            nativeObject.mainImageHeight = material.materialHeight;
            nativeObject.imageUrl = material.materialUrl;
            
            NSMutableArray *imageList = [NSMutableArray arrayWithCapacity:ad.materialList.count];
            for (MentaNativeAdMaterialObject *item in ad.materialList) {
                if (item.materialUrl) {
                    [imageList addObject:item.materialUrl];
                }
            }
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
        if (ad.isVideo && obj.nativeAdView.mentaMediaView) {
            //设置为视频素材
            nativeObject.isVideoContents = YES;
            [obj.nativeAdView.mentaMediaView muteEnable:([self.adMediationArgument.serverContentDic[@"video_muted"] intValue] == 0 ? NO : YES)];
            
            //获取自定义广告平台 SDK的媒体视图并赋值给我们
            nativeObject.mediaView = obj.nativeAdView.mentaMediaView;
        }
        
        [offerArray addObject:nativeObject];
    }];
    
    [self.adStatusBridge atOnNativeAdLoadedArray:offerArray adExtra:infoDic];
}

- (void)_expressRenderingFeedAds:(NSArray <MentaUnifiedNativeExpressAdObject *> *)feedAds {
    NSMutableArray *offerArray = [NSMutableArray array];
    NSDictionary *infoDic = [ATMentaBaseAdapter getC2SInfo:feedAds.firstObject.price.integerValue];
    
    [feedAds enumerateObjectsUsingBlock:^(MentaUnifiedNativeExpressAdObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *nativeAdView = obj.expressView;
        
        ATMentaNativeObject *nativeObject = [[ATMentaNativeObject alloc] init];
        nativeObject.feedAdModel = obj;
        nativeObject.templateView = nativeAdView;
        nativeObject.nativeAdRenderType = ATNativeAdRenderExpress;
        nativeObject.nativeExpressAdViewWidth = nativeAdView.frame.size.width;
        nativeObject.nativeExpressAdViewHeight = nativeAdView.frame.size.height;
        //nativeObject.isVideoContents = obj.isVideo;
        
        [offerArray addObject:nativeObject];
    }];
    
    [self.adStatusBridge atOnNativeAdLoadedArray:offerArray adExtra:infoDic];
}

@end
