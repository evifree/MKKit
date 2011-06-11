//
//  MKLoginViewController.h
//  MKKit
//
//  Created by Matthew King on 5/8/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKViewControllers/MKViewController.h>

#define PIN_SET                                     @"comboSet"
#define PIN                                         @"combo"

#define CHALLENGE_SET                               @"challengeSet"
#define CHALLENGE_QUESTION                          @"challengeQuestion"
#define CHALLENGE_ANSWER                            @"challengeAnswer"

#define MK_LOGIN_VIEW_HELP_BUTTON                   @"MKLoginView-Resources.bundle/HelpIcon.png"

/**-----------------------------------------------------------------------------
 MKLoginViewController provides an interface for loging into an app using a four
 digit PIN. 
 
 If no PIN is set, MKLoginViewController will allow a PIN to be set and store it
 for future use. The PIN is stored with NSUserDefaults, keys can be accessed by
 the following macros:
 
 * `PIN_SET` : key for a BOOL value telling if a PIN has been set or not.
 * `PIN` : key for an integer value telling the PIN that is currently stored.
 
 MKLoginViewContoller works with MKLoginSettingsViewController which provides
 interfaces to change the PIN and set challenge question to retrive the PIN.
 Challege questions and answers are stored in NSUserDefaults, keys can be accessed
 by the folling macros:
 
 * `CHALLENGE_SET` : key for a BOOL value telling a challege question is set.
 * `CHALLENGE_QUESTION` : key for a NSString representing the challenge question.
 * `CHALLENGE_ANSWER` : key for a NSString representing the challenge answer.
 
 MKLoginViewController calls the following delegate methods:
 
 * `setPin:` called when a user sets a new PIN
 * `pinIsValidated:` called when the entered PIN is validated
 * `maxPinAtemptsMade` called when the maximum number of PIN atempts have been made
 
 @see MKViewControllerDelegate
 
 @warning *Note* MKLoginViewController objects will look for resources in the 
 MKLoginView-Resources bundle. Ensure this bundle is added to your project for 
 proper function.
------------------------------------------------------------------------------*/

@interface MKLoginViewController : MKViewController {
    UILabel *mPromptLabel;
    UIView *mHeaderView;
    
    NSInteger mPin;
    
    BOOL mSecretEntry;
    BOOL mPinIsSet;
    
    NSInteger mMaxAtempts;
    
@private
    UITextField *mBoxOne;
    UITextField *mBoxTwo;
    UITextField *mBoxThree;
    UITextField *mBoxFour;
    
    NSInteger mAtempts;
}

///--------------------------------------------------------------------------
/// @name View Elements
///--------------------------------------------------------------------------

/** The headerView is placed directy above the PIN entry boxes. */
@property (nonatomic, retain) UIView *headerView;

/** The lable displaying text above the PIN entry text feilds */
@property (nonatomic, retain) UILabel *promptLabel;

///--------------------------------------------------------------------------
/// @name PIN Properties
///--------------------------------------------------------------------------

/** The PIN that has been entered. This is a read only property */
@property (nonatomic, assign, readonly) NSInteger pin;

/** This is a read only property, it is set to YES if a PIN is stored and NO
 if one is not. */
@property (nonatomic, assign, readonly) BOOL pinIsSet;

///--------------------------------------------------------------------------
/// @name Behaviors
///--------------------------------------------------------------------------

/** Tells if the Login Controller should hide the values entered by the user.
 YES to hide the values NO to dispaly them. Default is NO. */
@property (nonatomic, assign) BOOL secretEntry;

/** The Maximum number of times an incorrect pin can be entered. A value of 0 
 means infinite atempts. Default is zero.*/
@property (nonatomic, assign) NSInteger maxAtempts;

@end
