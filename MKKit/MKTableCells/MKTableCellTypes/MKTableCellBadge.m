//
//  MKTableCellBadge.m
//  MKKit
//
//  Created by Matthew King on 6/12/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKTableCellBadge.h"

@implementation MKTableCellBadge

@synthesize badgeText, badgeColor;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithType:MKTableCellTypeNone reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.autoresizesSubviews = YES;
        
        mBadgeCellView = [[MKBadgeCellView alloc] initWithFrame:self.contentView.frame];
        
        CGRect labelRect = CGRectMake(10.0, 10.0, 170.0, 21.0);
		
		mTheLabel = [[UILabel alloc] initWithFrame:labelRect];
		mTheLabel.textAlignment = UITextAlignmentLeft;
		mTheLabel.adjustsFontSizeToFitWidth = NO;
		mTheLabel.minimumFontSize = 10.0;
        mTheLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
		
		[mBadgeCellView addSubview:mTheLabel];
        [mTheLabel release];

        [self.contentView addSubview:mBadgeCellView];
        [mBadgeCellView release];
    }
    return self;
}
 
#pragma mark - Accessor Methods

- (void)setBadgeText:(NSString *)text {
    mBadgeCellView.badgeText = text;
}

- (void)setBadgeColor:(UIColor *)color {
    mBadgeCellView.badgeColor = color;
}
 
#pragma mark - Memory Managment

- (void)dealloc {
    [super dealloc];
}

@end

@implementation MKBadgeCellView

@synthesize label=mLabel, badgeText, badgeColor;

#pragma mark - Ininializer

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CLEAR;
        self.alpha = 1.0;
        self.opaque = NO;
        
        self.autoresizesSubviews = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        maxWidth = 30.0;
        mBadgeColor = GRAY.CGColor;
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGRect rrect = CGRectMake((280.0 - maxWidth), 10.0, maxWidth, 22.0);
    
    CGMutablePathRef roundRectPath = createRoundedRectForRect(rrect, 10.0);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, mBadgeColor);
    CGContextAddPath(context, roundRectPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    CFRelease(roundRectPath);
    
    if (mBadgeLabel) {
        [mBadgeLabel drawTextInRect:rrect];
    }
}

#pragma mark - Accessor Methods

- (void)setBadgeText:(NSString *)text {
    CGSize max = [text sizeWithFont:SYSTEM_BOLD(12)];
    
    if (max.width > maxWidth) {
        maxWidth = (max.width + 20.0);
    }
    
    CGRect rect = CGRectMake((280.0 - maxWidth), 10.0, maxWidth, 22.0);
    
    if (!mBadgeLabel) {
        mBadgeLabel = [[UILabel alloc] initWithFrame:rect];
        mBadgeLabel.backgroundColor = CLEAR;
        mBadgeLabel.font = SYSTEM_BOLD(12);
        mBadgeLabel.textAlignment = UITextAlignmentCenter;
        mBadgeLabel.textColor = WHITE;
        mBadgeLabel.shadowColor = BLACK;
        mBadgeLabel.shadowOffset = CGSizeMake(0.0, -1.0);
        mBadgeLabel.text = text;
        mBadgeLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    }
    else {
        mBadgeLabel.frame = rect;
        mBadgeLabel.text = text;
    }
    
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
