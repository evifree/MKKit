//
//  MKTableCell.m
//  MKKit
//
//  Created by Matthew King on 3/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MKTableCell.h"

@interface MKTableCell ()

- (void)accessoryButton:(id)sender;

@end

@implementation MKTableCell

@synthesize delegate, type, theLabel=mTheLabel, smallLabel=_smallLabel, theImageView=mTheImageView, key,
			accessoryViewType, validationType=_validationType, validating=_validating, validator, icon=mIcon;

#pragma mark --
#pragma mark StartUp

- (id)initWithType:(MKTableCellType)cellType reuseIdentifier:(NSString *)reuseIdentifier {
	self.type = cellType;
	
	[self.detailTextLabel removeFromSuperview];
	[self.textLabel removeFromSuperview];
	[self.imageView removeFromSuperview];
	
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	
	return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		CGRect labelFrame = CGRectMake(10.0, 11.0, 100.0, 21.0);
				
		mTheLabel = [[UILabel alloc] initWithFrame:labelFrame];
		mTheLabel.textAlignment = UITextAlignmentLeft;
		mTheLabel.adjustsFontSizeToFitWidth = YES;
		mTheLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		mTheLabel.backgroundColor = [UIColor clearColor];
		
		/////////////////////////////////////////////////////////////////////////////////////////////////
		///                 MKTableCellTypeLabel                                                      ///
		
		if (type == MKTableCellTypeLabel) {
			CGRect labelRect = CGRectMake(10.0, 11.0, 230.0, 21.0);
			
			mTheLabel.frame = labelRect;
			mTheLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
			mTheLabel.textAlignment = UITextAlignmentLeft;
			mTheLabel.adjustsFontSizeToFitWidth = NO;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////
		///                 MKTableCellTypeDescription                                                ///
		
		if (type == MKTableCellTypeDescription) {
			CGRect smallFrame = CGRectMake(207.0, 9.0, 83.0, 21.0);
			CGRect labelRect = CGRectMake(10.0, 11.0, 190.0, 21.0);
			
			mTheLabel.frame = labelRect;
			mTheLabel.textAlignment = UITextAlignmentLeft;
			
			_smallLabel = [[UILabel alloc] initWithFrame:smallFrame];
			_smallLabel.textAlignment = UITextAlignmentRight;
			_smallLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			_smallLabel.adjustsFontSizeToFitWidth = YES;
			_smallLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
			
			[self.contentView addSubview:_smallLabel];
			[_smallLabel release];
		}
				
		/////////////////////////////////////////////////////////////////////////////////////////////////
		///                 MKTableCellTypeScore                                                      ///
		
		if (type == MKTableCellTypeScore) {
			CGRect iconRect = CGRectMake(10.0, 7.0, 30.0, 30.0);
			CGRect labelRect = CGRectMake(18.0, 11.0, 90.0, 21.0);
			CGRect smallFrame = CGRectMake(162.0, 11.0, 98.0, 21.0);
			
			mTheLabel.frame = labelRect;
			mTheLabel.textAlignment = UITextAlignmentLeft;
			
			_smallLabel = [[UILabel alloc] initWithFrame:smallFrame];
			_smallLabel.textAlignment = UITextAlignmentRight;
			_smallLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			_smallLabel.adjustsFontSizeToFitWidth = YES;
			_smallLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
			
			mTheImageView = [[[UIImageView alloc] initWithFrame:iconRect] retain];
			
			[self.contentView addSubview:mTheImageView];
			[self.contentView addSubview:_smallLabel];
			
			self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			
			[mTheImageView release];
			[_smallLabel release];
		}
		
		if (type == MKTableCellTypeAction) {
			CGRect iconRect = CGRectMake(10.0, 7.0, 30.0, 30.0);
			CGRect labelRect = CGRectMake(58.0, 11.0, 203.0, 21.0);
			
			mTheLabel.frame = labelRect;
			mTheLabel.textAlignment = UITextAlignmentLeft;
			mTheLabel.adjustsFontSizeToFitWidth = YES;
			mTheLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			mTheLabel.backgroundColor = [UIColor clearColor];
			
			mTheImageView = [[[UIImageView alloc] initWithFrame:iconRect] retain];
			
			[self.contentView addSubview:mTheImageView];
			
			[mTheImageView release];
		}
		
		if (type == MKTableCellTypeButton) {
			mTheImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 44.0)];
			mTheImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
			[self.contentView addSubview:mTheImageView];
			[mTheImageView release];
			
			mTheLabel.frame = CGRectMake(0.0, 0.0, 300.0, 44.0);
			mTheLabel.textAlignment = UITextAlignmentCenter;
			mTheLabel.backgroundColor = [UIColor clearColor];
			mTheLabel.adjustsFontSizeToFitWidth = YES;
			mTheLabel.font = [UIFont boldSystemFontOfSize:17.0];
		}
		
		[self.contentView addSubview:mTheLabel];
		[self.contentView setAutoresizesSubviews:YES];
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
		
		mTheLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
		[mTheLabel release];
	}
	return self;
}
	
#pragma mark -
#pragma mark Accessor Methods

- (void)setAccessoryViewType:(MKTableCellAccessoryViewType)aType {
	if (aType == MKTableCellAccessoryNone) {
		self.accessoryView = nil;
	}
	if (aType == MKTableCellAccessoryInfoButton) {
		UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoDark];
		[button addTarget:self action:@selector(accessoryButton:) forControlEvents:UIControlEventTouchUpInside];
		self.accessoryView = button;
	}
	if (aType == MKTableCellAccessoryWarningIcon) {
		UIImageView *iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MK_TABLE_CELL_WARNING_ICON]];
		iconImage.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
		self.accessoryView = iconImage;
		[iconImage release];
	}
    if (aType == MKTableCellAccessoryGlobe) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:MK_TABLE_CELL_GLOBE_ICON] forState:UIControlStateNormal];
		[button addTarget:self action:@selector(accessoryButton:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
		self.accessoryView = button;
    }
    if (aType == MKTableCellAccessoryActivity) {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [activityIndicator startAnimating];
        
        self.accessoryView = activityIndicator;
        [activityIndicator release];
    }
}

- (void)setValidationType:(MKValidationType)valType {
	_validationType = valType;
	
	if (valType == MKValidationNone) {
		_validating = NO;
		validator = nil;
	}
	else {
		_validating = YES;
		validator = [[MKValidator alloc] init];
		[validator retain];
	}
}

- (void)setIcon:(UIImage *)anImage {
	mIcon = [anImage retain];
	self.theImageView.image = mIcon;
	[mIcon release];
}

#pragma mark -
#pragma mark Cell behavior

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        if ([delegate respondsToSelector:@selector(didSelectCell:forKey:)]) {
            [delegate didSelectCell:self forKey:self.key];
        }
    }
	
}

#pragma mark -
#pragma mark Validation Methods

- (void)validateWithType:(MKValidationType)aType {
	//Impelmented by suclasses
}

#pragma mark -
#pragma mark Actions

- (void)accessoryButton:(id)sender {
	if ([self.delegate respondsToSelector:@selector(didTapAccessoryForKey:)]) {
		[self.delegate didTapAccessoryForKey:self.key];
	}
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
    [super dealloc];
	
}


@end
