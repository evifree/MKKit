//
//  MKTableCellTextEntry.m
//  MKKit
//
//  Created by Matthew King on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
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

static NSError *error = nil;

#pragma mark -
#pragma mark Initalizer

- (id)initWithType:(MKTextEntryCellType)cellType reuseIdentifier:(NSString *)reuseIdentifier    {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect textFrame = CGRectZero;
        mTextEntryType = cellType;
        
        if (cellType == MKTextEntryCellTypeFull) {
            CGRect iconRect = CGRectMake(10.0, 7.0, 30.0, 30.0);
            textFrame = CGRectMake(58.0, 11.0, 203.0, 21.0);
            
            mTheImageView = [[[UIImageView alloc] initWithFrame:iconRect] retain];
            mTheImageView.image = [UIImage imageNamed:MK_TABLE_CELL_PEN_ICON];
            mTheImageView.alpha = 0.50;
            [self.contentView addSubview:mTheImageView];
            [mTheImageView release];
            
            mTheLabel.hidden = YES;
            [mTheLabel removeFromSuperview];
        }
        
        if  (cellType == MKTextEntryCellTypeStandard) {
            CGRect labelFrame = CGRectMake(10.0, 11.0, 100.0, 21.0);
            textFrame = CGRectMake(115.0, 11.0, 190.0, 21.0);
            
            mTheLabel = [[UILabel alloc] initWithFrame:labelFrame];
            mTheLabel.textAlignment = UITextAlignmentLeft;
            mTheLabel.adjustsFontSizeToFitWidth = YES;
            mTheLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
            mTheLabel.backgroundColor = [UIColor clearColor];
            
            [self.contentView addSubview:mTheLabel];
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
        
		[self.contentView addSubview:mTheTextField];
		[mTheTextField release];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pickerPosted) name:PICKER_DID_SHOW_NOTIFICATION object:nil]; 
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		CGRect iconRect = CGRectMake(10.0, 7.0, 30.0, 30.0);
        CGRect textFrame = CGRectMake(58.0, 11.0, 203.0, 21.0);
        
        mTheImageView = [[[UIImageView alloc] initWithFrame:iconRect] retain];
        mTheImageView.image = [UIImage imageNamed:MK_TABLE_CELL_PEN_ICON];
        mTheImageView.alpha = 0.50;
        [self.contentView addSubview:mTheImageView];
        [mTheImageView release];
        
        mTheLabel.hidden = YES;
        [mTheLabel removeFromSuperview];
		
		mTheTextField = [[MKTextField alloc] initWithFrame:textFrame];
		mTheTextField.textAlignment = UITextAlignmentCenter;
		mTheTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		mTheTextField.delegate = self;
		mTheTextField.returnKeyType = UIReturnKeyDone;
		mTheTextField.keyboardAppearance = UIKeyboardAppearanceAlert;
		mTheTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
		
		[mTheTextField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
							
		[self.contentView addSubview:mTheTextField];
		[mTheTextField release];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pickerPosted) name:PICKER_DID_SHOW_NOTIFICATION object:nil]; 
	}

    return self;
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
				error = [NSError errorWithDomain:ERROR_DESCRIPTION_701 code:ERROR_CODE_701 userInfo:nil];
			}
		}
	}
	if (aType == MKValidateHasLength) {
		if ([validator respondsToSelector:@selector(inputHasLength:)]) {
			if (![validator inputHasLength:self.theTextField.text]) {
				error = [NSError errorWithDomain:ERROR_DESCRIPTION_702 code:ERROR_CODE_702 userInfo:nil];
			}
		}
	}
	
	if (error) {
		[error retain];
		
		UIButton *icon = [UIButton buttonWithType:UIButtonTypeCustom];
		icon.frame = CGRectMake((self.contentView.frame.size.width - 35.0), 8.0, 25.0, 25.0);
		[icon setImage:[UIImage imageNamed:@"WarningIcon.png"] forState:UIControlStateNormal];
		[icon addTarget:self action:@selector(warningIcon:) forControlEvents:UIControlEventTouchUpInside];
		icon.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
		
		icon.tag = 1;
		[self.contentView addSubview:icon];
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
	if (error) {
		MKErrorHandeling *handeler = [[MKErrorHandeling alloc] init];
		[handeler applicationDidError:error];
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
	
	if (error) {
		[[self.contentView viewWithTag:1] removeFromSuperview];
		error = nil;
		[error release];
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
    [super dealloc];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:PICKER_DID_SHOW_NOTIFICATION object:nil];
}


@end
