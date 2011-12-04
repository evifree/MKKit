//
//  MKBarButtonItem.m
//  MKKit
//
//  Created by Matthew King on 6/18/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKBarButtonItem.h"

#import <MKKit/MKKit/MKImage.h>

@implementation MKBarButtonItem

@synthesize type=mType;

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
        mImageMask = [icon retain];
        
        MKBarButtonItemFlags.requiresDrawing = NO;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:mImageMask];
        imageView.frame = self.frame;
        
        [self addSubview:imageView];
        [imageView release];
    }
    
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (MKBarButtonItemFlags.requiresDrawing) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetAllowsAntialiasing(context, YES);
        
        CGFloat outerMargin = 2.0;
        CGRect viewRect = CGRectInset(self.bounds, outerMargin, outerMargin);
        
        CGColorRef inner = MK_COLOR_HSB(345.0, 1.0, 99.0, 1.0).CGColor;;
        CGColorRef shadowColor = BLACK.CGColor;
        
        if (mType == MKBarButtonItemBackArrow) {
            CGPoint p1 = CGPointMake(CGRectGetMinX(viewRect), CGRectGetMidY(viewRect));
            CGPoint p2 = CGPointMake(CGRectGetMaxX(viewRect), CGRectGetMinY(viewRect));
            CGPoint p3 = CGPointMake(CGRectGetMaxX(viewRect), CGRectGetMaxY(viewRect));
            
            CGMutablePathRef path = CGPathCreateMutable();
            
            CGPathMoveToPoint(path, NULL, p1.x, p1.y);
            CGPathAddLineToPoint(path, NULL, p2.x, p2.y);
            CGPathAddLineToPoint(path, NULL, p3.x, p3.y);
            CGPathAddLineToPoint(path, NULL, p1.x, p1.y);
            CGPathCloseSubpath(path);
            
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, CGSizeMake(0, -1), 1.0, shadowColor);
            CGContextSetFillColorWithColor(context, inner);
            CGContextAddPath(context, path);
            CGContextFillPath(context);
            CGContextRestoreGState(context);
            
            CFRelease(path);
        }
        else if (mType == MKBarButtonItemForwardArrow) {
            CGPoint p1 = CGPointMake(CGRectGetMinX(viewRect), CGRectGetMinY(viewRect));
            CGPoint p2 = CGPointMake(CGRectGetMaxX(viewRect), CGRectGetMidY(viewRect));
            CGPoint p3 = CGPointMake(CGRectGetMinX(viewRect), CGRectGetMaxY(viewRect));
            
            CGMutablePathRef path = CGPathCreateMutable();
            
            CGPathMoveToPoint(path, NULL, p1.x, p1.y);
            CGPathAddLineToPoint(path, NULL, p2.x, p2.y);
            CGPathAddLineToPoint(path, NULL, p3.x, p3.y);
            CGPathAddLineToPoint(path, NULL, p1.x, p1.y);
            CGPathCloseSubpath(path);
            
            CGContextSaveGState(context);
            CGContextSetShadowWithColor(context, CGSizeMake(0, -1), 2.0, shadowColor);
            CGContextSetFillColorWithColor(context, inner);
            CGContextAddPath(context, path);
            CGContextFillPath(context);
            CGContextRestoreGState(context);
            
            CFRelease(path);
        }
    }
}

#pragma mark - Memory Managment

- (void)dealloc {
    if (mImageMask) {
        [mImageMask release];
    }
    
    [super dealloc];
}

@end
