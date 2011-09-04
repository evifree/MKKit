//
//  MKTabItem.m
//  MKKit
//
//  Created by Matthew King on 8/5/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKTabItem.h"

@implementation MKTabItem

@synthesize selected=mSelected, title=mTitle, tabbedView, index=mIndex;

void drawSelectedItem(CGContextRef context, CGRect rect);
void drawUnslectedItem(CGContextRef context, CGRect rect);

CGMutablePathRef createPathForTab(CGRect rect);

#pragma mark - Initalizer

- (id)initWithTitle:(NSString *)text {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, 100.0, 45.0)];
    if (self) {
        self.alpha = 1.0;
        self.opaque = YES;
        
        mTitle = [text copy];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(2.0, 10.0, 96.0, 24.0)];
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.backgroundColor = CLEAR; 
        titleLabel.textColor = DARK_GRAY;
        titleLabel.font = VERDANA_BOLD(18.0);
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.shadowColor = WHITE;
        titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        titleLabel.text = mTitle;
        titleLabel.tag = 1;
        
        [self addSubview:titleLabel];
        [titleLabel release];
        
        self.backgroundColor = CLEAR;
        
        mShouldRemoveView = NO;
        mSelected = NO;
    }
    return self;
}

#pragma mark - Accessor Methods

- (void)setSelected:(BOOL)select {
    mSelected = select;
    [self setNeedsDisplay];
}

- (void)setTitle:(NSString *)text {
    mTitle = [text copy];
    [self setNeedsDisplay];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    if (mSelected) {
        drawSelectedItem(context, rect);
        
        UILabel *titleLabel = (UILabel *)[self viewWithTag:1];
        titleLabel.shadowColor = WHITE;
    }
    else {
        drawUnslectedItem(context, rect);
        
        UILabel *titleLabel = (UILabel *)[self viewWithTag:1];
        titleLabel.shadowColor = MK_COLOR_HSB(345.0, 2.0, 86.0, 1.0);
    }
}

void drawSelectedItem(CGContextRef context, CGRect rect) {
    CGColorRef topColor = MK_COLOR_HSB(345.0, 2.0, 99.0, 1.0).CGColor;
    CGColorRef bottomColor = MK_COLOR_HSB(345.0, 2.0, 86.0, 1.0).CGColor;
    
    CGMutablePathRef path = createPathForTab(rect);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    drawGlossAndLinearGradient(context, rect, topColor, bottomColor);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, DARK_GRAY.CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, MK_COLOR_HSB(345.0, 2.0, 86.0, 1.0).CGColor);
    CGContextMoveToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CFRelease(path);
}

void drawUnslectedItem(CGContextRef context, CGRect rect) {
    CGColorRef topColor = MK_COLOR_HSB(345.0, 2.0, 86.0, 1.0).CGColor;
    CGColorRef bottomColor = MK_COLOR_HSB(345.0, 2.0, 76.0, 1.0).CGColor;
    
    CGMutablePathRef path = createPathForTab(rect);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    drawGlossAndLinearGradient(context, rect, topColor, bottomColor);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, DARK_GRAY.CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CFRelease(path);
}

CGMutablePathRef createPathForTab(CGRect rect) {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect));
    
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect),CGRectGetMaxX(rect), CGRectGetMaxY(rect), 10.0);
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMinY(rect), 10.0);
    
    CGPathCloseSubpath(path);
    
    return path;
}

#pragma mark - Touches 

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.tabbedView switchToTabAtIndex:self.index];
}

#pragma mark - Memory Managment

- (void)dealloc {
    [mTitle release];
    
    [super dealloc];
}

@end
