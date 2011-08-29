//
//  MKTableCellAccentView.m
//  MKKit
//
//  Created by Matthew King on 8/27/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKTableCellAccentView.h"

@implementation MKTableCellAccentView

void drawAccentForSingleCell(CGContextRef context, CGRect rect, CGColorRef topColor, CGColorRef bottomColor);

@synthesize tint;

#pragma mark - Initalizer

- (id)initWithFrame:(CGRect)frame position:(MKTableCellPosition)position {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        self.alpha = 1.0;
        self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        
        mShouldRemoveView = NO;

        MKTableCellAccentViewFlags.position = position;
        MKTableCellAccentViewFlags.tintColor = GRAY.CGColor;
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGColorRef tintRef = MKTableCellAccentViewFlags.tintColor;
    
    const CGFloat* components = CGColorGetComponents(tintRef);
    
    CGFloat red = components[0];
    CGFloat green = components[1];
    CGFloat blue = components[2];
    CGFloat alpha = CGColorGetAlpha(tintRef);
    
    CGColorRef topColor = [UIColor colorWithRed:red green:green blue:blue alpha:(alpha - 0.5)].CGColor;
    
    if (MKTableCellAccentViewFlags.position == MKTableCellPositionSingleCell) {
        drawAccentForSingleCell(context, rect, topColor, self.tint.CGColor);
    }
}

void drawAccentForSingleCell(CGContextRef context, CGRect rect, CGColorRef topColor, CGColorRef bottomColor) {
    CGMutablePathRef path = createRoundedRectForRect(rect, 10.0);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, WHITE.CGColor);
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    drawGlossAndLinearGradient(context, rect, topColor, bottomColor);
    CGContextRestoreGState(context);
    
    CFRelease(path);
}

#pragma mark - Accessor Methods

- (void)setTint:(UIColor *)theTint {    
    MKTableCellAccentViewFlags.tintColor = theTint.CGColor;
    [self setNeedsDisplay];
}

#pragma mark - Memory Managment

- (void)dealloc {
    [super dealloc];
}

@end
