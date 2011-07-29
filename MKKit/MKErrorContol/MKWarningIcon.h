//
//  MKWarningIcon.h
//  MKKit
//
//  Created by Matthew King on 1/12/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MKKit/MKKit/MKControls/MKTextField.h>
#import <MKKit/MKKit/MKViews/MKView.h>

@class MKTextField;

@interface MKWarningIcon : MKView {
	MKTextField *_textField;
	NSError *_error;
}

///---------------------------------------------------------------------------------------
/// @name Initalizer
///---------------------------------------------------------------------------------------

/** Returns an Intialized MKWarningIcon
 
 @param textField The MKTextField that icon will display next to if there is a validation error.
 @see MKTextField
 @see MKInputValidation
*/
- (id)initWithTextField:(MKTextField *)textField;

/** Returns an Intialized MKWarningIcon
 
 @param error The error that has been created by the validator.
*/ 
- (id)initWithError:(NSError *)anError;

///---------------------------------------------------------------------------------------
/// @name Drawing Methods
///---------------------------------------------------------------------------------------

/** Sets the icon image to fit in the specified rect */
- (void)fitToRect:(CGRect)rect;

/** Draws the view to the right of the table cell. This method is used for the automatic alert. You 
 should not call this method directly.
*/
- (void)drawToRight;

///---------------------------------------------------------------------------------------
/// @name Properties
///---------------------------------------------------------------------------------------

/** An NSError that contains the error data from the validator */
@property (nonatomic, retain) NSError *error;

@end
