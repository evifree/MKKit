//
//  MKTableCellLoading.h
//  MKKit
//
//  Created by Matthew King on 5/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <MKKit/MKKit/MKTableCells/MKTableCell.h>

/**----------------------------------------------------------------------
 MKTablecellLoading provides a cell with the text "Loading" and an 
 UIActivityIndicatorView. The text can be changed using by acessing the 
 cells theLabel property.
-----------------------------------------------------------------------*/

@interface MKTableCellLoading : MKTableCell {
    UIActivityIndicatorView *mActivityIndicator;
}

/** The UIActivityIndicatorView */
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;

@end
