//
//  MKBarButtonItem.h
//  MKKit
//
//  Created by Matthew King on 6/18/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKControl.h"

typedef enum {
    MKBarButtonItemIcon,
    MKBarButtonItemBackArrow,
    MKBarButtonItemForwardArrow,
} MKBarButtonItemType;

@class MKImage;

/**----------------------------------------------------------------------------
 MKBarButtonItem creates buttons for use on a tab bar. The button that will be displayed
 depends on the MKBarButtonItemType that is set. Currently There are three types:
 
 * `MKBarButtonItemIcon` : a button created from an image. Use initWithIcon method
 to for this type.
 * `MKBarButtonItemBackArrow` : a triangle pointing to the left.
 * `MKBarButtonItemForwardArrow`  : a triangle pointing to the right.
 
 *Required Frameworks*
 
 * Foundation
 * UIKit
 * Quartz Core
 
 *Required Classes
 
 * MKControl
 * MKImage
------------------------------------------------------------------------------*/

@interface MKBarButtonItem : MKControl {
    MKBarButtonItemType mType;
    
@private
    struct {
        BOOL requiresDrawing;
        BOOL isBordered;
    } MKBarButtonItemFlags;
}

///-----------------------------------------
/// @name Creating
///-----------------------------------------

/**
 Returns an intialized instance of MKBarButtonItem and sets the MKBarButtonItemType.
 
 @param type the type of button to be displayed

 Currently There are three types:
 
 * `MKBarButtonItemIcon` : a button created from an image. Use initWithIcon method
 to for this type.
 * `MKBarButtonItemBackArrow` : a triangle pointing to the left.
 * `MKBarButtonItemForwardArrow` : a triangle pointing to the right.
 
 @return MKBarButtonItem instance
*/
- (id)initWithType:(MKBarButtonItemType)type;

/**
 Creates an instace of MKBarButtonItem from an image.
 
 @param icon the image to use for the button
 
 @return MKBarButtonItem instance
*/
- (id)initWithIcon:(MKImage *)icon;

///------------------------------------------
/// @name Behaviors
///------------------------------------------

/** Set to `YES` to have border drawn around the button */
@property (nonatomic, assign) BOOL bordered;

///------------------------------------------
/// @name Types
///------------------------------------------

/** The type of button that is assigned */
@property (nonatomic, assign) MKBarButtonItemType type;

@end
