//
//  MKTableCellBadge.m
//  MKKit
//
//  Created by Matthew King on 6/12/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKTableCellBadgeView.h"

@implementation MKTableCellBadgeView

@synthesize badgeText, badgeColor;

#pragma mark - Ininializer

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CLEAR;
        self.alpha = 1.0;
        self.opaque = NO;
        
        mBadgeColor = GRAY.CGColor;
        
        mBadgeLabel = [[UILabel alloc] initWithFrame:self.frame];
        mBadgeLabel.backgroundColor = CLEAR;
        mBadgeLabel.font = SYSTEM_BOLD(12);
        mBadgeLabel.textAlignment = UITextAlignmentCenter;
        mBadgeLabel.textColor = WHITE;
        mBadgeLabel.shadowColor = BLACK;
        mBadgeLabel.shadowOffset = CGSizeMake(0.0, -1.0);
        
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGRect rrect = rect;
    
    CGMutablePathRef roundRectPath = createRoundedRectForRect(rrect, 10.0);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, mBadgeColor);
    CGContextAddPath(context, roundRectPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    CFRelease(roundRectPath);
    
    if (mBadgeLabel) {
        [mBadgeLabel drawTextInRect:rect];
    }
}

#pragma mark - Accessor Methods

- (void)setBadgeText:(NSString *)text {
    mBadgeLabel.text = text;
    [self setNeedsDisplay];
}

- (void)setBadgeColor:(UIColor *)color {
    mBadgeColor = color.CGColor;
    [self setNeedsDisplay];
}

#pragma - Memory Managment

- (void)dealloc {
    [mBadgeLabel release];
    
    [super dealloc];
}

@end