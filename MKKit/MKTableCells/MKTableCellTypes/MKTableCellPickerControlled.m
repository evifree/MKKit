//
//  MKTableCellPickerControlled.m
//  MKKit
//
//  Created by Matthew King on 11/11/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKTableCellPickerControlled.h"
#import "MKDeffinitions.h"

@interface MKTableCellPickerControlled ()

- (void)showPickerInRect:(CGRect)frame;

@end


@implementation MKTableCellPickerControlled

@synthesize pickerLabel=mPickerLabel, pickerDate=mPickerDate, 
pickerView=_pickerView, owner=_owner;

@synthesize pickerFrame=_pickerFrame, pickerType, pickerSubType, 
pickerArray=_pickerArray;

@synthesize displayed=mDisplayed;

- (id)initWithType:(MKTableCellType)cellType reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithType:MKTableCellTypeNone reuseIdentifier:reuseIdentifier];
	if (self) {
        mCellView = [[MKView alloc] initWithCell:self];
        [self.contentView addSubview:mCellView];
        [mCellView release];
		
		mTheLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		mTheLabel.adjustsFontSizeToFitWidth = YES;
		mTheLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		mTheLabel.backgroundColor = [UIColor clearColor];
		
        [mCellView addPrimaryElement:mTheLabel];
		[mTheLabel release];
		
		mPickerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        mPickerLabel.backgroundColor = [UIColor clearColor];
		mPickerLabel.textAlignment = UITextAlignmentCenter;
		mPickerLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		mPickerLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
		
        [mCellView addSecondaryElement:mPickerLabel];
        [mPickerLabel release];
		
		mDisplayed = NO;
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doneButtonTouched:) name:PICKER_SHOULD_DISMISS_NOTIFICATION object:nil];
    }
    return self;
}

#pragma mark Accessor Methods

- (void)setPickerArray:(NSArray *)array {
	_pickerArray = [array retain];
}

#pragma mark Cell Behaivor

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
	if (selected) {
		if (!mDisplayed) {
			[self showPickerInRect:_pickerFrame];
		}
	}
}

#pragma mark PickerControlledCell Methods

- (void)showPickerInRect:(CGRect)frame {
	CGRect viewFrame = CGRectMake(0.0, 481.0, 320.0, 260.0);
	CGRect pickerRec = CGRectMake(0.0, 221.0, 320.0, 260.0);
	
	_pickerView = [[MKPickerView alloc] initWithFrame:viewFrame cell:self];
	_pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
	
    [[[UIApplication sharedApplication] keyWindow] addSubview:_pickerView];
    [_owner.view addSubview:_pickerView];
		
	[UIView animateWithDuration:0.25
					 animations: ^ { _pickerView.frame = pickerRec; }];
	
	if ([delegate respondsToSelector:@selector(didAddPicker:forKey:)]) {
		[delegate didAddPicker:_pickerView forKey:self.key];
	}
	
	mDisplayed = YES;
	
	[[NSNotificationCenter defaultCenter] postNotificationName:PICKER_DID_SHOW_NOTIFICATION object:self userInfo:nil];
}

- (void)changeDate:(UIDatePicker *)sender {
	MKStrings *string = [[MKStrings alloc] init];
	
	if (pickerType == MKTableCellPickerTypeDate) {
		mPickerDate = [sender.date retain];
		[mPickerDate release];
		
		if ([delegate respondsToSelector:@selector(valueDidChange:forKey:)]) {
			[delegate valueDidChange:sender.date forKey:self.key];
		}
		if (pickerSubType == MKTableCellDatePickerModeDate) {
			self.pickerLabel.text = [string date:sender.date withFormat:@"MMM dd, yyyy"];
		}
		if (pickerSubType == MKTableCellDatePickerModeTime) {
			self.pickerLabel.text = [string date:sender.date withFormat:@"hh:mm.ss"];
		}
		if (pickerSubType == MKTableCellDatePickerModeDateAndTime) {
			self.pickerLabel.text = [string date:sender.date withFormat:@"MMM dd, yyyy hh:mm.ss"];
 		}
	}
	
	[self setSelected:NO animated:NO];
	[string release];
}

