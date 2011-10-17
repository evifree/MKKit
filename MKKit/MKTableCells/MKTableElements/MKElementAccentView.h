//
//  MKElementAccentView.h
//  MKKit
//
//  Created by Matthew King on 8/2/11.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKViews/MKView.h>

typedef enum {
    MKTableCellPositionTop,
    MKTableCellPositionMiddle,
    MKTableCellPositionBottom,
    MKTableCellPositionSingleCell,
} MKTableCellPosition;

/**---------------------------------------------------------------------
 Draws the accent background for a MKTableCell instance.
----------------------------------------------------------------------*/

@interface MKElementAccentView : MKView {
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

static const CGFloat kBorderLineWidth =         2.0;
static const CGFloat kBottomCellPadding =       1.0;
static const CGFloat kSingleCellPadding =       1.0;
static const CGFloat kRoundedCornerRadius =     10.0;
