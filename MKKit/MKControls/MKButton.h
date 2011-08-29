//
//  MKButton.h
//  MKKit
//
//  Created by Matthew King on 5/28/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKControl.h"

typedef enum {
    MKButtonTypeHelp,
    MKButtonTypeDisclosure,
    MKButtonTypeIAP,
    MKButtonTypePlastic,
    MKButtonTypeRoundedRect,
} MKButtonType;

static const float kHorizPadding                = 20.0;
static const float kDiscloserOutlinePadding     = 2.0;
static const float kHelpButtonFontSize          = 18.0;
static const float kIAPButtonFontSize           = 14.0;
static const float kPlasticButtonFontSize       = 30.0;
static const float kRoundRectButtonFontSize     = 14.0;

/**-----------------------------------------------------------------------------
 MKButton provides specalty buttons for various use. There are currently four
 types of buttons:
 
 * `MKButtonTypeHelp` : a small round button with a question mark
 * `MKButtonTypeDisclosure` : a blue and white button that resembles iOS discloser button
 * `MKButtonTypeIAP` : a InApp Purchase button, mimics the purchase buttons from the
 * `MKButtonTypeRoundedRect` : a rounded rect button that can be assigned a color
 appStore
------------------------------------------------------------------------------*/

@interface MKButton : MKControl {
    MKButtonType mType;
    NSString *mButtonText;

@private
    UILabel *mButtonLabel;
    
    struct {
        bool isWorking;
        bool isHighlighted;
        CGColorRef tintColor;
        CGFloat fontSize;
    } MKButtonFlags;
}

///------------------------------------------------------
/// @name Creating
///------------------------------------------------------

/** 
 Returns and instance of MKButton
 
 @param type the type of button to use
 
 @param title the text of the button
*/
- (id)initWithType:(MKButtonType)type;

/**
 Returns and instance of MKButton
 
 @param type the type of button to use
 
 @param title the text of the button
*/
- (id)initWithType:(MKButtonType)type title:(NSString *)title;

/**
 Returns and instance of MKButton
 
 @param type the type of button to use
 
 @param title the text of the button
 
 @param tint the tint color of the button
*/
- (id)initWithType:(MKButtonType)type title:(NSString *)title tint:(UIColor *)tint;


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

/** the tint color of a MKButtonTypeRoundedRect */ 
@property (nonatomic, retain) UIColor *tintColor;

/** the size of the font on the button */
@property (nonatomic, assign) CGFloat fontSize;
           
@end
