//
//  HPLSpotlightsView.m
//  SpotlightsDemo
//
//  Created by Paul on 6/20/15.
//  Copyright (c) 2015 Mathemusician.net. All rights reserved.
//

#import "HPLSpotlightsView.h"

@interface HPLSpotlightsView ()

@property (nonatomic, strong) NSMutableArray *spots;

@property (nonatomic) CGFloat maxOffset;

@end


static NSString *const kCenterString     = @"center";
static NSString *const kRadiusString     = @"radius";
static NSString *const kblurRadiusString = @"blur radius";


@implementation HPLSpotlightsView

#pragma mark - Custom Getter / Setter

- (NSMutableArray *)spots
{
    if (!_spots)
        _spots = [NSMutableArray array];

    return _spots;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    [self setNeedsDisplay];
}

#pragma mark - Public instance methods

- (void)addSpotlightAtCenter:(CGPoint)center radius:(CGFloat)radius blurRadius:(CGFloat)blurRadius
{
    // 加入 Array
    NSDictionary *spot = @{ kCenterString     : [NSValue valueWithCGPoint:center],
                            kRadiusString     : @(radius),
                            kblurRadiusString : @(blurRadius) };

    [self.spots addObject:spot];

    // 計算橫移
    CGFloat offset = center.x + radius + blurRadius;
    self.maxOffset = MAX(self.maxOffset, offset);
}

- (void)clearSpotlights
{
    [self.spots removeAllObjects];
    self.maxOffset = 0.0f;
}

#pragma mark - drawRect

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    // 畫背景
    if (self.backgroundFillColor) {
        CGContextSetFillColorWithColor(context, self.backgroundFillColor.CGColor);
        CGContextFillRect(context, CGContextGetClipBoundingBox(context));
    }

    // 畫 spotlights：用圓陰影「打洞」，左右橫移來把本體移出界外，只留下陰影
    if ([self.spots count] == 0)
        return;

    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);

    // 橫移：本體會畫在境左外，而陰影向右被畫在想要的位置
    CGContextTranslateCTM(context, -self.maxOffset, 0);

    for (NSDictionary *spot in self.spots) {
        CGPoint center     = [spot[kCenterString] CGPointValue];
        CGFloat radius     = [spot[kRadiusString] floatValue];
        CGFloat blurRadius = [spot[kblurRadiusString] floatValue];

        // Spotlight's frame rect
        CGRect spotRect = CGRectMake(center.x - radius, center.y - radius, 2 * radius, 2 * radius);

        CGContextSetShadowWithColor(context, CGSizeMake(self.maxOffset, 0), blurRadius, [[UIColor blackColor] CGColor]);

        CGContextFillEllipseInRect(context, spotRect);
    }
    
    CGContextRestoreGState(context);
}


@end
