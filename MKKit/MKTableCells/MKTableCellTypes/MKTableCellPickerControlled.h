//
//  MKTableCellPickerControlled.h
//  MKKit
//
//  Created by Matthew King on 11/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKTableCells/MKTableCell.h>

typedef enum {
	MKTableCellPickerTypeDate,
	MKTableCellPickerTypeStandard,
} MKTableCellPickerType;

typedef enum {
	MKTableCellDatePickerModeDate,
	MKTableCellDatePickerModeTime,
	MKTableCellDatePickerModeDateAndTime,
	MKTableCellDatePickerModeCountdown,
} MKTableCellDatePickerMode;

@class MKPickerView;

/**------------------------------------------------------------------------------------------------
 The MKTableCellPickerConrolled is a subclass of MKTableCell. This class creates a MKTableCell with 
 two UILabels side by side. When the user touches a the cell a picker will appear on the screen. The 
 picker appears the same way as a keyboard, sliding up from the bottom of the screen. A toolbar with 
 a done button is placed on top of the picker for dismissing it. When the user changes the pickers 
 selection the cell is update with the new selection. The only thing you need to do is set what kind
 of picker you want to display. You do this by setting pickerType property.
 
 Supported picker types:
 
 * `MKTableCellPickerTypeDate` : Sets the picker type to an instance of UIDatePicker.
 * `MKTableCellPickerTypeStandard` : Set the picker type to an instance of UIPickerView.
 
 If you use the `MKTableCellPickerTypeDate` you need to provide a pickerSubType.
 
 * `MKTableCellDatePickerModeDate` : An UIDatePicker that allows the user to select a specific date.
 * `MKTableCellDatePickerModeTime` : An UIDatePicker that allows the user to select a specific time.
 * `MKTableCellDatePickerModeDateAndTime` : An UIDatePicker that allows the user to select a specific date and time.
 * `MKTableCellDatePickerModeCountdown` : An UIDatePicker that allows the user to select a specific length of time.
 
 If you use the `MKTableCellPickerTypeStandard` you need to provide an NSArray containing the data to fill
 the picker with. You do this by setting the pickerArray property. This picker array needs to contain NSString
 objects only to set the picker properly.
 
 This class works with the MKTableCellTextEntry class by listening for and posting notifications. The two class
 make ensure that a keyboard and picker will not be displayed at the same time.
 
 MKTableCellPickerControlled listens for the `PICKER_SHOULD_DISMISS_NOTIFICATION` to dismiss itself without
 the user touching the done button. 
 
 MKTableCellPickerControlled sends a `PICKER_DID_SHOW_NOTIFICAITON` when the picker appears on the screen.
 
 @warning *Note* When the a picker is displayed it is added to the applications keyWindow. When using this class your 
 UITableViewController subclass needs to  post the `PICKER_SHOULD_DISMISS_NOTIFICATION` in its viewWillDisappear: method.
 This will dismiss the picker when the user navigates away from the view. If this is not done the picker will
 stay on the screen.
 
 Here is an example on how to post the `PICKER_SHOULD_DISMISS_NOTIFICATION`:
 
	- (void)viewWillDisappear:(BOOL)animated {
		[super viewWillDisappear:animated];
		[[NSNotificationCenter defaultCenter] postNotificationName:PICKER_SHOULD_DISMISS_NOTIFICATION object:self userInfo:nil];
	}
*/

@interface MKTableCellPickerControlled : MKTableCell <UIPickerViewDelegate, UIPickerViewDataSource> {
	UILabel *_pickerLabel;
	NSDate *_pickerDate;
	MKPickerView *_pickerView;

	CGRect _pickerFrame;
	UIViewController *_owner;
	MKTableCellPickerType pickerType;
	MKTableCellDatePickerMode pickerSubType;
	NSArray *_pickerArray;
	
	BOOL _displayed;
}

