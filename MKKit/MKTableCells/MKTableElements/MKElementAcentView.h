//
//  MKElementAccentView.h
//  MKKit
//
//  Created by Matthew King on 8/2/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKViews/MKView.h>

typedef enum {
    MKTableCellPositionTop,
    MKTableCellPositionMiddle,
    MKTableCellPositionBottom,
} MKTableCellPosition;

/**---------------------------------------------------------------------
 Draws the accent background for a MKTableCell instance.
----------------------------------------------------------------------*/

@interface MKElementAcentView : MKView {
    MKTableCellPosition mPosition;
}

/**
 Returns an instance of MKElementAccentView.
 
 @param frame the frame of the view.
 
 @param postition the position of the table cell.

 @return MKElementAccentView instance.
*/
- (id)initWithFrame:(CGRect)frame position:(MKTableCellPosition)position;

@end
