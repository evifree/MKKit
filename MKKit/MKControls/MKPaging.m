//
//  MKPaging.m
//  MKKit
//
//  Created by Matthew King on 12/4/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKPaging.h"

@implementation MKPaging

@dynamic numberOfPages, currentPage;

#pragma mark - Creating

- (id)initWithPages:(NSInteger)numOfPages {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.0, 0.0, 300.0, 30.0);
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        
        self.numberOfPages = numOfPages;
        self.currentPage = 1;
        
        MKPagingFlags.leftArrowActive = NO;
        MKPagingFlags.rightArrowActive = NO;
        
        if (numOfPages > 1) {
            MKPagingFlags.rightArrowActive = YES;
        }
    }
    return self;
}

#pragma mark - Memory Managment

- (void)dealloc {
    [super dealloc];
}

#pragma mark - Accessor Methods
#pragma mark Setters

- (void)setNumberOfPages:(NSInteger)number {
    MKPagingFlags.pages = number;
    
    if (MKPagingFlags.pages > 1 && self.currentPage < number) {
        MKPagingFlags.rightArrowActive = YES;
    }
    
    [self setNeedsDisplay];
}

- (void)setCurrentPage:(NSInteger)current {
    MKPagingFlags.currentPage = current;
    
    if (current == MKPagingFlags.pages) {
        MKPagingFlags.rightArrowActive = NO;
    }
    else {
        MKPagingFlags.rightArrowActive = YES;
    }
    
    if (current == 1) {
        MKPagingFlags.leftArrowActive = NO;
    }
    else {
        MKPagingFlags.leftArrowActive = YES;
    }
    
    [self setNeedsDisplay];
}

#pragma mark Getters

- (NSInteger)numberOfPages {
    return MKPagingFlags.pages;
}

- (NSInteger)currentPage {
    return MKPagingFlags.currentPage;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGColorRef activeArrowColor = MK_COLOR_RGB(1.0, 1.0, 1.0, 1.0).CGColor;
    CGColorRef inactiveArrowColor = MK_COLOR_RGB(1.0, 1.0, 1.0, 0.5).CGColor;
    
    CGFloat dotFrameWidth = (self.numberOfPages * 12);
    
    leftArrowRect = CGRectMake(0.0, 5.0, 20.0, 20.0);
    rightArrowRect = CGRectMake((CGRectGetMaxX(rect) - 30.0), 5.0, 20.0, 20.0);
    CGRect dotBlockRect = CGRectMake(CENTER_VIEW_HORIZONTALLY(rect.size.width, dotFrameWidth), 0.0, dotFrameWidth, 20.0);
    
    CGMutablePathRef leftArrowPath = createPathForLeftArrow(leftArrowRect);
    CGMutablePathRef rightArrowPath = createPathForRightArrow(rightArrowRect);
    
    CGContextSaveGState(context);
    if (MKPagingFlags.leftArrowActive) {
        CGContextSetFillColorWithColor(context, activeArrowColor);
    }
    else {
        CGContextSetFillColorWithColor(context, inactiveArrowColor);
    }
    CGContextAddPath(context, leftArrowPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    if (MKPagingFlags.rightArrowActive) {
        CGContextSetFillColorWithColor(context, activeArrowColor);
    }
    else {
        CGContextSetFillColorWithColor(context, inactiveArrowColor);
    }
    CGContextAddPath(context, rightArrowPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);

    
    for (int i = 0; self.numberOfPages > i; i++) {
        CGColorRef dotColor = LIGHT_GRAY.CGColor;
        
        if ((i + 1) == self.currentPage) {
            dotColor = BLACK.CGColor;
        }
        
        CGFloat xAdjust = (i * 12.0);
        
        CGRect dotRect = CGRectMake((dotBlockRect.origin.x + xAdjust), 6.0, 8.0, 8.0);
        CGMutablePathRef dotPath = createCircularPathForRect(dotRect);
        
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, dotColor);
        CGContextAddPath(context, dotPath);
        CGContextFillPath(context);
        CGContextSaveGState(context);
    }
    
    CFRelease(leftArrowPath);
    CFRelease(rightArrowPath);
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    if (CGRectContainsPoint(rightArrowRect, touchPoint)) {
        if (MKPagingFlags.rightArrowActive) {
            if (MKControlFlags.blockUsage) {
                self.action(MKActionValueIncreased);
            }
            if (MKControlFlags.targetUsage) {
                for (MKControlTarget *aTarget in mTargets) {
                    if (aTarget.action == MKActionValueIncreased) {
                        [aTarget.target performSelector:aTarget.selector withObject:self];
                    }
                }
            }
            if ([mDelegate respondsToSelector:@selector(didCompleteAction:sender:)]) {
                [mDelegate didCompleteAction:MKActionValueIncreased sender:self];
            }
        }
    }
    else if (CGRectContainsPoint(leftArrowRect, touchPoint)) {
        if (MKPagingFlags.leftArrowActive) {
            if (MKControlFlags.blockUsage) {
                self.action(MKActionValueDecreased);
            }
            if (MKControlFlags.targetUsage) {
                for (MKControlTarget *aTarget in mTargets) {
                    if (aTarget.action == MKActionValueDecreased) {
                        [aTarget.target performSelector:aTarget.selector withObject:self];
                    }
                }
            }
            if ([mDelegate respondsToSelector:@selector(didCompleteAction:sender:)]) {
                [mDelegate didCompleteAction:MKActionValueDecreased sender:self];
            }
        }
    }
}

@end
