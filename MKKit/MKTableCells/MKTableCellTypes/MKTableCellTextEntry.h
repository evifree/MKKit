//
//  MKTableCellTextEntry.h
//  MKKit
//
//  Created by Matthew King on 11/1/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKTableCells/MKTableCell.h>
#import <MKKit/MKKit/MKControls/MKTextField.h>

#import "MKTableCellPickerControlled.h"

typedef enum {
    MKTextEntryCellTypeStandard,
    MKTextEntryCellTypeFull,
} MKTextEntryCellType;

@class MKTextField;

/**----------------------------------------------------------------------------------
 The MKTableCellTextEntry is a subclass of MKTableCell. It returns a table cell with a
 that can be used for text entry. The keyboard will appear when the user taps anywhere 
 on the cell. It is set by default dismiss the keyboard when the Done button is touched.
 
 The MKTableCellTextEnty and MKTableCellPickerControlled class work together to ensure 
 that a picker does not display ontop of a keyboard and vice versa.
 
 This class listens for the `PICKER_DID_SHOW_NOTIFICATION` and tells the text field to 
 resign the frist responder when it is recivied.
 
 This class sends a `PICKER_SHOULD_DISMISS_NOTIFICATION` when the text field becomes the 
 first responder.
 
 You do not need to set up validation of the MKTextField of this feild. Validation is
 already built in to this class set the validationType property to the desired type.
------------------------------------------------------------------------------------*/

@interface MKTableCellTextEntry : MKTableCell <UITextFieldDelegate> {
    MKTextEntryCellType mTextEntryType;
	MKTextField *mTheTextField;
    
@private
    NSError *mValidationError;
}

///---------------------------------------------------------------------------------
/// @name Creating
///---------------------------------------------------------------------------------

/**
 Returns an initalized instance of MKTableCellTextEntry. 
 
 @param cellType the type of cell that will be initalized
 
 @param resuseIdentifier the resuse identifier for the cell
 
 MKTableCellTextEntry has two built in types:
 
 * `MKTextEntryCellTypeStandard` : a cell with a lable on the left and a text field on the right
 * `MKTextEntryCellTypeFull` : a cell with a text field and a pen icon
*/
- (id)initWithType:(MKTextEntryCellType)cellType reuseIdentifier:(NSString *)reuseIdentifier;

///---------------------------------------------------------------------------------------
/// @name Cell Elements
///---------------------------------------------------------------------------------------

/** A reference to the MKTextField */
@property (nonatomic, retain) MKTextField *theTextField;

/** The type of Text Entry Cell */
@property (nonatomic, assign) MKTextEntryCellType textEntryType;

@end
