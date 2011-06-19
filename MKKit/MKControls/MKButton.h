//
//  MKButton.h
//  MKKit
//
//  Created by Matthew King on 5/28/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKControl.h"

typedef enum {
    MKButtonTypeIAP,
    MKButtonTypeDarkBlue,
    MKButtonTypeGreen,
    MKButtonTypeHelp,
} MKButtonType;

/**-----------------------------------------------------------------------------
 MKButton provides specalty buttons for various use. There are currently four
 types of buttons:
 
 * `MKButtonTypeIAP` : a InApp Purchase button, mimics the purchase buttons from the
 appStore
 * `MKButtonTypeDarkBlue` : a dark blue button similar to UIBarButtons
 * `MKButtonTypeGreen` : a brighter green button
 * `MKButtonTypeHelp` : a small round button with a question mark
------------------------------------------------------------------------------*/

@interface MKButton : MKControl {
    MKButtonType mType;
    NSString *mButtonText;
    
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
 
 There are currently four types of buttons:
 
 * `MKButtonTypeDarkBlue` : a dark blue button similar to UIBarButtons
 * `MKButtonTypeGreen` : a brighter green button
 * `MKButtonTypeIAP` : a InApp Purchase button, mimics the purchase buttons from the
 appStore
 * `MKButtonTypeHelp` : a small round button with a question mark
*/
- (id)initWithType:(MKButtonType)type;

/**
 Returns and instance of MKButton
 
 @param type the type of button to use
 @param title the text of the button
 
 There are currently four types of buttons:
 
 * `MKButtonTypeDarkBlue` : a dark blue button similar to UIBarButtons
 * `MKButtonTypeGreen` : a brighter green button
 * `MKButtonTypeIAP` : a InApp Purchase button, mimics the purchase buttons from the
 appStore
 * `MKButtonTypeHelp` : a small round button with a question mark
 
 @exception UnsuableType rasied if MKButtonTypeHelp is passed to this method.
 */
- (id)initWithType:(MKButtonType)type title:(NSString *)title;


///---------------------------------------------------------
/// @name Elements
///---------------------------------------------------------

/** the text to display on the button */
@property (nonatomic, copy) NSString *buttonText;

///---------------------------------------------------------
/// @name Behaviors
///---------------------------------------------------------

/** type the Button Type */
@property (nonatomic, assign) MKButtonType type;

@end
