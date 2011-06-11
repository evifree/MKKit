//
//  MKTextField.m
//  MKKit
//
//  Created by Matthew King on 1/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MKTextField.h"

#pragma mark -
#pragma mark MKTextField

@interface MKTextField ()

- (void)postValidationError:(NSError *)error animated:(BOOL)isAnimated;
- (void)beginEditing:(id)sender;
- (void)editingEnded:(id)sender;

- (void)displayIcon;

@end


@implementation MKTextField

@synthesize validator=_validator, error=_error, validated=_validated, animated, validationType, 
			automaticalyValidate, useInputAccessoryView, displayWarningIcon;

#pragma mark Initalizer

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.validationType = MKValidationNone;
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		self.validationType = MKValidationNone;
	}
	return self;
}

#pragma mark Acccesor Methods

- (void)setAutomaticalyValidate:(BOOL)autoVal {
	if (autoVal == YES) {
		[self addTarget:self action:@selector(editingEnded:) forControlEvents:UIControlEventEditingDidEnd];
		[self addTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventEditingDidBegin];
		_validator = [[MKValidator alloc] init];
	}
	if (autoVal == NO) {
		[self removeTarget:self action:@selector(editingEnded:) forControlEvents:UIControlEventEditingDidEnd];
		[self removeTarget:self action:@selector(beginEditing:) forControlEvents:UIControlEventEditingDidBegin];
	}
}

- (void)setUseInputAccessoryView:(BOOL)use {
	if (use) {
		MKInputAccessoryView *accessoryView = [[MKInputAccessoryView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
		accessoryView.textField = self;
		self.inputAccessoryView = accessoryView;
		[accessoryView release];
	}
	else {
		self.inputAccessoryView = nil;
	}

}

#pragma mark Validation Methods

- (void)validate {
	[self validateWithType:self.validationType];
}

- (void)validateWithType:(MKValidationType)type {
	NSError *valError = nil;
	
	if (type == MKValidateIsaNumber) {
		if ([_validator respondsToSelector:@selector(inputIsaNumber:)]) {
			if ([_validator inputIsaNumber:self.text]) {
				_validated = YES;
			}
			else {
				_validated = NO;
				valError = [NSError errorWithDomain:ERROR_DESCRIPTION_701 code:ERROR_CODE_701 userInfo:nil];
			}
		}
	}
	if (type == MKValidateHasLength) {
		if ([_validator respondsToSelector:@selector(inputHasLength:)]) {
			if ([_validator inputHasLength:self.text]) {
				_validated = YES;
			}
			else {
				_validated = NO;
				valError = [NSError errorWithDomain:ERROR_DESCRIPTION_702 code:ERROR_CODE_702 userInfo:nil];
			}
	 
		}
	}
	
	if (valError) {
		if (self.displayWarningIcon) {
			[self postValidationError:valError animated:self.animated];
			_error = [valError retain];
		}
	}
}

- (void)postValidationError:(NSError *)error animated:(BOOL)isAnimated {
	self.textColor = [UIColor redColor];
	
	CGRect newframe = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width - 30.0, self.frame.size.height);
	
	if (isAnimated) {
		[UIView animateWithDuration:0.25 
						 animations: ^ { self.frame = newframe; }
						 completion: ^ (BOOL finished) { [self displayIcon]; }];
	}
	else {
		self.frame = newframe;
		[self displayIcon];
	}	
}
		 
- (void)displayIcon {
	CGFloat x = self.frame.size.width + self.frame.origin.x + 5.0;
	CGFloat y = self.frame.origin.y; 
	
	CGRect viewFrame = CGRectMake(x, y, self.frame.size.height, self.frame.size.height);
	
	MKWarningIcon *warningIcon = [[MKWarningIcon alloc] initWithTextField:self];
	warningIcon.frame = viewFrame;
	warningIcon.tag = 1;
	[warningIcon drawToRight];
	
	[self.superview addSubview:warningIcon];
	[warningIcon release];		 
}

- (void)clearError {
	if (_error) {
		self.textColor = [UIColor blackColor];
		CGRect newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width + 30.0, self.frame.size.height);
		
		[[self.superview viewWithTag:1] removeFromSuperview];
		
		if (self.animated) {
			[UIView animateWithDuration:0.25
							 animations: ^ { self.frame = newFrame; }];
		}
		else {
			self.frame = newFrame;
		}

		_error = nil;
		[_error release];
	}
}

#pragma mark Actions

- (void)editingEnded:(id)sender {
	[self validate];
}

- (void)beginEditing:(id)sender {
	[self clearError];
}

#pragma mark Memory Managment

- (void)dealloc {
	[_validator release];
	
	[super dealloc];
}

@end

//------------------------------------------------------------------------------------------------------------
//MKInputAccessory

#pragma mark -
#pragma mark MKInputAccessoryView

@interface MKInputAccessoryView ()

- (void)doneButton:(id)sender;

@end

@implementation MKInputAccessoryView

@synthesize toolbar=_toolbar, textField;

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.autoresizesSubviews = YES;
		
		_toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
		_toolbar.barStyle = UIBarStyleBlackOpaque;
		_toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
		
		UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButton:)];
		
		NSArray *items = [NSArray arrayWithObjects:space, done, nil];
		_toolbar.items = items;
		
		[space release];
		[done release];
		
		[self addSubview:_toolbar];
		
		[_toolbar release];
	}
	return self;
}

- (void)doneButton:(id)sender {
	[self.textField resignFirstResponder];
}

- (void)dealloc {
	[super dealloc];
}

@end