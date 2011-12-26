//
//  MKBarButtonItem.m
//  MKKit
//
//  Created by Matthew King on 6/18/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKBarButtonItem.h"

#import <MKKit/MKKit/MKImage.h>

void drawButtonBorder(CGContextRef context, CGRect rect);

@implementation MKBarButtonItem

@synthesize type=mType;

@dynamic bordered;

#pragma mark - Initalizer

- (id)initWithType:(MKBarButtonItemType)type {
    self = [super init];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = CLEAR;
        mType = type;
        
        MKBarButtonItemFlags.requiresDrawing = YES;
        
        if (type == MKBarButtonItemBackArrow || type == MKBarButtonItemForwardArrow) {
            self.frame = CGRectMake(0.0, 0.0, 20.0, 20.0);
        }
    }
    return self;
}

- (id)initWithIcon:(MKImage *)icon {
    self = [super init];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = CLEAR;
        self.frame = CGRectMake(0.0, 0.0, icon.size.width, icon.size.height);
        
        mType = MKBarButtonItemIcon;
        
        MKBarButtonItemFlags.requiresDrawing = NO;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:icon];
        imageView.frame = self.frame;
        
        [self addSubview:imageView];
        [imageView release];
    }
    
    return self;
}

#pragma mark - Memory

- (void)dealloc {
    [super dealloc];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    if (MKBarButtonItemFlags.isBordered) {
        drawButtonBorder(context, rect);
    }
    
    if (MKBarButtonItemFlags.requiresDrawing) {
        CGFloat outerMargin = 2.0;
        CGRect viewRect = CGRectInset(self.bounds, outerMargin, outerMargin);
        
        CGColorRef fillColor = nil;
        
        if (MKControlFlags.isEnabled) {
            fillColor = MK_COLOR_HSB(345.0, 1.0, 99.0, 1.0).CGColor;
        }
        else {
            fillColor = MK_COLOR_HSB(345.0, 1.0, 99.0, 0.25).CGColor;;
        }
    
        CGColorRef shadowColor = BLACK.CGColor;
        
        if (mType == MKBarButtonItemBackArrow) {
            CGMutablePathRef arrowPath = createPathForLeftArrow(viewRect);
            
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, CGSizeMake(0, -1), 0.0, shadowColor);
            CGContextSetFillColorWithColor(context, fillColor);
            CGContextAddPath(context, arrowPath);
            CGContextFillPath(context);
            CGContextRestoreGState(context);
            
            CFRelease(arrowPath);
        }
        else if (mType == MKBarButtonItemForwardArrow) {
            CGMutablePathRef arrowPath = createPathForRightArrow(viewRect);
            
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, CGSizeMake(0, -1), 0.0, shadowColor);
            CGContextSetFillColorWithColor(context, fillColor);
            CGContextAddPath(context, arrowPath);
            CGContextFillPath(context);
            CGContextRestoreGState(context);
            
            CFRelease(arrowPath);
        }
    }
}

#pragma mark Helpers

void drawButtonBorder(CGContextRef context, CGRect rect) {
    CGColorRef borderColor = BLACK.CGColor;
    
    CGMutablePathRef roundedRect = createRoundedRectForRect(rect, 5.0);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, roundedRect);
    CGContextClip(context);
    drawLinearGloss(context, rect);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, borderColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextAddPath(context, roundedRect);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

#pragma mark - Accessors
#pragma mark Setters

- (void)setBordered:(BOOL)_bordered {
    MKBarButtonItemFlags.isBordered = YES;
    [self setNeedsDisplay];
}

#pragma mark Getters

- (BOOL)bordered {
    return MKBarButtonItemFlags.isBordered;
}

@end
