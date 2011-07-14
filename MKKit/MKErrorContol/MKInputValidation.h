//
//  MKInputValidation.h
//  MKKit
//
//  Created by Matthew King on 1/10/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
	MKValidationNone,
	MKValidateIsaNumber,
    MKValidateIsaSetLength,
	MKValidateHasLength,
} MKValidationType;

/**--------------------------------------------------------------------------------------
 The MKInputValidation protocol gives methods for objects to validate user input. Objects that
 use implement the MKInputValidation protocol can use different MKValidationTypes to tell the
 MKValidator which methods to call.
 
 These types are:
 
 * `MKValidationNone` : No valition type set.
 * `MKValidateIsaNumber` : Calls the inputIsaNumber: method.
 * `MKValidateIsaSetLength` : Calls the inputIsaSetLength: method.
 * `MKValidateHasLength` : Calls the inputHasLength: method.
----------------------------------------------------------------------------------------*/

@protocol MKInputValidation <NSObject>

@optional

///--------------------------------------------------------------------------------------
/// @name Properties
///--------------------------------------------------------------------------------------

/** the length to compare against when using MKValidateIsaSetLength */
@property (nonatomic, assign) NSInteger stringLength;

///---------------------------------------------------------------------------------------
/// @name Text Input Validation Methods
///---------------------------------------------------------------------------------------

/** Retuns YES if the text is a number. 
 
 @param text The text to be evaluated 
*/
- (BOOL)inputIsaNumber:(NSString *)text;

/** Retuns Yes if the text is the same length as the setLength property
 
 @param text The text to be evaluated
 @warning when this method is used the stringLength property cannot be equal to zero.
 @exception setLength an exeception is rasied if setLength is equal to zero.
*/
- (BOOL)inputIsaSetLength:(NSString *)text;

/** Returns YES if text has a length greater than 0.
 
 @param text The text to be evaluated
*/
- (BOOL)inputHasLength:(NSString *)text;

@end