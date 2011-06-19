//
//  MKTableCellBadge.m
//  MKKit
//
//  Created by Matthew King on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MKTableCellBadge.h"

@implementation MKTableCellBadge

@synthesize badgeText=mBadgeText, badgeColor=mBadgeColor;

CGFloat maxWidth = 30.0;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect labelRect = CGRectMake(10.0, 10.0, 170.0, 21.0);
		
		mTheLabel = [[UILabel alloc] initWithFrame:labelRect];
		mTheLabel.textAlignment = UITextAlignmentLeft;
		mTheLabel.adjustsFontSizeToFitWidth = NO;
		mTheLabel.minimumFontSize = 10.0;
        mTheLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
		
		[self.contentView addSubview:mTheLabel];
        self.contentView.autoresizesSubviews = YES;
		[mTheLabel release];
        
        mBadgeColor = [GRAY retain];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGRect rrect = CGRectMake((290.0 - maxWidth), 10.0, maxWidth, 22.0);
    
	CGFloat radius = 10.0;
    CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
	
	CGContextMoveToPoint(context, minx, midy);
	CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
	CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
	CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
	CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
	CGContextClosePath(context);

    CGContextSetFillColorWithColor(context, mBadgeColor.CGColor);
    CGContextFillPath(context);
    
    CGContextStrokePath(context);
}

#pragma mark - Accessor Methods

- (void)setBadgeText:(NSString *)badgeText {
    mBadgeText = [badgeText copy];
    
    CGSize max = [badgeText sizeWithFont:SYSTEM_BOLD(12)];
    
    if (max.width > maxWidth) {
        maxWidth = (max.width + 20.0);
    }
    
    CGRect rect = CGRectMake((290.0 - maxWidth), 10.0, maxWidth, 22.0);
    
    if (!mBadgeLabel) {
        mBadgeLabel = [[UILabel alloc] initWithFrame:rect];
        mBadgeLabel.backgroundColor = CLEAR;
        mBadgeLabel.font = SYSTEM_BOLD(12);
        mBadgeLabel.textAlignment = UITextAlignmentCenter;
        mBadgeLabel.textColor = WHITE;
        mBadgeLabel.shadowColor = BLACK;
        mBadgeLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        mBadgeLabel.text = mBadgeText;
        mBadgeLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        
        [self.contentView addSubview:mBadgeLabel];
        [mBadgeLabel release];
    }
    else {
        mBadgeLabel.frame = rect;
        mBadgeLabel.text = mBadgeText;
    }
    
    [self.contentView setNeedsLayout];
    [mBadgeText release];
}

- (void)setBadgeColor:(UIColor *)badgeColor {
    mBadgeColor = [badgeColor retain];
    [self.contentView setNeedsLayout];
}

#pragma mark - Memory Managment

- (void)dealloc {
    [mBadgeColor release];
    [super dealloc];
}

@end
