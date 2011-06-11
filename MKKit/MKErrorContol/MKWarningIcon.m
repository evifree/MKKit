//
//  MKWarningIcon.m
//  MKKit
//
//  Created by Matthew King on 1/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MKWarningIcon.h"


#pragma mark -
#pragma mark MKWarningIcon

@implementation MKWarningIcon

@synthesize error=_error;

static UIImageView *warningIcon = nil;

#pragma mark Initalizer

- (id)initWithTextField:(MKTextField *)textField {
	self = [super init];
	if (self) {
		_textField = [textField retain];
		_error = [textField.error retain];
		
		self.userInteractionEnabled = YES;
		
		warningIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MK_WARNING_ICON]];
		[self addSubview:warningIcon];
	}
	return self;
}

- (id)initWithError:(NSError *)anError {
	self = [super init];
	if (self) {
		_error = [anError retain];
		self.userInteractionEnabled = YES;
		
		warningIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MK_WARNING_ICON]];
		[self addSubview:warningIcon];		
	}
	return self;
}

#pragma mark Drawing Methods

- (void)fitToRect:(CGRect)rect {
	warningIcon.frame = rect;
}

- (void)drawToRight {
	warningIcon.frame = CGRectMake(0.0, 0.0, _textField.frame.size.height, _textField.frame.size.height);
}

#pragma mark Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	NSInteger taps = [touch tapCount];
	
	if (taps == 1) {
		MKErrorHandeling *handeler = [[MKErrorHandeling alloc] init];
		[handeler applicationDidError:_error];
		[handeler release];
	}
}

#pragma mark Memory Managment

- (void)dealloc {
	[_textField release];
	[_error release];
	[warningIcon release];
	
	[super dealloc];
}

@end
