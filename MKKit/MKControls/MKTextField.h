//
//  MKTextField.h
//  MKKit
//
//  Created by Matthew King on 1/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKErrorContol/MKErrorCodes.h>
#import <MKKit/MKKit/MKErrorContol/MKInputValidation.h>
#import <MKKit/MKKit/MKErrorContol/MKValidator.h>
#import <MKKit/MKKit/MKErrorContol/MKErrorHandeling.h>
#import <MKKit/MKKit/MKErrorContol/MKWarningIcon.h>

#define TEXT_FIELD_SHOULD_VALIDATE_NOTIFICATION     @"textFieldShouldValidateNotificaiton"

/**---------------------------------------------------------------------------------------------
 The MKTextField class is a subclass of UITextField. This class adds validation control to a text field.
 MKTextField implemnts the MKInputValidation protocol. This class can automatically preform imput validations
 and notifiy the user of any errors.
 
 Here is an example of a text field will check to see if text has been entered into it after resignFirstResponder: 
 is called.
 
	MKTextField *textField = [[MKTextField alloc] initWithFrame:myFrame];
	textField.automaticalyValidate = YES;
	textField.validationType = MKValidateHasLength;
	textField.displayWarningIcon = YES;
	textField.animated = YES;
-----------------------------------------------------------------------------------------------*/

@interface MKTextField : UITextField {
	id _validator;
	NSError *_error;
	
	BOOL _validated;
}

///---------------------------------------------------------------------------------------
/// @name Validation Controls
///---------------------------------------------------------------------------------------

/** Validates the input imediately. */
- (void)validate;

/** Validates the input with the specified type. Only call this method if need to validate for type
 other than what was defined with a MKValidationType. Otherwise use validate.
 
 @param type The MKValidationType to use.
 */
- (void)validateWithType:(MKValidationType)type;

/** Clears the validation error after the user has recived the message. You should not need to call this 
    method directly. */
- (void)clearError;

///---------------------------------------------------------------------------------------
/// @name Validation Behaviors
///---------------------------------------------------------------------------------------

/** Set to YES to validate the text field when editing is completed. Default value is NO. */
@property (nonatomic, assign) BOOL automaticalyValidate;

/** MKValidationType telling what kind of validation to perform. */
@property (nonatomic, assign) MKValidationType validationType;

///---------------------------------------------------------------------------------------
/// @name Validation Result
///---------------------------------------------------------------------------------------

/** A BOOL telling if the input has been validated.*/
@property (nonatomic, assign, readonly) BOOL validated;

/** An NSError generated if validation fails. */
@property (nonatomic, retain, readonly) NSError *error;

///---------------------------------------------------------------------------------------
/// @name Error Notification Behaivor
///---------------------------------------------------------------------------------------

/** Set to YES to display the warning icon automatically when a feild is not validated. Set
 to NO to handel the validation yourself. Default is NO*/
@property (nonatomic, assign) BOOL displayWarningIcon;

/** Set to YES to animate the appearance of the warning icon. Default value is NO. */
@property (nonatomic, assign) BOOL animated;

///---------------------------------------------------------------------------------------
/// @name Text Input Opptions
///---------------------------------------------------------------------------------------

/** Set to YES to use MKInputAccessoryView as the accessory for the keyboard. Default is NO. */
@property (nonatomic, assign) BOOL useInputAccessoryView;

///---------------------------------------------------------------------------------------
/// @name Validatior
///---------------------------------------------------------------------------------------

/** The default validator. 
 
 @warning Note * MKTextField automically assigns a validator to process the validation of the text that is entered.
		  If you want to use your own validator it must conform to the MKInputValidation protocol.
 */
@property (nonatomic, assign) id<MKInputValidation> validator;

@end

//----------------------------------------------------------------------------------------
//MKInputAccessoryView

/**---------------------------------------------------------------------------------------
 The MKInputAccessoryView is a helper class for the MKTextField class. It provides a toolbar with a done
 button to be placed on top of the keyboard when it is dispalyed. You should not need to call implement this
 class directly.
-----------------------------------------------------------------------------------------*/ 

@interface MKInputAccessoryView : UIView {
	UIToolbar *_toolbar;
}

/** The toolbar that is drawn above the keyboard.*/
@property (nonatomic, retain) UIToolbar *toolbar;

/** A referance the MKTextField using the accessory view. */
@property (nonatomic, retain) MKTextField *textField;

@end
