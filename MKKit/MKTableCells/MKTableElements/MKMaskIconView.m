//
//  MKMaskIconView.m
//  MKKit
//
//  Created by Matthew King on 7/5/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKMaskIconView.h"

@implementation MKMaskIconView

#pragma mark - Initalizer

- (id)initWithImage:(UIImage *)image {
    self = [super initWithFrame:CGRectMake(10.0, 7.0, 30.0, 30.0)];
    if (self) {
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        self.alpha = 1.0;
        
        mImage = [image retain];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGColorRef bottomColor =  MK_COLOR_HSB(345.0, 0.0, 86.0, 1.0).CGColor;
    CGColorRef topColor = MK_COLOR_HSB(345.0, 0.0, 56.0, 1.0).CGColor;
        
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, rect, mImage.CGImage);
    drawLinearGradient(context, rect, bottomColor, topColor);
    CGContextRestoreGState(context);
}

#pragma mark - Memory Managment

- (void)dealloc {
    [mImage release];
    
    [super dealloc];
}

@end
