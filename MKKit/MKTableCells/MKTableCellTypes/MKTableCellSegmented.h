//
//  MKTableCellSegmented.h
//  MKKit
//
//  Created by Matthew King on 11/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MKKit/MKKit/MKTableCells/MKTableCell.h>

/**-------------------------------------------------------------------------------------------
 The MKTableCellSegmented class creates a table cell with a UISegmentedController filling the cell.
 Set the items of the cell by Segmented Control by setting the segmentItems property.
 
 When the selected segment changes the valueDidChange:forKey: delegate method is called. 
 
 @warning *Note* The `selectedSegmentIndex` property is converted to a NSNumber object before the delegate
 method is called.
---------------------------------------------------------------------------------------------*/

@interface MKTableCellSegmented : MKTableCell {
	UISegmentedControl *_segmentedContorl;
	NSArray *_segmentItems;

}

///---------------------------------------------------------------
/// @name Cell Elements
///---------------------------------------------------------------

/** The UISegmentedControl object the is placed on the cell */
@property (nonatomic, retain) UISegmentedControl *segmentedControl;

///----------------------------------------------------------------
/// @name Segment Contorl settings
///----------------------------------------------------------------

/** An array containg the items of the segmented control */
@property (nonatomic, retain) NSArray *segmentItems;

@end
