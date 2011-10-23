//
//  MKGraphView.m
//  MKKit
//
//  Created by Matthew King on 9/3/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKBarGraphView.h"

void drawAxisLines(CGContextRef context, CGRect rect, bool xAxis, bool yAxis);
void drawXAxisTitle(CGContextRef context, CGRect rect, CFStringRef title);
void drawYAxisTitle(CGContextRef context, CGRect rect, CFStringRef title);
void drawYAxisLabels(CGContextRef context, CGRect rect, MKGraphScale scale);

void drawLimitLine(CGContextRef context, CGRect rect, CFStringRef label, CGColorRef color, float value, float max);

void drawVerticalBar(CGContextRef context, CGRect rect, CGColorRef color);

@implementation MKBarGraphView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        MKGraphViewFlags.hasXAxis = YES;
        MKGraphViewFlags.hasYAxis = YES;
        MKGraphViewFlags.hasLimitLine = NO;
        
        hasGraphData = NO;
    }
    return self;
}

#pragma mark - Accessor Methods

- (void)setXAxisTitle:(NSString *)title {
    MKGraphViewFlags.hasXAxisTitle = YES;
    mXAxisTitle = (CFStringRef)title;
}

- (void)setYAxisTitle:(NSString *)title {
    MKGraphViewFlags.hasYAxisTitle = YES;
    mYAxisTitle = (CFStringRef)title;
}

- (void)setLimitLine:(MKLimitLine)limitLine {
    MKGraphViewFlags.hasLimitLine = YES;
    mLimit = limitLine;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGFloat dataRectOffset = 45.0;
    
    CGRect graphRect = CGRectInset(rect, dataRectOffset, dataRectOffset);
    CGRect xAxisTextRect = CGRectMake(CGRectGetMinX(graphRect), (CGRectGetMaxY(graphRect) + 25.0), CGRectGetWidth(graphRect), 10.0);
    CGRect yAxisTextRect = CGRectMake((CGRectGetMinX(graphRect) - (CGRectGetWidth(rect) / 2.0) + 10.0), CGRectGetMidY(graphRect), CGRectGetWidth(graphRect), 10.0);
    
    drawAxisLines(context, graphRect, MKGraphViewFlags.hasXAxis, MKGraphViewFlags.hasYAxis);
    
    if (MKGraphViewFlags.hasXAxisTitle) {
        drawXAxisTitle(context, xAxisTextRect, mXAxisTitle);
    }
    if (MKGraphViewFlags.hasYAxisTitle) {
        drawYAxisTitle(context, yAxisTextRect, mYAxisTitle);
    }
    
    
    if (hasGraphData) {
        drawYAxisLabels(context, graphRect, mScale);
        
        float totalPadding = (dataSetsCount + 1.0) * kBarPadding;
        float barWidth = ((CGRectGetWidth(graphRect) - totalPadding) / dataSetsCount);
        int barCount = 1;
        
        if (barWidth < 0) {
            NSException *execption = [NSException exceptionWithName:@"Data to large" reason:@"To many data sets are being used for a graph of this size." userInfo:nil];
            [execption raise];
        }
        
        for (MKGraphDataSet *data in dataSets) {
            float barX = ((CGRectGetMinX(graphRect) + (kBarPadding * barCount) + (barWidth * barCount)) - barWidth);
            float barY = ((CGRectGetHeight(graphRect) * (1.0 - (data.data.value / mScale.max))) + CGRectGetMinY(graphRect));
            float barHeight = (CGRectGetMaxY(graphRect) - barY);
            
            CGRect barRect = CGRectMake(barX, barY, barWidth, barHeight);
            CGRect textRect = CGRectMake(CGRectGetMinX(barRect), (CGRectGetMaxY(barRect) + 5.0), CGRectGetWidth(barRect), 10.0);
            
            drawVerticalBar(context, barRect, [UIColor blueColor].CGColor);
            drawHorizontalText(context, textRect, data.data.title, 8.0, [UIColor blackColor].CGColor, UITextAlignmentCenter);
            
            barCount = (barCount + 1);
            
#if MKKIT_AVAILABLE_TO_MKGRAPHS
            if (barCount == dataSetsCount) {
                [[NSNotificationCenter defaultCenter] postNotificationName:MK_LOADING_VIEW_SHOULD_REMOVE_NOTIFICATION object:nil];
            }
#endif
        }
        
        if (MKGraphViewFlags.hasLimitLine) {
            drawLimitLine(context, graphRect, mLimit.label, mLimit.color, mLimit.value, mScale.max);
        }
    }
}

