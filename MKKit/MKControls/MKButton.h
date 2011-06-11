//
//  MKButton.h
//  MKKit
//
//  Created by Matthew King on 5/28/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKControl.h"

typedef enum {
    MKButtonTypeDarkBlue,
    MKButtonTypeGreen,
} MKButtonType;

#define MK_DARK_BLUE_BUTTON_IMAGE                  @"MKControl-Resources.bundle/BlueButton.png"
#define MK_GREEN_BUTTON_IMAGE                      @"MKControl-Resources.bundle/GreenButton.png"

/**-----------------------------------------------------------------------------
 MKButton provides specalty buttons for various use. There are currently three
 types of buttons:
 
 * `MKButtonTypeDarkBlue` : a dark blue button similar to UIBarButtons
 * `MKButtonTypeGreen` : a brighter green button
 * `MKButtonTypeIAP` : a InApp Purchase button, mimics the purchase buttons from the
 appStore
 
 @warning *Note* MKButton objects will look for resources in the MKControl-Resources 
 bundle. Ensure this bundle is added to your project for proper function.
------------------------------------------------------------------------------*/

@interface MKButton : MKControl {
    MKButtonType mType;
    
    UILabel *mButtonLabel;
    UIImageView *mButtonView;
}

///------------------------------------------------------
/// @name Creating
///------------------------------------------------------

/**
 Returns and instance of MKButton
 
 @param type the type of button to use
 
 @param title the text of the button
 
 There are currently three
 types of buttons:
 
 * `MKButtonTypeDarkBlue` : a dark blue button similar to UIBarButtons
 * `MKButtonTypeGreen` : a brighter green button
 * `MKButtonTypeIAP` : a InApp Purchase button, mimics the purchase buttons from the
 appStore
 */
- (id)initWithType:(MKButtonType)type title:(NSString *)title;

///---------------------------------------------------------
/// @name Behaviors
///---------------------------------------------------------

/** type the Button Type */
@property (nonatomic, assign) MKButtonType type;

@end
