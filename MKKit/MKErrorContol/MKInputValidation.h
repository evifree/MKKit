//
//  MKInputValidation.h
//  MKKit
//
//  Created by Matthew King on 1/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
	MKValidationNone,
	MKValidateIsaNumber,
	MKValidateHasLength,
} MKValidationType;

/**--------------------------------------------------------------------------------------
 The MKInputValidation protocol gives methods for objects to validate user input. Objects that
 use implement the MKInputValidation protocol can use different MKValidationTypes to tell the
 MKValidator which methods to call.
 
 These types are:
 
 * `MKValidationNone` : No valition type set.
 * `MKValidateIsaNumber` : Calls the inputIsaNumber: method.
 * `MKValidateHasLength` : Calls the inputHasLength: method.
----------------------------------------------------------------------------------------*/

@protocol MKInputValidation <NSObject>

@optional

///---------------------------------------------------------------------------------------
/// @name Text Input Validation Methods
///---------------------------------------------------------------------------------------

/** Retuns YES if the text is a number. 
 
 @param text The text to be evaluated 
*/
- (BOOL)inputIsaNumber:(NSString *)text;

/** Returns YES if text has a length greater than 0.
 
 @param text The text to be evaluated
*/
- (BOOL)inputHasLength:(NSString *)text;

@end