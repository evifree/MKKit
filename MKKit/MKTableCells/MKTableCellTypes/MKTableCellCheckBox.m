//
//  MKTableCellCheckBox.m
//  MKKit
//
//  Created by Matthew King on 11/11/10.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import "MKTableCellCheckBox.h"

@interface MKTableCellCheckBox ()

- (void)boxWasChecked:(id)sender;

@end


@implementation MKTableCellCheckBox

@synthesize checkBox=mCheckBox;

- (id)initWithType:(MKTableCellType)cellType reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithType:MKTableCellTypeNone reuseIdentifier:reuseIdentifier];
    if (self) {
        mCellView = [[MKView alloc] initWithCell:self];
        
        mTheLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		mTheLabel.textAlignment = UITextAlignmentLeft;
		mTheLabel.adjustsFontSizeToFitWidth = YES;
		mTheLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		mTheLabel.backgroundColor = [UIColor clearColor];
		mTheLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
		
		[mCellView addPrimaryElement:mTheLabel];
		[mTheLabel release];
		
		mCheckBox = [[MKCheckBox alloc] initWithType:MKCheckBoxRound];
		[mCheckBox addTarget:self selector:@selector(boxWasChecked:) action:MKActionValueChanged];
		
		[mCellView addIconElement:mCheckBox];
		[mCheckBox release];
		
        [self.contentView addSubview:mCellView];
        [mCellView release];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

#pragma mark -
#pragma mark CheckBox Methods

- (void)boxWasChecked:(id)sender {
	if ([delegate respondsToSelector:@selector(valueDidChange:forKey:)]) {
		NSNumber *checked = [NSNumber numberWithBool:self.checkBox.boxChecked];
		[delegate valueDidChange:checked forKey:self.key];
	}
}

- (void)dealloc {
    [super dealloc];
}


@end
