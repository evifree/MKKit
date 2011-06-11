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

static float kItemWidth     = 60.0;  
static float kItemHeight    = 80.0;
static float kVertPadding   = 10.0;
static float kHorzPadding   = 20.0;

@synthesize items=mItems;

#pragma mark - Initalizer

- (id)initWithItems:(NSArray *)items {
    self = [super initWithFrame:[self frameForItems:[items count]]];
    if (self) {
        if ([items count] > 12) {
            NSException *exception = [NSException exceptionWithName:@"To Many Items" reason:@"MKMenuView may not have more than 12 items" userInfo:nil];
            [exception raise];
            
            return nil;
        }
        
        self.alpha = 0.0;
        mItems = [items copy];
        
        UIImageView *menu = [[UIImageView alloc] initWithFrame:[self frameForItems:[items count]]];
        menu.image = [UIImage imageNamed:MK_MENU_VIEW_BACKGROUND_IMAGE];
        
        [self addSubview:menu];
        [menu release];
        
        [self placeItems];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldRemove:) name:MK_MENU_VIEW_SHOULD_REMOVE_NOTIFICATION object:nil];
    }
    return self;
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
