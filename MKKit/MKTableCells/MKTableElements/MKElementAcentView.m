//
//  MKElementAccentView.m
//  MKKit
//
//  Created by Matthew King on 8/2/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKElementAcentView.h"

@implementation MKElementAcentView

CGMutablePathRef createPathForTopCell(CGRect rect);
CGMutablePathRef createPathForBottomCell(CGRect rect);

#pragma mark - Initalizer

- (id)initWithFrame:(CGRect)frame position:(MKTableCellPosition)position {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CLEAR;
        self.opaque = YES;
        self.alpha = 1.0;
        self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        
        mPosition = position;
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGColorRef topColor = MK_COLOR_HSB(345.0, 2.0, 99.0, 1.0).CGColor;
    CGColorRef bottomColor = MK_COLOR_HSB(345.0, 2.0, 86.0, 1.0).CGColor;
    
    if (mPosition == MKTableCellPositionTop) {
        CGMutablePathRef topPath = createPathForTopCell(rect);
        
        CGContextSaveGState(context);
        CGContextAddPath(context, topPath);
        CGContextClip(context);
        drawGlossAndLinearGradient(context, rect, topColor, bottomColor);
        CGContextSaveGState(context);
        
        CFRelease(topPath);
    }
    
    if (mPosition == MKTableCellPositionMiddle) {
        CGContextSaveGState(context);
        drawGlossAndLinearGradient(context, rect, topColor, bottomColor);
        CGContextSaveGState(context);
    }
    
    if (mPosition == MKTableCellPositionBottom) {
        CGMutablePathRef bottomPath = createPathForBottomCell(rect);
        
        CGContextSaveGState(context);
        CGContextAddPath(context, bottomPath);
        CGContextClip(context);
        drawGlossAndLinearGradient(context, rect, topColor, bottomColor);
        CGContextSaveGState(context);
        
        CGContextSaveGState(context);
        CGContextSetStrokeColorWithColor(context, GRAY.CGColor);
        CGContextSetLineWidth(context, 2.0);
        CGContextMoveToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
        
        CFRelease(bottomPath);
    }
    
    if (mPosition != MKTableCellPositionBottom) {
        CGContextSaveGState(context);
        CGContextSetStrokeColorWithColor(context, GRAY.CGColor);
        CGContextSetLineWidth(context, 2.0);
        CGContextMoveToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
    }
}

CGMutablePathRef createPathForTopCell(CGRect rect) {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMinY(rect), 10.0);
    
    CGPathCloseSubpath(path);
    
    return path;      
}

CGMutablePathRef createPathForBottomCell(CGRect rect) {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMinY(rect), 10.0);
    
    CGPathCloseSubpath(path);
    
    return path;
}

#pragma mark - Memory Management

- (void)dealloc {
    [super dealloc];
}

@end
