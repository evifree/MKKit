//
//  MKSwipeCellView.m
//  MKKit
//
//  Created by Matthew King on 9/10/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKSwipeCellView.h"

@implementation MKSwipeCellView

#pragma mark - Initalizer

- (id)initWithItems:(NSArray *)items cell:(MKTableCell *)cell {
    self = [super initWithFrame:CGRectMake(320.0, 0.0, cell.frame.size.width, cell.frame.size.height)];
    if (self) {
        self.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        self.alpha = 1.0;
        
        mShouldRemoveView = NO;
        mCell = [cell retain];
        mItems = [items retain];
        
        [mCell addSubview:self];
        
        UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
        [self addGestureRecognizer:swipe];
        [swipe release];
    }
    return self;
}

#pragma mark - Layout

- (void)layoutSubviews {
    NSInteger numOfItems = [mItems count];
    NSInteger numOfSpaces = (numOfItems + 1);
    CGFloat availableSpace = (mCell.frame.size.width - (numOfItems * kItemTakeUpWidth));
    CGFloat xFactor = (availableSpace / numOfSpaces);
    
    for (int i = 0; i < numOfItems; i++) {
        MKSwipeCellItem *item = (MKSwipeCellItem *)[mItems objectAtIndex:i];
        item.frame = CGRectMake(((xFactor * (i + 1)) + (kItemTakeUpWidth * i)), 10.0, 30.0, 42.0);
        [self addSubview:item];
    }
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGColorRef shadowColor = MK_COLOR_RGB(0.0, 0.0, 0.0, 0.85).CGColor;
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, BLACK.CGColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, 2.0), 4.0, shadowColor);
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, BLACK.CGColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, -2.0), 4.0, shadowColor);
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

#pragma mark - Display

- (void)show {
    [UIView animateWithDuration:0.25
                     animations: ^ { self.x = 0.0; } ];
}

- (void)remove {
    [UIView animateWithDuration:0.25 
                     animations: ^ { self.x = 320.0;} 
                     completion: ^ (BOOL finished) { [self removeFromSuperview]; }];
}

#pragma mark - Memory Managment

- (void)dealloc {
    [mCell release];
    
    [super dealloc];
}

@end