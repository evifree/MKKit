//
//  MKTableCellLoading.m
//  MKKit
//
//  Created by Matthew King on 5/28/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKTableCellLoading.h"

@implementation MKTableCellLoading

@synthesize activityIndicator=mActivityIndicator;

@dynamic working;

#pragma mark - Creation

- (id)initWithType:(MKTableCellType)cellType reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithType:MKTableCellTypeNone reuseIdentifier:reuseIdentifier];
    if (self) {
        mCellView = [[MKView alloc] initWithCell:self];
        
        mTheLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        mTheLabel.backgroundColor = CLEAR;
        mTheLabel.textAlignment = UITextAlignmentCenter;
        mTheLabel.text = @"Loading";
        
        [mCellView addPrimaryElement:mTheLabel];
        [mTheLabel release];
        
        mActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
        mActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        mActivityIndicator.hidesWhenStopped = YES;
        self.working = YES;
        
        [mCellView addSubview:mActivityIndicator];
        [mActivityIndicator release];
        
        [self.contentView addSubview:mCellView];
        [mCellView release];
    }
    return self;
}

#pragma mark - Mememory Management

- (void)dealloc {
    self.activityIndicator = nil;
    
    [super dealloc];
}

#pragma mark - Accessor Methods
#pragma mark Setters

- (void)setWorking:(BOOL)_working {
    MKTableCellLoadingFlags.isWorking = _working;
    
    if (_working) {
        CGFloat legthOfText = MK_TEXT_WIDTH(mTheLabel.text, mTheLabel.font);
        CGFloat centerOfText = mTheLabel.center.x;
        CGRect activityIndicorRect = CGRectMake((centerOfText + (legthOfText / 2.0) + 15.0), 12.0, 20.0, 20.0);
        
        mActivityIndicator.frame = activityIndicorRect;
        [mActivityIndicator startAnimating];
    }
    else {
        [mActivityIndicator stopAnimating];
    }
}

- (BOOL)working {
    return MKTableCellLoadingFlags.isWorking;
}

@end
