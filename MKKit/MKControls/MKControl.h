//
//  MKControl.h
//  MKKit
//
//  Created by Matthew King on 10/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKMacros.h>
#import <MKKit/MKKit/MKGraphics/MKGraphics.h>
#import "MKControlDelegate.h"

typedef void (^MKActionBlock)(MKAction action);

@protocol MKControlDelegate;

/**---------------------------------------------------------------------------------------------
 The MKControl class is the super class of all other control objects. This class implements the 
 MKControlDelegate protocol.
-----------------------------------------------------------------------------------------------*/

@interface MKControl : UIControl {
    id mDelegate;
    BOOL mWorking;
}

///---------------------------------------------------------
/// @name Responding to actions
///---------------------------------------------------------

/**
 Sets a code block to complete after an action is completed.
 
 @param actionBlock the code block.
 
 The action block is in this format `^(MKAction action)`.
 MKAction is the action that was completed.
 
 The action will be on of the following types:
 
 * `MKActionTouchDown` : a touch down action.
 * `MKActionTouchUp` : a touch up action.
*/
- (void)completedAction:(MKActionBlock)actionBlock;

///---------------------------------------------------------
/// @name Control States
///---------------------------------------------------------

/** tells if the controll is in working state. Default is `NO`. */
@property (nonatomic, assign) BOOL working;

///---------------------------------------------------------
/// @name Delegate
///---------------------------------------------------------

/** delegate the controls delegate */
@property (nonatomic, assign) id<MKControlDelegate> delegate;

///---------------------------------------------------------
/// @name Code Blocks
///---------------------------------------------------------

/** the action completion block */
@property (nonatomic, copy) MKActionBlock action;

@end
