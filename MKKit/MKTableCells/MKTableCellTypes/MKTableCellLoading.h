//
//  MKTableCellLoading.h
//  MKKit
//
//  Created by Matthew King on 5/28/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKTableCells/MKTableCell.h>

/**----------------------------------------------------------------------
 *Overview*
 
 MKTablecellLoading provides a cell with the text "Loading" and an 
 UIActivityIndicatorView. The text can be changed using by acessing the 
 cells theLabel property.
 
 *Required Classes*
 
 * MKTableCell
-----------------------------------------------------------------------*/

@interface MKTableCellLoading : MKTableCell {
    UIActivityIndicatorView *mActivityIndicator;
    
    @private
    struct {
        bool isWorking;
    } MKTableCellLoadingFlags;
}

///--------------------------------
/// @name Behaviors
///--------------------------------

/** 
 Tells the Cell if the activity indicator is spinning or not. It is recomended to use this 
 property to start and stop the indicator. Setting this property to `YES` also moves the 
 activity indicator to a possition releative to the displayed text.
*/
@property (nonatomic, assign) BOOL working;

///--------------------------------
/// @name Elements
///--------------------------------

/** The UIActivityIndicatorView */
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@end
