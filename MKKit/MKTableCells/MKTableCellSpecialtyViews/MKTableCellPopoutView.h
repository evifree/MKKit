//
//  MKTableCellPopoutView.h
//  MKKit
//
//  Created by Matthew King on 7/30/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKViews/MKView.h>
#import <MKKit/MKKit/MKGraphics/MKGraphics.h>
#import <MKKit/MKKit/MKTableCells/MKTableCell.h>

typedef enum {
    MKTableCellPopoutAuto,
    MKTableCellPopoutAbove,
    MKTableCellPopoutBelow,
} MKTableCellPopoutViewType;

static const CGFloat kPopoutViewWidth = 300.0;

#define MK_TABLE_CELL_POPOUT_VIEW_SHOULD_REMOVE_NOTIFICATION        @"MKTableCellPopOutViewShouldRemoveNotification"

/**----------------------------------------------------------------------------------
 MKTableCellPopoutView provides a view that displays additional information from a 
 table cell. The view looks like apples UIMenuView. The content of the view is taken
 from a UIView that you provide. 
 
 There are three types of popout views to choose from. The types control how the view
 is displayed.
 
 * `MKTableCellPopoutAuto` : will display the view above or below the cell depending on 
 its location.
 * `MKTableCellPopoutAbove` : displays the view above the cell
 * 'MKTableCellPopoutBelow` : displays the view below the cell
 
 MKTableCellPopoutView listens for the `MK_TABLE_CELL_POPOUT_VIEW_SHOULD_REMOVE_NOTIFICATION` 
 to remove itself from the table view. 
------------------------------------------------------------------------------------*/

@interface MKTableCellPopoutView : MKView {
    MKTableCellPopoutViewType mType;
    
@private
    MKTableCellPopoutViewType mAutoType;
    UIView *mView;
    
    CGColorRef mTintColor;
}

///------------------------------------------------------
/// @name Creating
///------------------------------------------------------

/**
 Returns and intialized instance of MKTableCellPopoutView
 
 @param view the content of the popout view
 
 @param type the type of popout view
 
 @return MKTableCellPopoutView instance
*/
- (id)initWithView:(UIView *)view type:(MKTableCellPopoutViewType)type;

///-------------------------------------------------------
/// @name Displaying
///-------------------------------------------------------

/**
 Shows the view on the screen.
 
 @param cell the cell to display the view from
 
 @param tableView the table view to disaply on
*/
- (void)showFromCell:(MKTableCell *)cell onView:(UITableView *)tableView;

///-------------------------------------------------------
/// @name Appearance
///-------------------------------------------------------

/** The tint color of the popout view. Default is black. */
@property (nonatomic, assign) CGColorRef tintColor;

///--------------------------------------------------------
/// @name Types
///--------------------------------------------------------

/** The type of popout view used */
@property (nonatomic, assign, readonly) MKTableCellPopoutViewType type;

@end
