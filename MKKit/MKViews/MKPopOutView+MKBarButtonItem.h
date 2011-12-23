//
//  MKPopOutView+MKBarButtonItem.h
//  MKKit
//
//  Created by Matthew King on 12/17/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKPopOutView.h"

@class MKBarButtonItem;

/**---------------------------------------------------------------------
 *Overview*
 
 This catagory provides specal methods for displaying an MKPopOverView
 instance from a MKBarButtonItem.
 
 *Required Classes*
 
 * MKPopOutView
 * MKBarButtonItem
----------------------------------------------------------------------*/
@interface MKPopOutView (MKBarButtonItem) 

///-------------------------------
/// @name Displaying
///-------------------------------

/**
 Shows an MKPopOverView with the arrow pointing at a MKBarButtonItem.
 
 @param button the button that arrow should point at.
 
 @param view the superview of the MKPopOverView instance.
*/
- (void)showFromButton:(MKBarButtonItem *)button onView:(UIView *)view;

@end
