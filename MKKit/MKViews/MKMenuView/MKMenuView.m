//
//  MKMenuView.m
//  MKKit
//
//  Created by Matthew King on 5/25/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKMenuView.h"

@interface MKMenuView ()

- (CGRect)frameForItems:(NSInteger)items;
- (void)placeItems;

- (void)shouldRemove:(NSNotification *)notification;

@end

@implementation MKMenuView

void drawColoredPattern (void *info, CGContextRef context);

static float kItemWidth     = 60.0;  
static float kItemHeight    = 80.0;
static float kVertPadding   = 10.0;
static float kHorzPadding   = 20.0;

@synthesize items=mItems;

#pragma mark - Initalizer

- (id)initWithItems:(NSArray *)items {
    self = [super initWithFrame:[self frameForItems:[items count]]];
    if (self) {
        if ([items count] > 6) {
            NSException *exception = [NSException exceptionWithName:@"To Many Items" reason:@"MKMenuView may not have more than 6 items" userInfo:nil];
            [exception raise];
            
            return nil;
        }
        
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        self.alpha = 0.0;
        mItems = [items copy];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        
        [self placeItems];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldRemove:) name:MK_MENU_VIEW_SHOULD_REMOVE_NOTIFICATION object:nil];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGFloat outerMargin = 2.0;
    CGRect outerRect = CGRectInset(self.bounds, outerMargin, outerMargin);
    CGMutablePathRef outerPath = createRoundedRectForRect(outerRect, 20);
    
    CGColorRef fillColor = [UIColor colorWithHue:0 saturation:0 brightness:0.15 alpha:1.0].CGColor;
    CGColorRef outlineColor = GRAY.CGColor;
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, fillColor);
    CGContextAddPath(context, outerPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    static const CGPatternCallbacks callbacks = { 0, &drawColoredPattern, NULL };
    
    CGContextSaveGState(context);
    CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern(NULL);
    CGContextSetFillColorSpace(context, patternSpace);
    CGColorSpaceRelease(patternSpace);
    
    CGPatternRef pattern = CGPatternCreate(NULL, outerRect, CGAffineTransformIdentity, 24, 24, kCGPatternTilingConstantSpacing, true, &callbacks);
    
    CGFloat alpha = 1.0;
    CGContextSetFillPattern(context, pattern, &alpha);
    CGPatternRelease(pattern);
    CGContextAddPath(context, outerPath);
    CGContextClip(context);
    CGContextFillRect(context, outerRect);
    CGContextRestoreGState(context);
    
    drawOutlinePath(context, outerPath, 3.0, outlineColor); 
    
    CGPathRelease(outerPath);
}

void drawColoredPattern (void *info, CGContextRef context) {
    
    CGColorRef dotColor = [UIColor colorWithHue:0 saturation:0 brightness:0.07 alpha:1.0].CGColor;
    CGColorRef shadowColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.1].CGColor;
    
    CGContextSetFillColorWithColor(context, dotColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 1, shadowColor);
    
    CGContextAddArc(context, 3, 3, 4, 0, MK_D2R(360), 0);
    CGContextFillPath(context);
    
    CGContextAddArc(context, 16, 16, 4, 0, MK_D2R(360), 0);
    CGContextFillPath(context);
}

#pragma mark - Configuration

- (CGRect)frameForItems:(NSInteger)items {
    CGRect rtnRect = CGRectZero;
    
    CGFloat width = 0.0;
    CGFloat height = 0.0;
    mRows = 1;
    
    if (items > 3) {
        if (items == 6 || items == 9 || items == 12) {
            mRows = (items / 3);
        }
        else {
            mRows = ((items / 3) + 1);
        }
        width = ((3 * kItemWidth) + ((3 + 1 ) * kHorzPadding));
        height = ((kItemHeight * mRows) + (kVertPadding * (mRows + 1)));
    }
    else {
        width = ((items * kItemWidth) + ((items + 1 ) * kHorzPadding));
        height = (kItemHeight + (kVertPadding * 2));   
    }
    
    rtnRect = CGRectMake(0.0, 0.0, width, height);
    return rtnRect;
}

- (void)placeItems {
    int count = [mItems count];
    CGFloat x = 0.0;
    CGFloat y = kVertPadding;
    
    for (int i = 0; i < count; i++) {
        if (i < 3) {
            x = ((kHorzPadding + (kHorzPadding * i)) + (kItemWidth * i));
        }
        if (i >= 3 && i < 6) {
            x = ((kHorzPadding + (kHorzPadding * (i + 3)) + (kItemWidth * (i - 3))));
            y = ((kVertPadding * 2) + kItemHeight);
        }
        if (i >= 6 && i < 9) {
            x = ((kHorzPadding + (kHorzPadding * (i - 6)) + (kItemWidth * (i - 6))));
            y = ((kVertPadding + (kVertPadding * 2)) + (kItemHeight * 2));
        }
        if (i >= 9 && i < 12) {
            x = ((kHorzPadding + (kHorzPadding * (i - 9)) + (kItemWidth * (i - 9))));
            y = ((kVertPadding + (kVertPadding * 3)) + (kItemHeight * 3));
        }
        
        MKMenuItem *item = (MKMenuItem *)[mItems objectAtIndex:i];
        item.frame = CGRectMake(x, y, kItemWidth, kItemHeight);
        [self addSubview:item];
    }
    [mItems release];
}

#pragma mark - Notifications

- (void)shouldRemove:(NSNotification *)notification {
    [self removeView];
}

#pragma mark - Memory Management

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MK_MENU_VIEW_SHOULD_REMOVE_NOTIFICATION object:nil];
    
    [super dealloc];
}

@end
