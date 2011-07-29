//
//  MKCheckBox.m
//  MKKit
//
//  Created by Matthew King on 10/3/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKCheckBox.h"


@implementation MKCheckBox

@synthesize boxChecked=_boxChecked;

#pragma mark -
#pragma mark Initailization

- (id)initWithFrame:(CGRect)aRect {
    self = [super initWithFrame:aRect];
	if (self) {
		NSString *path = [[NSBundle mainBundle] pathForResource:@"checkBox" ofType:@"png"];
		
		UIImage *box = [[UIImage alloc] initWithContentsOfFile:path];
		UIImageView *boxView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
		boxView.image = box;
		
		[self addSubview:boxView];
		
		[box release];
		[boxView release];
		
		_boxChecked = NO;
		self.userInteractionEnabled = YES;
	}
	return self;
}

#pragma mark -
#pragma mark Accesor Methods

- (void)setBoxChecked:(BOOL)checked {
	if (checked) {
		NSString *path = [[NSBundle mainBundle] pathForResource:@"checkmark" ofType:@"png"];
		UIImage *checkMark = [[UIImage alloc] initWithContentsOfFile:path];
		
		checkMarkView = [[UIImageView alloc] initWithFrame:CGRectMake(2.0, 2.0, 25.0, 25.0)];
		checkMarkView.image = checkMark;
		
		[self addSubview:checkMarkView];
		[checkMark release];
		
		_boxChecked = YES;
	}
	else {
		if (checkMarkView) {
			[checkMarkView removeFromSuperview];
			[checkMarkView release];
		}
		_boxChecked = NO;
	}
}	

#pragma mark -
#pragma mark Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	NSInteger taps = [touch tapCount];
	
	if (taps == 1) {
		if (!_boxChecked) {
			NSString *path = [[NSBundle mainBundle] pathForResource:@"checkmark" ofType:@"png"];
			UIImage *checkMark = [[UIImage alloc] initWithContentsOfFile:path];
			
			checkMarkView = [[UIImageView alloc] initWithFrame:CGRectMake(2.0, 2.0, 25.0, 25.0)];
			checkMarkView.image = checkMark;
			
			[self addSubview:checkMarkView];
			[checkMark release];
			
			_boxChecked = YES;
		}
		else {
			[checkMarkView removeFromSuperview];
			[checkMarkView release];
			
			_boxChecked = NO;
		}
		[self sendActionsForControlEvents:UIControlEventValueChanged];
	}
}

#pragma mark -
#pragma mark Memory Managment

- (void)dealloc {
	[super dealloc];
}

@end
