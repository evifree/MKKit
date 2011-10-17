//
//  MKTableCellSwitch.m
//  MKKit
//
//  Created by Matthew King on 11/1/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKTableCellSwitch.h"

@interface MKTableCellSwitch ()

- (void)switchFlipped:(id)sender;

@end

@implementation MKTableCellSwitch

@synthesize theSwitch=_theSwitch;

#pragma mark -
#pragma mark Initalizer

- (id)initWithType:(MKTableCellType)cellType reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithType:MKTableCellTypeNone reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect switchFrame = CGRectMake(198.3, 10.0, 172.0, 21.0);
		//CGRect labelFrame = CGRectMake(10.0, 11.0, 150.0, 21.0);
		
        mCellView = [[MKView alloc] initWithCell:self];
        
		mTheLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		mTheLabel.textAlignment = UITextAlignmentLeft;
		mTheLabel.adjustsFontSizeToFitWidth = YES;
		mTheLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		mTheLabel.backgroundColor = [UIColor clearColor];
		mTheLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
		
        [mCellView addPrimaryElement:mTheLabel];
		[mTheLabel release];
		
		_theSwitch = [[UISwitch alloc] initWithFrame:switchFrame];
		_theSwitch.on = NO;
		_theSwitch.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
		[_theSwitch addTarget:self action:@selector(switchFlipped:) forControlEvents:UIControlEventValueChanged];
		
        [mCellView addSecondaryElement:_theSwitch inRect:switchFrame];
		[_theSwitch release];
        
        [self.contentView addSubview:mCellView];
        [mCellView release];
    }
    return self;
}

#pragma mark -
#pragma mark Cell Behaivor

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
    [super setSelected:selected animated:animated];
	
    // Configure the view for the selected state
}

#pragma mark -
#pragma mark SwitchCell Methods

- (void)switchFlipped:(id)sender {
	if ([delegate respondsToSelector:@selector(valueDidChange:forKey:)]) {
		NSNumber *pos = [NSNumber numberWithBool:self.theSwitch.on];
		[delegate valueDidChange:pos forKey:self.key];
	}
}

#pragma mark -
#pragma mark Memory Managment

- (void)dealloc {
    [super dealloc];
}



@end
