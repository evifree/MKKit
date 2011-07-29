//
//  MKTableCellSegmented.m
//  MKKit
//
//  Created by Matthew King on 11/11/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKTableCellSegmented.h"

@interface MKTableCellSegmented ()

- (void)segmentChanged:(id)sender;

@end


@implementation MKTableCellSegmented

@synthesize segmentedControl=_segmentedContorl, segmentItems=_segmentItems;

- (id)initWithType:(MKTableCellType)type reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithType:MKTableCellTypeNone reuseIdentifier:reuseIdentifier];
    if (self) {
		_segmentedContorl = [[UISegmentedControl alloc] initWithFrame:self.contentView.frame];
		_segmentedContorl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
		[_segmentedContorl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
		
		[self.contentView addSubview:_segmentedContorl];
		
		[_segmentedContorl release];		
		
    }
    return self;
}

#pragma mark -
#pragma mark Accessor Methods

- (void)setSegmentItems:(NSArray *)items {
	_segmentItems = [items retain];
	
	if (self.segmentedControl.numberOfSegments < [items count]) {
		for (int i = 0; i < [items count]; i++) {
			[self.segmentedControl insertSegmentWithTitle:[items objectAtIndex:i] atIndex:i animated:NO];
		}
	}
	
	[_segmentItems release];
}

#pragma mark -
#pragma mark Cell Behavior

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

#pragma mark -
#pragma mark Segmented Control Methods

- (void)segmentChanged:(id)sender {
	if ([delegate respondsToSelector:@selector(valueDidChange:forKey:)]) {
		NSNumber *pos = [NSNumber numberWithInteger:self.segmentedControl.selectedSegmentIndex];
		[delegate valueDidChange:pos forKey:self.key];
	}
}

#pragma mark -
#pragma mark Memory Managment

- (void)dealloc {
    [super dealloc];
}


@end
