//
//  MKTableCellCheckBox.m
//  MKKit
//
//  Created by Matthew King on 11/11/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKTableCellCheckBox.h"

@interface MKTableCellCheckBox ()

- (void)boxWasChecked:(id)sender;

@end


@implementation MKTableCellCheckBox

@synthesize checkBox=_checkBox;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithType:MKTableCellTypeNone reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect checkBoxRect = CGRectMake(10.0, 7.0, 30.0, 30.0);
		CGRect labelRect = CGRectMake(58.0, 11.0, 203.0, 21.0);
		
		mTheLabel = [[UILabel alloc] initWithFrame:labelRect];
		mTheLabel.textAlignment = UITextAlignmentLeft;
		mTheLabel.adjustsFontSizeToFitWidth = YES;
		mTheLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		mTheLabel.backgroundColor = [UIColor clearColor];
		
		[self.contentView addSubview:mTheLabel];
		[mTheLabel release];
		
		_checkBox = [[MKCheckBox alloc] initWithFrame:checkBoxRect];
		[_checkBox addTarget:self action:@selector(boxWasChecked:) forControlEvents:UIControlEventValueChanged];
		
		[self.contentView addSubview:_checkBox];
		
		[_checkBox release];		
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
