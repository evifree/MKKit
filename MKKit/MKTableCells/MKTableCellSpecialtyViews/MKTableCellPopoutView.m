//
//  MKTableCellPopoutView.m
//  MKKit
//
//  Created by Matthew King on 7/30/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKTableCellPopoutView.h"

@implementation MKTableCellPopoutView

#pragma mark - Initalizer

@synthesize type=mType, tintColor;

- (id)initWithView:(UIView *)view type:(MKTableCellPopoutViewType)type {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, (kPopoutViewWidth + 5.0), (view.frame.size.height + 30.0))];
    if (self) {
        mView = [view retain];
        mType = type;
        mTintColor = BLACK.CGColor;
        
        self.alpha = 0.0;
        self.backgroundColor = CLEAR;
        self.opaque = YES;
                
        [self addSubview:mView];
        [mView release];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeView) name:MK_TABLE_CELL_POPOUT_VIEW_SHOULD_REMOVE_NOTIFICATION object:nil];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGRect drawRect = CGRectZero;
    
    switch (mAutoType) {
        case MKTableCellPopoutBelow:
            drawRect = CGRectInset(rect, 5.0, 20.0);
            break;
        case MKTableCellPopoutAbove:
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
    
    if (mAutoType == MKTableCellPopoutBelow) {
        CGRect pointerRect = CGRectMake((CGRectGetMaxX(drawRect) - 70.0), (CGRectGetMinY(drawRect) - 20.0), 35.0, 20.0);
        CGMutablePathRef pointerPath = createPathForUpPointer(pointerRect);
        
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, mTintColor);
        CGContextAddPath(context, pointerPath);
        CGContextFillPath(context);
        CGContextSaveGState(context);
        
        CFRelease(pointerPath);
    }
    else if (mAutoType == MKTableCellPopoutAbove) {
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

#pragma mark - Displaying

- (void)showFromCell:(MKTableCell *)cell onView:(UITableView *)tableView {
    CGRect cellRect = [tableView rectForRowAtIndexPath:cell.indexPath];
    mAnimationType = MKViewAnimationTypeFadeIn;
    mIndexPath = [cell.indexPath retain];
    
    if (mType != MKTableCellPopoutAuto) {
        mAutoType = mType;
    }
    else {
        if (CGRectGetMaxY(cellRect) < (tableView.bounds.size.height - (mView.frame.size.height + 50.0))) {
            mAutoType = MKTableCellPopoutBelow;
        }
        else {
            mAutoType = MKTableCellPopoutAbove;
        }
    }
    
    if (mAutoType == MKTableCellPopoutBelow) {
        self.frame = CGRectMake(cellRect.origin.x, (cellRect.origin.y + cellRect.size.height), self.width, self.height);
        mView.frame = CGRectMake(10.0, 10.0, kPopoutViewWidth, mView.frame.size.height);
    }
    else if (mAutoType == MKTableCellPopoutAbove) {
        self.frame = CGRectMake(cellRect.origin.x, (cellRect.origin.y - self.frame.size.height), self.width, self.height);
        mView.frame = CGRectMake(0.0, 0.0, kPopoutViewWidth, mView.frame.size.height);
        
        [tableView scrollRectToVisible:self.frame animated:YES];
    }
    
    [self setNeedsDisplay];
    
    [tableView addSubview:self];
    [tableView scrollRectToVisible:self.frame animated:YES];
    
    [UIView animateWithDuration:0.25 
                     animations: ^ { self.alpha = 1.0; } ];
}

#pragma mark - Elements

- (void)setDiscloserButtonWithTarget:(id)target selector:(SEL)selector {
    mView.frame = CGRectMake(mView.frame.origin.x, mView.frame.origin.y, (mView.frame.size.width - 33.0), mView.frame.size.height);
    
    MKButton *button = [[MKButton alloc] initWithType:MKButtonTypeDiscloser];
    button.center = CGPointMake((CGRectGetMaxX(self.frame) - 25.0), CGRectGetMidY(mView.frame));
    
    [button completedAction: ^ (MKAction action) {
        if (action == MKActionTouchUp) {
            [target performSelector:selector withObject:mIndexPath];
        }
    }];
    
    [self addSubview:button];
    [button release];
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
    [mIndexPath release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MK_TABLE_CELL_POPOUT_VIEW_SHOULD_REMOVE_NOTIFICATION object:nil];
    
    [super dealloc];
}

@end
