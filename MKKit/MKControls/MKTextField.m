//
//  MKTextField.m
//  MKKit
//
//  Created by Matthew King on 1/10/11.
//  Copyright 2011 Matt King. All rights reserved.
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
			automaticalyValidate, useInputAccessoryView, displayWarningIcon, accessoryType;

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
		MKInputAccessoryView *accessoryView = [[MKInputAccessoryView alloc] initWithType:MKInputAccessoryTypeDone];
		accessoryView.textField = self;
		self.inputAccessoryView = accessoryView;
		[accessoryView release];
	}
	else {
		self.inputAccessoryView = nil;
	}

}

- (void)setAccessoryType:(MKInputAccessoryType)type {
    MKInputAccessoryView *accessoryView = [[MKInputAccessoryView alloc] initWithType:type];
    accessoryView.textField = self;
    self.inputAccessoryView = accessoryView;
    [accessoryView release];
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
- (void)creditButton:(id)sender;
- (void)debitButton:(id)sender;

@end

@implementation MKInputAccessoryView

@synthesize toolbar=mToolbar, textField;

- (id)initWithType:(MKInputAccessoryType)type {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
    if (self) {
        self.autoresizesSubviews = YES;
        self.alpha = 1.0;
        
        mShouldRemoveView = NO;
		
		mToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
		mToolbar.barStyle = UIBarStyleBlackOpaque;
		mToolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		
        if (type == MKInputAccessoryTypeDone) {
            UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButton:)];
            
            NSArray *items = [NSArray arrayWithObjects:space, done, nil];
            mToolbar.items = items;
            
            [done release];
        }
        
        if  (type == MKInputAccessoryTypeFinancial) {
            UIBarButtonItem *credit = [[UIBarButtonItem alloc] initWithTitle:@"Credit (+)" style:UIBarButtonItemStyleBordered target:self action:@selector(creditButton:)];
            UIBarButtonItem *debit = [[UIBarButtonItem alloc] initWithTitle:@"Debit (-)" style:UIBarButtonItemStyleBordered target:self action:@selector(debitButton:)];
            
            NSArray *items = [NSArray arrayWithObjects:space, credit, debit, nil];
            mToolbar.items = items;
            
            [credit release];
            [debit release];
        }
        
        [space release];

		[self addSubview:mToolbar];
		
		[mToolbar release];
    }
    return self;
}

#pragma mark - Actions

- (void)doneButton:(id)sender {
	[self.textField resignFirstResponder];
}

- (void)creditButton:(id)sender {
    if ([self.textField.text floatValue] < 0.0) {
        float num = ([self.textField.text floatValue] * -1.0);
        self.textField.text = [MKStrings stringWithDecimalNumber:[NSDecimalNumber numberWithFloat:num] decimalPlaces:2];
    }
    
    [self.textField resignFirstResponder];
}

- (void)debitButton:(id)sender {
    if ([self.textField.text floatValue] > 0.0) {
        float num = ([self.textField.text floatValue] * -1.0);
        self.textField.text = [MKStrings stringWithDecimalNumber:[NSDecimalNumber numberWithFloat:num] decimalPlaces:2];
    }
    [self.textField resignFirstResponder];
}


#pragma mark Memory Management

- (void)dealloc {
	[super dealloc];
}

@end