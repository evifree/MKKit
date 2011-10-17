//
//  MKCheckBox.m
//  MKKit
//
//  Created by Matthew King on 10/3/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKCheckBox.h"


@implementation MKCheckBox

@synthesize boxChecked, type=mType;

#pragma mark -
#pragma mark Initailization

- (id)initWithType:(MKCheckBoxType)boxType {
    self = [super init];
	if (self) {
        self.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
        self.backgroundColor = CLEAR;
        self.opaque = YES;
        
        mType = boxType;
        
        MKCheckBoxFlags.isChecked = NO;
		self.userInteractionEnabled = YES;
	}
	return self;
}

#pragma mark - Accesor Methods
#pragma mark setters

- (void)setBoxChecked:(BOOL)checked {
	if (checked) {
        MKCheckBoxFlags.isChecked = YES;
	}
	else {
        MKCheckBoxFlags.isChecked = NO;
	}
    [self setNeedsDisplay];
}

- (void)setType:(MKCheckBoxType)boxType {
    mType = boxType;
    [self setNeedsDisplay];
}

#pragma mark getters

- (BOOL)boxChecked {
    return MKCheckBoxFlags.isChecked;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGRect drawRect = CGRectInset(rect, 2.0, 2.0);
    CGMutablePathRef path;
    
    if (mType == MKCheckBoxRoundedRect) {
        path = createRoundedRectForRect(drawRect, 5.0);
    }
    if (mType == MKCheckBoxRound) {
        path = createCircularPathForRect(drawRect);
    }
    
    if (MKCheckBoxFlags.isChecked) {
        CGColorRef fillColor = MK_COLOR_HSB(117.0, 96.0, 91.0, 1.0).CGColor;
        CGColorRef shadowColor = MK_COLOR_HSB(117.0, 96.0, 57.0, 1.0).CGColor;
        
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, fillColor);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGContextFillRect(context, drawRect);
        drawCurvedGloss(context, drawRect, drawRect.size.width);
        CGContextRestoreGState(context);
        
        CGRect checkRect = CGRectInset(drawRect, 7.0, 7.0);
        
        CGContextSaveGState(context);
        CGContextSetLineWidth(context, 4.0);
        CGContextSetStrokeColorWithColor(context, WHITE.CGColor);
        CGContextSetShadowWithColor(context, CGSizeMake(0.0, -1.0), 1.0, shadowColor);
        CGContextMoveToPoint(context, CGRectGetMinX(checkRect), CGRectGetMidY(checkRect));
        CGContextAddLineToPoint(context, (CGRectGetMidX(checkRect) - 2.0), CGRectGetMaxY(checkRect));
        CGContextAddLineToPoint(context, CGRectGetMaxX(checkRect), CGRectGetMinY(checkRect));
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
    }
    
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, BLACK.CGColor);
    CGContextSetLineWidth(context, 2.0);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CFRelease(path);
}

#pragma mark -
#pragma mark Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
	UITouch *touch = [[event allTouches] anyObject];
	NSInteger taps = [touch tapCount];
	
	if (taps == 1) {
		if (!MKCheckBoxFlags.isChecked) {
            MKCheckBoxFlags.isChecked = YES;
		}
		else {
            MKCheckBoxFlags.isChecked = NO;
		}
        [self setNeedsDisplay];
		[self processAction:MKActionValueChanged];
	}
}

#pragma mark -
#pragma mark Memory Managment

- (void)dealloc {
	[super dealloc];
}

@end
