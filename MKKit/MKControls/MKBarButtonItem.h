//
//  MKBarButtonItem.h
//  MKKit
//
//  Created by Matthew King on 6/18/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKControl.h"

#import <MKKit/MKKit/MKGraphics/MKGraphics.h>

typedef enum {
    MKBarButtonItemBackArrow,
    MKBarButtonItemForwardArrow,
} MKBarButtonItemType;

/**----------------------------------------------------------------------------
 MKBarButtonItem creates buttons for use on a tab bar. The button that will be displayed
 depends on the MKBarButtonItemType that is set. Currently There are two types:
 
 * `MKBarButtonItemBackArrow` a triangle pointing to the left.
 * `MKBarButtonItemForwardArrow` a triangle pointing to the right.
------------------------------------------------------------------------------*/

@interface MKBarButtonItem : MKControl {
    MKBarButtonItemType mType;
}

///-----------------------------------------
/// @name Creating
///-----------------------------------------

/**
 Returns an intialized instance of MKBarButtonItem and sets the MKBarButtonItemType.
 
 @param type the type of button to be displayed

 Currently There are two types:
 
 * `MKBarButtonItemBackArrow` a triangle pointing to the left.
 * `MKBarButtonItemForwardArrow` a triangle pointing to the right.
*/
- (id)initWithType:(MKBarButtonItemType)type;

/** The type of button that is assigned */
@property (nonatomic, assign) MKBarButtonItemType type;

@end
