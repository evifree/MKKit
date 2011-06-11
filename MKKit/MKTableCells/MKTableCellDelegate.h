//
//  MKTableCellDelegate.h
//  MKKit
//
//  Created by Matthew King on 10/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

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
 
 @warning Note * If a contol gives an integer or bool for its value, the value is converted into an
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
 
 @param cell the cell that was touched
 
 @param aKey the key of the cell that was touched
 */
- (void)didSelectCell:(MKTableCell *)cell forKey:(NSString *)aKey;

/** 
 Called when the cells Accessory View is touched. 
 
 @warning Note * This method is called when using one of the MKTableCellAccessoryType constances. If your 
 using one of the UITableCellView accessory use those methods to process touches.
 
 @param aKey A unique NSString that identifies the cell.
*/
- (void)didTapAccessoryForKey:(NSString *)aKey;

///---------------------------------------------------------------------------------------
/// @name MKTableCellTextEntry Methods
///---------------------------------------------------------------------------------------

/** 
 Called when a the MKTextField object of becomes the first responder.
	
 @warning Note * This method is only called by the MKTableCellTextEntry class.
 
 @param textField The text field that has become the first responder.
*/
- (void)textFieldIsFirstResponder:(UITextField *)textField;

/** 
 Called after a picker has been added to the applications keyWindow.
 
 @warning Note * This medthod is only called by the MKTableCellPickerControlled class.
 
 @param thePicker The view that holds the specified picker.
 
 @param aKey A unique NSString that identifies the cell.
*/
- (void)didAddPicker:(UIView *)thePicker forKey:(NSString *)aKey;

///---------------------------------------------------------------------------------------
/// @name MKTableCellPickerConrolled Methods
///---------------------------------------------------------------------------------------

/** 
 Called before a picker will be removed from the applications keyWindow.

 @warning Note * This medthod is only called by the MKTableCellPickerControlled class.
 
 @param thePicker The view that holds the specified picker.
 
 @param aKey A unique NSString that identifies the cell.
*/
- (void)willRemovePicker:(UIView *)thePicker forKey:(NSString *)aKey;


@end

