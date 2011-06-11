//
//  MKMenuView.h
//  MKKit
//
//  Created by Matthew King on 5/25/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKViews/MKView.h>

#import "MKMenuItem.h"

#define MK_MENU_VIEW_BACKGROUND_IMAGE               @"MKMenuView-Resources.bundle/MenuBackground.png"

#define MK_MENU_VIEW_SHOULD_REMOVE_NOTIFICATION     @"MKMenuViewShouldRemoveNotification"

/**-------------------------------------------------------------------------------------------------
 The MKMenuView object displays a popup holding MKMenuItem control objects. The view's frame will be
 automatically set using the number of MKMenuItems passed to it. MKMenuView can hold up to 12 different
 icons.
 
 MKMenuView listens for the `MK_MENU_VIEW_SHOULD_REMOVE_NOTIFICATION` to remove itself. If you use the
 showWithAnimationType: method to display the view, you should post this notification to remove it.
 
 @warning *Note* MKMenuView objects will look for resources in the MKMenuView-Resources bundle. 
 Ensure this bundle is added to your project for proper function.
--------------------------------------------------------------------------------------------------*/

@interface MKMenuView : MKView {
    NSArray *mItems;
    
@private
    int mRows;
}

///--------------------------------------------------
/// @name Creating Instances
///--------------------------------------------------

/**
 Returns an intialized instance of MKMenuView. This instance will be sized by the number of `items` provided.
 Instances of MKMenuItem will be placed in the order that are given.
 
 @param items an array of MKMenuItems to be placed onto the menu.
*/
- (id)initWithItems:(NSArray *)items;

///-------------------------------------------------
/// @name Properties
///-------------------------------------------------

/** The array MKMenuItems that are placed onto the view. */
@property (nonatomic, copy, readonly) NSArray *items;

@end
