//
//  HPLSpotlightsView.h
//  SpotlightsDemo
//
//  Created by Paul on 6/20/15.
//  Copyright (c) 2015 Mathemusician.net. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 *  此 View 可在背景上用圓形陰影「打洞」，做出聚光燈效果
 *
 *  用法：Init with frame 後，設 backgroundFillColor 後加入 spotlights
 *
 *  Reference: http://stackoverflow.com/questions/17699510/how-to-use-quartz-to-do-the-spotlight-effect
 */
@interface HPLSpotlightsView : UIView

/**
 *  背景顏色，一般為半透明
 */
@property (nonatomic, strong) UIColor *backgroundFillColor;

/**
 *  新增一塊 spotlight
 *
 *  @param center     Spotlight 中心位置
 *  @param radius     Spotlight 圓圈大小
 *  @param blurRadius Spotlight 邊緣模糊寬度
 */
- (void)addSpotlightAtCenter:(CGPoint)center radius:(CGFloat)radius blurRadius:(CGFloat)blurRadius;

/**
 *  移除所有 spotlights
 */
- (void)clearSpotlights;

@end
