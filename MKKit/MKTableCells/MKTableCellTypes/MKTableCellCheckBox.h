//
//  MKTableCellCheckBox.h
//  MKKit
//
//  Created by Matthew King on 11/11/10.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MKKit/MKKit/MKTableCells/MKTableCell.h>

@class MKTableCell;

/**-------------------------------------------------------------------------------------
 The MKTableCellCheckBox class is a subclass of MKTableCell. This cell holds an MKCheckBox object on the left
 side of the cell and an lable to the right.
---------------------------------------------------------------------------------------*/

@interface MKTableCellCheckBox : MKTableCell {
	MKCheckBox *mCheckBox;
}

///---------------------------------------------------------------------------------------
/// @name Properties
///---------------------------------------------------------------------------------------

/** Referance to the MKCheckBox */
@property (nonatomic, retain) MKCheckBox *checkBox;

@end
