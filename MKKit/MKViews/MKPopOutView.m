//
//  MKPopOutView.m
//  MKKit
//
//  Created by Matthew King on 8/2/11.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import "MKPopOutView.h"

@implementation MKPopOutView

#pragma mark - Initalizer

@synthesize type=mType, tintColor;

- (id)initWithView:(UIView *)view type:(MKPopOutViewType)type {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, (kPopOutViewWidth + 5.0), (view.frame.size.height + 30.0))];
    if (self) {
        mView = [view retain];
        mType = type;
        mTintColor = BLACK.CGColor;
        
        self.alpha = 0.0;
        self.backgroundColor = CLEAR;
        self.opaque = YES;
        
        [self addSubview:mView];
        [mView release];
        
        MKPopOutViewShouldRemoveNotification = @"MKPopOutViewShouldRemoveNotification";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeView) name:MKPopOutViewShouldRemoveNotification object:nil];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGRect drawRect = CGRectZero;
    
    switch (mAutoType) {
        case MKPopOutBelow:
            drawRect = CGRectInset(rect, 5.0, 20.0);
            break;
        case MKPopOutAbove:
            drawRect = CGRectMake(5.0, 5.0, (rect.size.width - 5.0), (rect.size.height - 30.0));
        default:
            break;
    }
    
    CGRect innerRect = CGRectInset(drawRect, 1.0, 1.0);
    
    CGMutablePathRef path = createRoundedRectForRect(drawRect, 20.0);
    CGMutablePathRef innerPath = createRoundedRectForRect(innerRect, 20.0);
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, 3.0), 3.0, MK_SHADOW_COLOR);
    CGContextSetFillColorWithColor(context, mTintColor);
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextSaveGState(context);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, innerPath);
    CGContextClip(context);
    drawGlossAndLinearGradient(context, innerRect, mTintColor, mTintColor);
    CGContextRestoreGState(context);
    
    if (mAutoType == MKPopOutBelow) {
        CGRect pointerRect = CGRectMake((CGRectGetMaxX(drawRect) - 70.0), (CGRectGetMinY(drawRect) - 20.0), 35.0, 20.0);
        CGMutablePathRef pointerPath = createPathForUpPointer(pointerRect);
        
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, mTintColor);
        CGContextAddPath(context, pointerPath);
        CGContextFillPath(context);
        CGContextSaveGState(context);
        
        CFRelease(pointerPath);
    }
    else if (mAutoType == MKPopOutAbove) {
        CGRect pointerRect = CGRectMake((CGRectGetMaxX(drawRect) - 70.0), CGRectGetMaxY(drawRect), 35.0, 20.0);
        CGMutablePathRef pointerPath = createPathForDownPointer(pointerRect);
        
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, mTintColor);
        CGContextAddPath(context, pointerPath);
        CGContextFillPath(context);
        CGContextSaveGState(context);
        
        CFRelease(pointerPath);
    }
    
    CFRelease(path);
    CFRelease(innerPath);
}

#pragma mark - Accessor Methods

- (void)setTintColor:(CGColorRef)tint {
    mTintColor = tint;
    [self setNeedsDisplay];
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    
    if ([touch tapCount] == 1) {
        [self removeView];
    }
}

#pragma mark - Memory Managment

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MKPopOutViewShouldRemoveNotification object:nil];
    
    [super dealloc];
}

@end
