//
//  MKPopOutView.h
//  MKKit
//
//  Created by Matthew King on 8/2/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKView.h"

typedef enum {
    MKPopOutAuto,
    MKPopOutAbove,
    MKPopOutBelow,
} MKPopOutViewType;

static const CGFloat kPopOutViewWidth = 300.0;

#define MK_POP_OUT_VIEW_SHOULD_REMOVE_NOTIFICATION        @"MKTableCellPopOutViewShouldRemoveNotification"

/**----------------------------------------------------------------------------------
 MKPopOutView provides a view that displays additional information. The view looks like 
 Apples UIMenuView. The content of the view is taken from a UIView that you provide. 
 
 There are three types of pop out views to choose from. The types control how the view
 is displayed.
 
 * `MKPopOutAuto` : will display the view above or below the item depending on its location.
 * `MKPopOutAbove` : displays the view above the item. 
 * `MKPopOutBelow` : displays the view below the item. 
 
 MKPopOutView listens for the `MK_POP_OUT_VIEW_SHOULD_REMOVE_NOTIFICATION` to remove itself. 
 ------------------------------------------------------------------------------------*/

@interface MKPopOutView : MKView {
    MKPopOutViewType mType;
    MKPopOutViewType mAutoType;
    UIView *mView;
    
    CGColorRef mTintColor;
}

///------------------------------------------------------
/// @name Creating
///------------------------------------------------------

/**
 Returns and intialized instance of MKPopoutView
 
 @param view the content of the popout view
 
 @param type the type of popout view
 
 @return MKTableCellPopoutView instance
 */
- (id)initWithView:(UIView *)view type:(MKPopOutViewType)type;

///-------------------------------------------------------
/// @name Appearance
///-------------------------------------------------------

/** The tint color of the popout view. Default is black. */
@property (nonatomic, assign) CGColorRef tintColor;

///--------------------------------------------------------
/// @name Types
///--------------------------------------------------------

/** The type of popout view used */
@property (nonatomic, assign, readonly) MKPopOutViewType type;

@end

