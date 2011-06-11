//
//  MKPromptView.h
//  MKKit
//
//  Created by Matthew King on 5/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <MKKit/MKKit/MKViews/MKView.h>

#define MK_PROMPT_VIEW_SHINE            @"MKPromptView-Resources.bundle/PromptShine.png"
#define MK_PROMPT_VIEW_WARING_ICON      @"MKPromptView-Resources.bundle/WarningMarker.png"

typedef enum {
    MKPromptTypeGreen,
    MKPromptTypeAmber,
    MKPromptTypeRed,
} MKPromptType;

/**----------------------------------------------------------------------------------------
 MKPropmtView displays an information prompt on the top of the screen. There are three types
 of prompts that you can pick to display, depending on the importance of the message.
 
 * `MKPromptTypeGreen` : a prompt with a green background.
 * `MKPromptTypeAmber` : a prompt with a yellow background.
 * `MKPromptTypeRed` : a prompt with a red backgrount.
 
 MKPromptView will automaticaly adjust its height to fit the given message.
 ----------------------------------------------------------------------------------------*/

@interface MKPromptView : MKView {
    MKPromptType mType;
    NSTimeInterval mDuration;
}

///---------------------------------------------------------------------------------------
/// @name Creating
///---------------------------------------------------------------------------------------

/**
 Returns a new instance of MKPromptView.
 
 @param type the type of prompt to be displayed.
 
 @param title the title of the prompt
 
 @param message the message of the prompt
*/
- (id)initWithType:(MKPromptType)type title:(NSString *)title message:(NSString *)message;

/** 
 Creates and displays an instance of MKPromptView. The view is displayed with the `MKViewAnimationTypeMoveInFromTop`.
 
 @param type the type of prompt to be displayed.
 
 @param title the title of the prompt
 
 @param message the message of the prompt
 
 @param duration the time in seconds until the prompt is removed
*/
+ (void)promptWithType:(MKPromptType)type title:(NSString *)title message:(NSString *)message duration:(NSTimeInterval)duration;

///---------------------------------------------------------------------------------------
/// @name Behavior Properties
///---------------------------------------------------------------------------------------

/** The type of prompt that is displayed */
@property (nonatomic, assign) MKPromptType type;

/** The Time in Seconds until the prompt is dismissed */
@property (nonatomic, assign) NSTimeInterval duration;

///---------------------------------------------------------------------------------------
/// @name Drawing Methods
///---------------------------------------------------------------------------------------

/** 
 Returns the frame for the view that will fit the message text. This is an internal method and 
 should not be called directly.
 
 @param message The message of the prompt
*/
- (CGRect)frameForMessage:(NSString *)message;

/** 
 Returns the frame for the UILabel that will fit the message text. This is an internal method and 
 should not be called directly.
 
 @param message The message of the prompt
 */
- (CGRect)frameForText:(NSString *)message;

@end
