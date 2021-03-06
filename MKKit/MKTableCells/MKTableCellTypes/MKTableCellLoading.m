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

- (id)initWithType:(MKTableCellType)cellType reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithType:MKTableCellTypeNone reuseIdentifier:reuseIdentifier];
    if (self) {
        mTheLabel = [[UILabel alloc] initWithFrame:CGRectMake(109.0, 11.0, 82.0, 21.0)];
        mTheLabel.backgroundColor = CLEAR;
        mTheLabel.textAlignment = UITextAlignmentLeft;
        mTheLabel.text = @"Loading";
        
        [self.contentView addSubview:mTheLabel];
        [mTheLabel release];
        
        mActivityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(182.0, 12.0, 20.0, 20.0)];
        mActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [mActivityIndicator startAnimating];
        
        [self.contentView addSubview:mActivityIndicator];
        [mActivityIndicator release];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

@end
