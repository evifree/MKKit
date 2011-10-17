//
//  MKTableCellDelegate.h
//  MKKit
//
//  Created by Matthew King on 10/20/10.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MKKit/MKKit/MKMacros.h>

@class MKTableCell;

/**--------------------------------------------------------------------------------------
 
 The MKTableCellDelegate is designed to work with an NSDictonary object. It uses the key property of 
 MKTableCell to identify input changes and notify the delegate of them. This allows you to quickly process
 large sets of data input from the user. 
 
 Here is an example of how it works:
 
	- (void)valueDidChange:(id)value forKey:(NSString *)aKey {
		[myDictionary setObject:value forKey:aKey];
	}
 
----------------------------------------------------------------------------------------*/

@protocol MKTableCellDelegate <NSObject>

@optional

///---------------------------------------------------------------------------------------
/// @name Input Changes
///---------------------------------------------------------------------------------------

/** 
 Called when a the Value of a controled object is changed.
 
 All of the sublcasses that use any type of user input contols call this method whenever the input
 value is changed. It is imporant that the key property of MKTableCell is set for this method to work
 propery.
 
 @warning *Note* If a contol gives an integer or bool for its value, the value is converted into an
 NSNumber object before this method is called.
 
 @param value An object represnting the new value of the control objcet.
 
 @param aKey A unique NSString that identifies the cell.
 */
- (void)valueDidChange:(id)value forKey:(NSString *)aKey;


///---------------------------------------------------------------------------------------
/// @name Responding to Events
///---------------------------------------------------------------------------------------

/**
 Called when the cell is selected.
 
 @param cell the cell that was touched.
 
 @param aKey the key of the cell that was touched.
 
 @param indexPath the index path of the cell.
 */
- (void)didSelectCell:(MKTableCell *)cell forKey:(NSString *)aKey indexPath:(NSIndexPath *)indexPath;

/** 
 @warning *Deprecated. Use didTapAccessoryForKey:indexPath: instead.*
*/
- (void)didTapAccessoryForKey:(NSString *)aKey MK_DEPRECATED_0_8;

/** 
 Called when the cells Accessory View is touched. 
 
 @warning *Note* This method is called when using one of the MKTableCellAccessoryTypes. If your 
 using one of the UITableCellView accessory this method will not be called.
 
 @param aKey A unique NSString that identifies the cell.
 
 @param indexPath the index path of the cell whos acessory was taped.
 
 @exception No index path. The index path property of the cell must be set for this
 method to be called.
*/
- (void)didTapAccessoryForKey:(NSString *)aKey indexPath:(NSIndexPath *)indexPath;

/**
 Called when the cell is swiped from right to the left.

 @param aKey A unique NSString that identifies the cell.
 
 @param indexPath The index path of the cell.
*/
- (void)didSwipeRightToLeftForKey:(NSString *)aKey indexPath:(NSIndexPath *)indexPath;

/**
 Called when the cell is swiped from left to the right.
 
 @param aKey A unique NSString that identifies the cell.
 
 @param indexPath The index path of the cell.
*/
- (void)didSwipeLeftToRightForKey:(NSString *)aKey indexPath:(NSIndexPath *)indexPath;

/**
 Called when the long press is done on the cell.
 
 @param aKey A unique NSString that identifies the cell.
 
 @param indexPath The index path of the cell.
*/
- (void)didLongPressForKey:(NSString *)aKey indexPath:(NSIndexPath *)indexPath;

///---------------------------------------------------------------------------------------
/// @name MKTableCellTextEntry Methods
///---------------------------------------------------------------------------------------

/** 
 Called when a the MKTextField object of becomes the first responder.
	
 @warning *Note* This method is only called by the MKTableCellTextEntry class.
 
 @param textField The text field that has become the first responder.
*/
- (void)textFieldIsFirstResponder:(UITextField *)textField;

/** 
 Called after a picker has been added to the applications keyWindow.
 
 @warning *Note* This medthod is only called by the MKTableCellPickerControlled class.
 
 @param thePicker The view that holds the specified picker.
 
 @param aKey A unique NSString that identifies the cell.
*/
- (void)didAddPicker:(UIView *)thePicker forKey:(NSString *)aKey;

///---------------------------------------------------------------------------------------
/// @name MKTableCellPickerConrolled Methods
///---------------------------------------------------------------------------------------

/** 
 Called before a picker will be removed from the applications keyWindow.

 @warning *Note* This medthod is only called by the MKTableCellPickerControlled class.
 
 @param thePicker The view that holds the specified picker.
 
 @param aKey A unique NSString that identifies the cell.
*/
- (void)willRemovePicker:(UIView *)thePicker forKey:(NSString *)aKey;

///---------------------------------------------------------------------------------------
/// @name Validation Methods
///---------------------------------------------------------------------------------------

/**
 @warning *This method has been deprecated. Use cellDidValidate:forKey:indexPath: instead.*
 */
- (void)cellDidValidate:(NSError *)error forKey:(NSString *)aKey MK_DEPRECATED_0_8;

/**
 Called when a cell validates its input. If there is a validation error, the error will be
 passed through this method. The userInfo dictionay of the error contains addtional information
 about the error. The error information can be accessed through the following keys:
 
 * `MKValidatorField` : The input field that was validated.
 * `MKValidatorEnteredText` : The text that was entered into the field.
 
 @param error the validation error. 
 
 @param aKey a unique NSString that identifies the cell.
 
 @param indexPath the indexPath of the cell.
 
 @warning *Note* Index paths are not automatically set. If the indexPath property is
 not set `nil` will be passed.
 */
- (void)cellDidValidate:(NSError *)error forKey:(NSString *)aKey indexPath:(NSIndexPath *)indexPath;

@end

