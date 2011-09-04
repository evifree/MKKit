//
//  MKTabbedView.m
//  MKKit
//
//  Created by Matthew King on 8/4/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKTabbedView.h"

@interface MKTabbedView ()

- (void)setTab:(MKTabItem *)tab forIndex:(NSInteger)index;

@end

@implementation MKTabbedView

@synthesize dataSource=mDataSource, tabbedDelegate=mTabbedDelegate;

#pragma mark - Initalizer

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = YES;
        self.alpha = 1.0;
        self.autoresizesSubviews = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        mShouldRemoveView = NO;
        
        mTabView = [[MKTabView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 45.0)];
        mTabView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:mTabView];
        [mTabView release];
        
        mContentView = [[MKView alloc] initWithFrame:CGRectMake(0.0, 45.0, 320.0, 415.0)];
        mContentView.backgroundColor = MK_COLOR_HSB(345.0, 2.0, 86.0, 1.0);
        mContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:mContentView];
        [mContentView release];
    }
    return self;
}

#pragma mark - Layout

- (void)setTabs {
    tabs = [[self.dataSource tabsForView:self] retain];
    
    if ([tabs count] > 3) {
        NSException *exception = [NSException exceptionWithName:@"Invalid Array" reason:@"MKTabbedViewDataSource cannot return an Array of more than 3 objects." userInfo:nil];
        [exception raise];
    }
    
    for (int i = 0; i < 3; i++) {
        [self setTab:[tabs objectAtIndex:i] forIndex:i];
    }
}

- (void)setTab:(MKTabItem *)tab forIndex:(NSInteger)index; {
    CGRect tabRect = CGRectMake(10.0, 3.0, 100.0, 42.0);
    tab.frame = tabRect;
    
    if (index == 1) {
        tab.x = 110.0;
    }
    else if (index == 2) {
        tab.x = 210.0;
    }
    
    tab.tabbedView = self;
    tab.index = index;
    [mTabView addSubview:tab];
    
    [self switchToTabAtIndex:0];
}

- (void)switchToTabAtIndex:(NSInteger)index {
    UIView *view = [self.dataSource viewForTabAtIndex:index];
    view.tag = 1;
    
    UIView *currentView = [mContentView viewWithTag:1];
    
    if (currentView) {
        [currentView removeFromSuperview];
    }
    
    [mContentView addSubview:view];
    
    for (MKTabItem *tab in tabs) {
        if (tab.index == index) {
            tab.selected = YES;
        }
        else {
            tab.selected = NO;
        }
    }
    
    [self.tabbedDelegate tabbedView:self didSelectTabAtIndex:index];
}

#pragma mark - Getting Tabs

- (MKTabItem *)tabAtIndex:(NSInteger)index {
    return [tabs objectAtIndex:index];
}

#pragma mark - Memory Management

- (void)dealloc {
    [tabs release];
    [super dealloc];
}

@end

@implementation MKTabView

#pragma mark - Initalizer

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = GRAY;
        
        mShouldRemoveView = NO;
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, DARK_GRAY.CGColor);
    CGContextSetLineWidth(context, 1.0);
    CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

#pragma mark - Memory Managment

- (void)dealloc {
    [super dealloc];
}

@end