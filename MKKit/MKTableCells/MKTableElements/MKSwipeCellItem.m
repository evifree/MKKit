//
//  MKSwipeCellItem.m
//  MKKit
//
//  Created by Matthew King on 9/10/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKSwipeCellItem.h"

@interface MKSwipeCellItem ()

- (void)fillLabel:(NSString *)text;

@end

void drawDeleteItem(CGContextRef context, CGRect rect);

@implementation MKSwipeCellItem

#pragma mark - Initalizer

- (id)initWithStyle:(MKSwipeCellItemStyle)style title:(NSString *)title action:(MKActionBlock)actionBlock {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, 30.0, 42.0)];
    if (self) {
        self.backgroundColor = CLEAR;
        
        mStyle = style;
        
        [self completedAction:actionBlock];
        [self fillLabel:title];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image title:(NSString *)title action:(MKActionBlock)actionBlock {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, 30.0, 42.0)];
    if (self) {
        self.backgroundColor = CLEAR;
        
        mStyle = MKSwipeCellItemNone;
        
        MKSwipeCellItemMask *mask = [[MKSwipeCellItemMask alloc] initWithImage:image];
        mask.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
        
        [self addSubview:mask];
        [mask release];
        
        [self completedAction:actionBlock];
        [self fillLabel:title];
    }
    return self;
}

#pragma mark - Helpers

- (void)fillLabel:(NSString *)text {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 32.0, 30.0, 10.0)];
    titleLabel.backgroundColor = CLEAR;
    titleLabel.font = VERDANA_BOLD(10.0);
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textColor = MK_COLOR_HSB(345.0, 3.0, 18.0, 1.0);
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.text = text;
    
    [self addSubview:titleLabel];
    [titleLabel release];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGRect drawRect = CGRectMake(0.0, 0.0, 30.0, 30.0);
    
    if (mStyle == MKSwipeCellItemDelete) {
        drawDeleteItem(context, drawRect);
    }
}

#pragma mark Delete Button

void drawDeleteItem(CGContextRef context, CGRect rect) {
    CGMutablePathRef path = createCircularPathForRect(CGRectInset(rect, 3.0, 3.0));
    
    CGRect xRect = CGRectInset(rect, 9.0, 9.0);
    CGColorRef fillColor = MK_COLOR_HSB(345.0, 3.0, 18.0, 1.0).CGColor;
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 4.0);
    CGContextSetStrokeColorWithColor(context, fillColor);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 3.0);
    CGContextSetStrokeColorWithColor(context, fillColor);
    CGContextMoveToPoint(context, CGRectGetMinX(xRect), CGRectGetMinY(xRect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(xRect), CGRectGetMaxX(xRect));
    CGContextMoveToPoint(context, CGRectGetMaxX(xRect), CGRectGetMinY(xRect));
    CGContextAddLineToPoint(context, CGRectGetMinX(xRect), CGRectGetMaxX(xRect));
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CFRelease(path);
}

#pragma mark - Memory Managment

- (void)dealloc {
    [super dealloc];
}

@end

@implementation MKSwipeCellItemMask

#pragma mark - Initalizer

- (id)initWithImage:(UIImage *)image {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
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
    
    CGColorRef fillColor = MK_COLOR_HSB(345.0, 3.0, 18.0, 1.0).CGColor;
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, fillColor);
    //CGContextSetShadowWithColor(context, CGSizeMake(0.0, 1.0), 1.0, LIGHT_GRAY.CGColor);
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, rect, mImage.CGImage);
    CGContextFillRect(context, rect);
    CGContextRestoreGState(context);
}

#pragma mark - Memory Managment

- (void)dealloc {
    [mImage release];
    
    [super dealloc];
}

@end