///-------------------------------------------------------------------------------------------
/// @name Cell Elements
///-------------------------------------------------------------------------------------------

/** The label that the displays the pickers selected value. 
	
 @warning *Note* The text of this label is set by the picker.
*/
@property (nonatomic, retain) UILabel *pickerLabel;


///-------------------------------------------------------------------------------------------
/// @name Picker Types (Required)
///-------------------------------------------------------------------------------------------

/** Sets the MKTableCellPickerType to be used by the cell.
	
 This can be set to one of two values:
 
 * `MKTableCellPickerTypeDate` : Sets the picker type to an instance of UIDatePicker.
 * `MKTableCellPickerTypeStandard` : Sets the picker type to an instance of UIPickerView.
*/
@property (assign) MKTableCellPickerType pickerType;

/** Sets the mode of the date picker. Only used if pickerType is set to MKTableCellPickerTypeDate.
 
 This can be set the one of the following values.
 
 * `MKTableCellDatePickerModeDate` : An UIDatePicker that allows the user to select a specific date.
 * `MKTableCellDatePickerModeTime` : An UIDatePicker that allows the user to select a specific time.
 * `MKTableCellDatePickerModeDateAndTime` : An UIDatePicker that allows the user to select a specific date and time.
 * `MKTableCellDatePickerModeCountdown` : An UIDatePicker that allows the user to select a specific length of time.
 */
@property (assign) MKTableCellDatePickerMode pickerSubType;

///-------------------------------------------------------------------------------------------
/// @name Picker Data
///-------------------------------------------------------------------------------------------

/** The selected date when MKTableCellPickTypeDate is used. */
@property (nonatomic, retain, readonly) NSDate *pickerDate;

/** An array of NSString objects to supply the picker with data.
 
 @warning *Note* This is required when the pickerType is set to `MKTableCellPickerTypeStandard`.
 */
@property (nonatomic, assign) NSArray *pickerArray;

///-------------------------------------------------------------------------------------------
/// @name Display Opptions
///-------------------------------------------------------------------------------------------

/** An MKPickerView instance used to display the picker.*/
@property (nonatomic, retain) MKPickerView *pickerView;

/** The view controller that the picker drawn onto. */
@property (assign) UIViewController *owner;

/** The frame that the picker will be drawn into.*/
@property (assign) CGRect pickerFrame;

/** BOOL value that tells if the a picker is displayed or not.*/
@property (assign, readonly) BOOL displayed;

///--------------------------------------------------------------------------------------------------
/// @name Instance Methods
///--------------------------------------------------------------------------------------------------

/** Informs the delegate that an UIDatePicker has changed the selected date. This method should not be
 called directly.
 
 @param sender The UIDatePicker that changed its date.
*/
- (void)changeDate:(UIDatePicker *)sender;

/** Informs the delegate the the picker with be dismissed and dismisses the picker. This method should not be
 called directly
 
 @param sender The button that was touched.
*/
- (void)doneButtonTouched:(id)sender;

@end

/**-------------------------------------------------------------------------------------------------
 MKPickerView is a helper class for MKTableCellPickerControlled it handels the drawing the picker and
 the toolbar displayed above the Picker. This class is initalized and responds to the MKTableCellPickerControlled
 class. You should not initalize this class directly.
--------------------------------------------------------------------------------------------------*/

@interface MKPickerView : UIView {
	
}

///--------------------------------------------------------------------------------------------------
/// @name Initalizer
///--------------------------------------------------------------------------------------------------

/** The Default Initalizer.

 @param frame The to draw the view into.
 @param cell The cell that is contorlling this objcet
*/
- (id)initWithFrame:(CGRect)frame cell:(MKTableCellPickerControlled *)cell;

///--------------------------------------------------------------------------------------------------
/// @name Propterties
///--------------------------------------------------------------------------------------------------

/** The cell that is contorlling this object */
@property (nonatomic, retain) MKTableCellPickerControlled *pickerCell;

@end