#pragma Axises

void drawAxisLines(CGContextRef context, CGRect rect, bool xAxis, bool yAxis) {
    if (xAxis) {
        CGContextSaveGState(context);
        CGContextSetLineWidth(context, 1.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(context);
    }
    if (yAxis) {
        CGContextSaveGState(context);
        CGContextSetLineWidth(context, 1.0);
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(context);
    }
}

void drawXAxisTitle(CGContextRef context, CGRect rect, CFStringRef title) {
    drawHorizontalText(context, rect, title, 10.0, [UIColor blackColor].CGColor, UITextAlignmentCenter);
}

void drawYAxisTitle(CGContextRef context, CGRect rect, CFStringRef title) {
    drawVerticalText(context, rect, title, 10.0, [UIColor blackColor].CGColor, UITextAlignmentCenter);
}

void drawYAxisLabels(CGContextRef context, CGRect rect, MKGraphScale scale) {
    CGFloat xPoint = CGRectGetMinX(rect);
    
    CGFloat p2y = (CGRectGetHeight(rect) * 0.25) + CGRectGetMinY(rect);
    CGFloat p3y = (CGRectGetHeight(rect) * 0.50) + CGRectGetMinY(rect);
    CGFloat p4y = (CGRectGetHeight(rect) * 0.75) + CGRectGetMinY(rect);
    CGFloat p5y = CGRectGetMaxY(rect);
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setMaximumFractionDigits:0];
    [numberFormatter setMinimumFractionDigits:0];
    [numberFormatter setMinimumIntegerDigits:1];
    
    NSString *pointOneLabel = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:scale.max]];
    NSString *pointTwoLabel = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:(scale.max * 0.75)]];
    NSString *pointThreeLabel = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:(scale.max * 0.50)]];
    NSString *pointFourLabel = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:(scale.max * 0.25)]];
    NSString *pointFiveLabel = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:scale.min]];
    
    [numberFormatter release];
        
    struct MKGraphAxisPointLabel pointOne = MKGraphAxisPointLabelMake(CGPointMake(xPoint, CGRectGetMinY(rect)), (CFStringRef)pointOneLabel);
    struct MKGraphAxisPointLabel pointTwo = MKGraphAxisPointLabelMake(CGPointMake(xPoint, p2y), (CFStringRef)pointTwoLabel);
    struct MKGraphAxisPointLabel pointThree = MKGraphAxisPointLabelMake(CGPointMake(xPoint, p3y), (CFStringRef)pointThreeLabel);
    struct MKGraphAxisPointLabel pointFour = MKGraphAxisPointLabelMake(CGPointMake(xPoint, p4y), (CFStringRef)pointFourLabel);
    struct MKGraphAxisPointLabel pointFive = MKGraphAxisPointLabelMake(CGPointMake(xPoint, p5y), (CFStringRef)pointFiveLabel);
    
    CGFloat pointOneWidth = MK_TEXT_WIDTH((NSString *)pointOne.title, VERDANA_BOLD(8.0));
    CGFloat pointTwoWidth = MK_TEXT_WIDTH((NSString *)pointTwo.title, VERDANA_BOLD(8.0));
    CGFloat pointThreeWidth = MK_TEXT_WIDTH((NSString *)pointThree.title, VERDANA_BOLD(8.0));
    CGFloat pointFourWidth = MK_TEXT_WIDTH((NSString *)pointFour.title, VERDANA_BOLD(8.0));
    CGFloat pointFiveWidth = MK_TEXT_WIDTH((NSString *)pointFive.title, VERDANA_BOLD(8.0));
    
    CGRect pointOneRect = CGRectMake((pointOne.point.x - pointOneWidth - 2.0), (pointOne.point.y - 4.0), pointOneWidth, 8.0);
    CGRect pointTwoRect = CGRectMake((pointTwo.point.x - pointTwoWidth - 2.0), (pointTwo.point.y - 4.0), pointTwoWidth, 8.0);
    CGRect pointThreeRect = CGRectMake((pointThree.point.x - pointThreeWidth - 2.0), (pointThree.point.y - 4.0), pointThreeWidth, 8.0);
    CGRect pointFourRect = CGRectMake((pointFour.point.x - pointFourWidth - 2.0), (pointFour.point.y - 4.0), pointFourWidth, 8.0);
    CGRect pointFiveRect = CGRectMake((pointFive.point.x - pointFiveWidth - 2.0), (pointFive.point.y - 4.0), pointFiveWidth, 8.0);
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextMoveToPoint(context, CGRectGetMaxX(pointOneRect) + 2.0, CGRectGetMidY(pointOneRect));
    CGContextAddLineToPoint(context, (CGRectGetMaxX(pointOneRect) + 4.0), CGRectGetMidY(pointOneRect));
    CGContextStrokePath(context);
    drawHorizontalText(context, pointOneRect, pointOne.title, 8.0, [UIColor blackColor].CGColor, UITextAlignmentLeft);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextMoveToPoint(context, CGRectGetMaxX(pointTwoRect) + 2.0, CGRectGetMidY(pointTwoRect));
    CGContextAddLineToPoint(context, (CGRectGetMaxX(pointTwoRect) + 4.0), CGRectGetMidY(pointTwoRect));
    CGContextStrokePath(context);
    drawHorizontalText(context, pointTwoRect, pointTwo.title, 8.0, [UIColor blackColor].CGColor, UITextAlignmentLeft);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextMoveToPoint(context, CGRectGetMaxX(pointThreeRect) + 2.0, CGRectGetMidY(pointThreeRect));
    CGContextAddLineToPoint(context, (CGRectGetMaxX(pointThreeRect) + 4.0), CGRectGetMidY(pointThreeRect));
    CGContextStrokePath(context);
    drawHorizontalText(context, pointThreeRect, pointThree.title, 8.0, [UIColor blackColor].CGColor, UITextAlignmentLeft);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextMoveToPoint(context, CGRectGetMaxX(pointFourRect) + 2.0, CGRectGetMidY(pointFourRect));
    CGContextAddLineToPoint(context, (CGRectGetMaxX(pointFourRect) + 4.0), CGRectGetMidY(pointFourRect));
    CGContextStrokePath(context);
    drawHorizontalText(context, pointFourRect, pointFour.title, 8.0, [UIColor blackColor].CGColor, UITextAlignmentLeft);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    drawHorizontalText(context, pointFiveRect, pointFive.title, 8.0, [UIColor blackColor].CGColor, UITextAlignmentLeft);
    CGContextRestoreGState(context);
}

#pragma mark limit Line

void drawLimitLine(CGContextRef context, CGRect rect, CFStringRef label, CGColorRef color, float value, float max) {
    float px1 = CGRectGetMinX(rect);
    float px2 = CGRectGetMaxX(rect);
    float yPoint = ((CGRectGetHeight(rect) * (1.0 - (value / max))) + CGRectGetMinY(rect));
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextMoveToPoint(context, px1, yPoint);
    CGContextAddLineToPoint(context, px2, yPoint);
    CGContextStrokePath(context);
    
    CGRect textRect = CGRectMake((CGRectGetMaxX(rect) + 3.0), (yPoint - 4.0), MK_TEXT_WIDTH((NSString *)label, VERDANA_BOLD(8.0)), 8.0);
    
    if (label) {
        drawHorizontalText(context, textRect, label, 8.0, color, UITextAlignmentLeft);
    }
}


#pragma mark data drawing

void drawVerticalBar(CGContextRef context, CGRect rect, CGColorRef color) {
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, color);
    CGContextFillRect(context, rect);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextStrokeRect(context, rect);
    CGContextRestoreGState(context);
}

#pragma mark - Memory Managment

- (void)dealloc {
    [super dealloc];
}

@end
