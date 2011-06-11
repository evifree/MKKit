//
//  MKTableCellSwitch.h
//  MKKit
//
//  Created by Matthew King on 11/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MKKit/MKKit/MKTableCells/MKTableCell.h>

/**--------------------------------------------------------------------------------------------------
 The MKTableCellSwitch class creates a table cell with an UISwitch on the right hand side. When the switch
 position is changed it calls the valueDidChange:forKey: delegate method.
 
 @warning *Note* The switches `isOn` value is converted to an NSNumber object before the delegate method is 
 called.
----------------------------------------------------------------------------------------------------*/

@interface MKTableCellSwitch : MKTableCell {
	UISwitch *_theSwitch;
}
///-----------------------------------------------
/// @name Table Elements
///-----------------------------------------------

/** The UISwitch object that is on the cell */
@property (nonatomic, retain) UISwitch *theSwitch;

@end