- (void)doneButtonTouched:(id)sender {
	if (mDisplayed) {
		if ([delegate respondsToSelector:@selector(willRemovePicker:forKey:)]) {
			[delegate willRemovePicker:_pickerView forKey:self.key];
		}
		
		CGRect newFrame = CGRectMake(0.0, 481.0, 320.0, 260.0);
		[UIView animateWithDuration:0.25 
						 animations: ^ { _pickerView.frame = newFrame; }
						 completion: ^ (BOOL finished) { [_pickerView removeFromSuperview]; [_pickerView release]; }];
	
		mDisplayed = NO;
	}
}

#pragma mark Pickers
#pragma mark Delegate 

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [self.pickerArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	if ([delegate respondsToSelector:@selector(valueDidChange:forKey:)]) {
		NSNumber *index = [NSNumber numberWithInteger:row];
		[delegate valueDidChange:index forKey:self.key];
	}
	
	self.pickerLabel.text = [self.pickerArray objectAtIndex:row];
}

#pragma mark Data Source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [self.pickerArray count];
}

#pragma mark Memory Managment

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:PICKER_SHOULD_DISMISS_NOTIFICATION object:nil];
	
	[_pickerArray release];
	[super dealloc];
}

@end

//---------------------------------------------------------------------------------------------------------------
//MKPickerView

#pragma mark -
#pragma mark MKPickerView

@interface MKPickerView ()

- (UIView *)assignPicker;

@end

@implementation MKPickerView

@synthesize pickerCell;

#pragma mark Initalizer

- (id)initWithFrame:(CGRect)frame cell:(MKTableCellPickerControlled *)cell {
	self = [super initWithFrame:frame];
	if (self) {
		self.autoresizesSubviews = YES;
		
		self.pickerCell = [cell retain];
		
		UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, 44.0)];
		toolbar.barStyle = UIBarStyleBlackOpaque;
		toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		
		UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self.pickerCell action:@selector(doneButtonTouched:)];
		
		NSArray *items = [NSArray arrayWithObjects:space, done, nil];
		toolbar.items = items;
		
		[space release];
		[done release];
		
		[self addSubview:toolbar];
		[toolbar release];
		
		UIView *picker = [self assignPicker];
		
		[self addSubview:picker];
	}
	return self;
}

#pragma mark Drawing

- (UIView *)assignPicker {
	if (self.pickerCell.pickerType == MKTableCellPickerTypeStandard) {
		UIPickerView *aPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0, 44.0, 320.0, 216.0)];
		aPicker.showsSelectionIndicator = YES;
		aPicker.delegate = self.pickerCell;
		aPicker.dataSource = self.pickerCell;
		aPicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		
		[aPicker selectRow:0 inComponent:0 animated:NO];
		
		self.pickerCell.pickerLabel.text = [self.pickerCell.pickerArray objectAtIndex:0];
		
		if ([self.pickerCell.delegate respondsToSelector:@selector(valueDidChange:forKey:)]) {
			NSNumber *row = [NSNumber numberWithInteger:0];
			[self.pickerCell.delegate valueDidChange:row forKey:self.pickerCell.key];
		}
		
		return [aPicker autorelease];
	}
	
	if (self.pickerCell.pickerType == MKTableCellPickerTypeDate) {
		UIDatePicker *aDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, 320.0, 216.0)];
		aDatePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		
		UIDatePickerMode mode = UIDatePickerModeDate;
		switch (self.pickerCell.pickerSubType) {
			case MKTableCellDatePickerModeDate:
				mode = UIDatePickerModeDate;
				break;
			case MKTableCellDatePickerModeTime:
				mode = UIDatePickerModeTime;
				break;
			case MKTableCellDatePickerModeDateAndTime:
				mode = UIDatePickerModeDateAndTime;
				break;
			case MKTableCellDatePickerModeCountdown:
				mode = UIDatePickerModeCountDownTimer;
				break;
			default:
				break;
		}
		
		aDatePicker.datePickerMode = mode;
		[aDatePicker setDate:[NSDate date] animated:YES];
		[aDatePicker addTarget:self.pickerCell action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
		
		MKStrings *string = [[MKStrings alloc] init];
		self.pickerCell.pickerLabel.text = [string date:aDatePicker.date withFormat:@"MMM dd, yyyy"];
		[string release];
		
		if ([self.pickerCell.delegate respondsToSelector:@selector(valueDidChange:forKey:)]) {
			[self.pickerCell.delegate valueDidChange:aDatePicker.date forKey:self.pickerCell.key];
		}
		return [aDatePicker autorelease];
	}
	return nil;
}

#pragma mark Memory Managment

- (void)dealloc {
	[super dealloc];
	
}

@end

