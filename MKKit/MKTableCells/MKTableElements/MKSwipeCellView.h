//
//  MKSwipeCellView.h
//  MKKit
//
//  Created by Matthew King on 9/10/11.
//  Copyright (c) 2010-2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKViews/MKView.h>
#import <MKKit/MKKit/MKControls/MKControl.h>
#import <MKKit/MKKit/MKTableCells/MKTableCell.h>
#import "MKSwipeCellItem.h"

@class MKTableCell;

/**------------------------------------------------------------
 MKSwipeCellView provides a view to be displayed when a cell is
 swiped. The view uses MKSwipeCellItems to provide control buttons.
-------------------------------------------------------------*/
@interface MKSwipeCellView : MKView {
@private    
    MKTableCell *mCell;
    NSArray *mItems;
}

///------------------------------------
/// @name Creating
///------------------------------------

/**
 Returns an instance of MKSwipeCellView.
 
 @param items an array of MKSwipeCell items to be placed on the view.
 
 @param cell the cell to display the veiw on.
 
 @return MKSwipeCellView instance.
*/
- (id)initWithItems:(NSArray *)items cell:(MKTableCell *)cell; 

///-----------------------------------
/// @name Showing and Removing
///-----------------------------------

/**
 Shows the veiw on the cell. The view is animated onto the cell by
 sliding in from the right side of the screen.
*/
- (void)show;

/**
 Removes the view from the cell. The view is animated of the cell by
 sliding out to the right side of the screen
*/
- (void)remove;

@end

static const float kItemTakeUpWidth = 40.0;

NSString *MKSwipeViewShouldRemoveNotification MK_VISIBLE_ATTRIBUTE;