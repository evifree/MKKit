//
//  MKValidator.h
//  MKKit
//
//  Created by Matthew King on 1/10/11.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MKInputValidation.h"

#import <MKKit/MKKit/MKMacros.h>
#import <MKKit/MKKit/MKObject.h>

@class MKTableCell;

/**----------------------------------------------------------------------------------
 *Overview*
 
 The MKValidator is default validator for implementing the MKInputValidation protocol. This class
 will handel all of the validation methods for you. This can be overriden by add your own class
 that implements the MKInputValidation protocol.
 
 *Validation Types*
 
 There are four types of validation that can be preformed.
 
 * `MKValidationNone` : No valition type set.
 * `MKValidateIsaNumber` : Calls the inputIsaNumber: method.
 * `MKValidateIsaSetLength` : Calls the inputIsaSetLength: method.
 * `MKValidateHasLength` : Calls the inputHasLength: method.
 
 *Using the Singlton*
 
 MKValidator offers the option of a singlton instance. If you have several fields to validate, it
 is recomended that you use the singlton instance to prevent your application from having several
 instances of MKValidator. The singlton should also be used when using the Table View methods of 
 MKValidator.
 
 You can get the singlton by calling the sharedValidator method.
 
 *Validating Table View Forms*
 
 When used with MKTableCells, MKValidator can preform input validations on the entire table. To do
 this set the `validationType` property of an MKTableCell, after your table view is loaded call the 
 registerTableView: method. MKValidator will find the cells that can be validated add them to the 
 validation stack. 
 
 When you are ready to validate the table view call the validate method. The MKTableCellDelegate will
 notify you of each cell that has been validated throught the didValidateCell:forKey:indexPath: method.
 If a cell does not pass validation an NSError will be passed thought this delegate. The error will 
 contain two keys in the userInfo dictonary:
 
 `MKValidatorField` : This key is for the feild object that has been validated.
 `MKValidatorEnteredText` : This key is for the text, if any, that was entered into the field.
 
 If the table view passes validation the `MKValidatorDidValidateTableView` notification is posted.
 After the validation is complete, or when the user leaves the table view call the removeTableView
 method to clear the validation stack. If this is not called you may have error while trying to validate
 other tables.
 
 @warning *Note* Do not register for the `MKValidaorDidValidateTableView` notification until after
 you have called the registerTableView method. 
 
 @warning *Note* At this time only MKTableCellTextEntry cells support input validation.
 
 Review the source code of MKLoginSettingsViewController for an exampe of how validation works.
 
 MKValidator conforms to the MKInputValidation protocol.
 
 *Required Classes*
 
 * MKMacros
 * MKObject
 
 *Required Frameworks*
 
 * Foundation
 * UIKit
------------------------------------------------------------------------------------*/

@interface MKValidator : MKObject <MKInputValidation> {
@private
    NSMutableSet *mValidationObjects;
}

///------------------------------------------------------
/// @name Singlton
///------------------------------------------------------

/**
 Returns a the singleton instance of MKValidator.
 */
+ (id)sharedValidator;

///------------------------------------------------------
/// @name Working With Table Views
///------------------------------------------------------

/**
 Adds the cells that support validation to the validation stack. This method looks for 
 cells that have the `validationType` property set.
*/
- (void)registerTableView:(UITableView *)tableView;

/**
 Clears all existing cells from the validation stack. This method should be called from
 the `viewDidDisapear:` method.
*/
- (void)removeTableView;

/**
 Adds the table view row at the given indexPath to the validation stack. If you use the 
 the registerTableView method does not need to be called.
*/
- (void)addValidationRow:(NSIndexPath *)indexPath;

/**
 Removes the table view row at the given indexPath from the validation stack. To remove
 all the rows call the removeTableView method instead.
*/
- (void)removeValidationRow:(NSIndexPath *)indexPath;

/**
 Validates the entire validation stack by the respective `validationType`.
*/
- (void)validate;

/** The current table view that has been registered for validation. This property is automatically
 set when the registerTableView: method is called.
*/
@property (nonatomic, retain) UITableView *tableView;

@end

NSString *MKValidatorDidValidateTableView MK_VISIBLE_ATTRIBUTE;

NSString *MKValidatorField MK_VISIBLE_ATTRIBUTE;
NSString *MKValidatorEnteredText MK_VISIBLE_ATTRIBUTE;