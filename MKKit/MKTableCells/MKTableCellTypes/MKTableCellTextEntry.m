//
//  MKTableCellTextEntry.m
//  MKKit
//
//  Created by Matthew King on 11/1/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKTableCellTextEntry.h"
#import "MKDeffinitions.h"

@interface MKTableCellTextEntry ()

- (void)textChanged:(id)sender;
- (void)warningIcon:(id)sender;
- (void)pickerPosted;

@end

@implementation MKTableCellTextEntry

@synthesize theTextField=mTheTextField, textEntryType=mTextEntryType;

#pragma mark -
#pragma mark Initalizer

- (id)initWithType:(MKTextEntryCellType)cellType reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithType:MKTableCellTypeNone reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect textFrame = CGRectZero;
        mTextEntryType = cellType;
        
        MKTextCellView *view = [[MKTextCellView alloc] initWithType:cellType];
        view.frame = self.contentView.frame;
        
        if (cellType == MKTextEntryCellTypeFull) {
            textFrame = CGRectMake(58.0, 11.0, 173.0, 21.0);
            
            mTheLabel.hidden = YES;
            [mTheLabel removeFromSuperview];
        }
        
        if  (cellType == MKTextEntryCellTypeStandard) {
            CGRect labelFrame = CGRectMake(10.0, 11.0, 100.0, 21.0);
            textFrame = CGRectMake(115.0, 11.0, 160.0, 21.0);
            
            mTheLabel = [[UILabel alloc] initWithFrame:labelFrame];
            mTheLabel.textAlignment = UITextAlignmentLeft;
            mTheLabel.adjustsFontSizeToFitWidth = YES;
            mTheLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
            mTheLabel.backgroundColor = [UIColor clearColor];
            
            [view addSubview:mTheLabel];
            [mTheLabel release];
        }
        
        mTheTextField = [[MKTextField alloc] initWithFrame:textFrame];
		mTheTextField.textAlignment = UITextAlignmentCenter;
		mTheTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		mTheTextField.delegate = self;
		mTheTextField.returnKeyType = UIReturnKeyDone;
		mTheTextField.keyboardAppearance = UIKeyboardAppearanceAlert;
		mTheTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
		
		[mTheTextField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
        
		[view addSubview:mTheTextField];
		[mTheTextField release];
        
        [self.contentView addSubview:view];
        [view release];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pickerPosted) name:PICKER_DID_SHOW_NOTIFICATION object:nil]; 
    }
    return self;
}

#pragma mark - Accessor Methods

- (void)setIconMask:(UIImage *)iconMask {
    MKMaskIconView *iconView = [[MKMaskIconView alloc] initWithImage:iconMask];
    [self.contentView addSubview:iconView];
    [iconView release];
}
 
#pragma mark -
#pragma mark Cell Behavior

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

	if (selected) {
		[self.theTextField becomeFirstResponder];
		if ([delegate respondsToSelector:@selector(textFieldIsFirstResponder:)]) {
			[delegate textFieldIsFirstResponder:self.theTextField];
		}
		[[NSNotificationCenter defaultCenter] postNotificationName:PICKER_SHOULD_DISMISS_NOTIFICATION object:self];
	}
	if (!selected) {
		[self.theTextField resignFirstResponder];
    }	
}

#pragma mark -
#pragma mark Validation Methods

- (void)validateWithType:(MKValidationType)aType {
	if (aType == MKValidateIsaNumber) {
		if ([validator respondsToSelector:@selector(inputIsaNumber:)]) {
			if (![validator inputIsaNumber:self.theTextField.text]) {
				mValidationError = [NSError errorWithDomain:ERROR_DESCRIPTION_701 code:ERROR_CODE_701 userInfo:nil];
			}
		}
	}
    if (aType == MKValidateIsaSetLength) {
        if ([validator respondsToSelector:@selector(inputIsaSetLength:)]) {
            if (![validator inputIsaSetLength:self.theTextField.text]) {
                mValidationError = [NSError errorWithDomain:ERROR_DESCRIPTION_703(mValidatorTestStringLength) code:ERROR_CODE_703 userInfo:nil];
            }
        }
    }
	if (aType == MKValidateHasLength) {
		if ([validator respondsToSelector:@selector(inputHasLength:)]) {
			if (![validator inputHasLength:self.theTextField.text]) {
				mValidationError = [NSError errorWithDomain:ERROR_DESCRIPTION_702 code:ERROR_CODE_702 userInfo:nil];
			}
		}
	}
	
	if (mValidationError) {
		[mValidationError retain];
		
        MKAccessoryView *icon = [[MKAccessoryView alloc] initWithType:MKTableCellAccessoryWarningIcon];
        [icon completedAction: ^ (MKAction action) {
            if (action == MKActionTouchDown) {
                [self warningIcon:icon];
            }
        }];
        
        self.accessoryView = icon;
        [icon release];
    }
    
    if ([delegate respondsToSelector:@selector(cellDidValidate:forKey:)]) {
        [delegate cellDidValidate:mValidationError forKey:self.key];
    }
}

#pragma mark -
#pragma mark Actions

- (void)textChanged:(id)sender {
	if ([delegate respondsToSelector:@selector(valueDidChange:forKey:)]) {
		[delegate valueDidChange:self.theTextField.text forKey:self.key];
	}
}

- (void)warningIcon:(id)sender {
	if (mValidationError) {
		MKErrorHandeling *handeler = [[MKErrorHandeling alloc] init];
		[handeler applicationDidError:mValidationError];
		[handeler release];
	}
}

#pragma mark -
#pragma mark Delegates

#pragma mark TextField

- (void)textFieldDidEndEditing:(UITextField *)textField {		
	if ([delegate respondsToSelector:@selector(valueDidChange:forKey:)]) {
		[delegate valueDidChange:textField.text forKey:self.key];
	}
	if (_validating) {
		[self validateWithType:self.validationType];
	}
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[self setSelected:YES animated:YES];
	if ([delegate respondsToSelector:@selector(textFieldIsFirstResponder:)]) {
		[delegate textFieldIsFirstResponder:textField];
	}
	
	if (mValidationError) {
		self.accessoryView = UITableViewCellAccessoryNone;
        //[[self.contentView viewWithTag:1] removeFromSuperview];
		mValidationError = nil;
		[mValidationError release];
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

#pragma mark -
#pragma mark Observer Methods

- (void)pickerPosted {
	[self.theTextField resignFirstResponder];
}

#pragma mark -
#pragma mark Memory Managment

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PICKER_DID_SHOW_NOTIFICATION object:nil];
    
    if (mValidationError) {
        mValidationError = nil;
        [mValidationError release];
    }
    
    [super dealloc];
}


@end

@implementation MKTextCellView

- (id)initWithType:(MKTextEntryCellType)type {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        self.alpha = 1.0;
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

@end
