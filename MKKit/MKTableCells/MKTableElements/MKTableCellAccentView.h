//
//  MKTableCellAccentView.h
//  MKKit
//
//  Created by Matthew King on 8/27/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKViews/MKView.h>
#import "MKElementAccentView.h"

/**----------------------------------------------------------------------
 Provides the drawing for the accent of a table cell.
-----------------------------------------------------------------------*/

@interface MKTableCellAccentView : MKView {    
@private
    struct {
        MKTableCellPosition position;
        CGColorRef tintColor;
    } MKTableCellAccentViewFlags;
}

///-----------------------------
/// @name Creating
///-----------------------------

/**
 Returns and initalized instance of MKTableCellAccentView.
 
 @param frame the frame of the view
 
 @param postition the position of the cell on the table
 
 @return MKTableCellAccentView instance
*/
- (id)initWithFrame:(CGRect)frame position:(MKTableCellPosition)position;

///-----------------------------
/// @name Color Control
///-----------------------------

/** The tint color of the cell */
@property (nonatomic, retain) UIColor *tint;

@end
