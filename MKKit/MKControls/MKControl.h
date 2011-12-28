//
//  MKControl.h
//  MKKit
//
//  Created by Matthew King on 10/5/10.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKMacros.h>
#import <MKKit/MKKit/MKGraphics/MKGraphics.h>

#import "MKControlDelegate.h"

typedef void (^MKActionBlock)(MKAction action);

typedef enum {
    MKControlStateNormal        = 1,
    MKControlStateHighlighted   = 2,
    MKControlStateDisabled      = 3,
    MKControlStateWorking       = 4,
} MKControlState;

CGColorRef topColorForControlState(MKControlState state, MKGraphicsStructures *graphics);
CGColorRef bottomColorForControlState(MKControlState state, MKGraphicsStructures *graphics);

@class MKGraphicsStructures;

@protocol MKControlDelegate;

/**---------------------------------------------------------------------------------------------
 *Overview*
 
 The MKControl class is the super class of all other control objects of MKKit. 
 
 *Observing Actions*
 
 MKControl objects dispatch events in three ways, delegate methods, blocks, and by assigning 
 targets and selectors. Each one sends actions according to one or more of the MKAction types.
 You should be looking for one of the following action types:
 
 * `MKActionTouchDown` : a touch down action.
 * `MKActionTouchUp` : a touch up action.
 * `MKActionValueChanged` : a change of value action.
 * `MKActionValueIncreased` : a increase of a controls value.
 * `MKActionValueDecreased` : a decrease of a controls value.
 
 @warning *Note* Not all controls dispatch every action. Check the documention of the control
 you are using to see what events it will dispatch.
 
 *Changing/Observing Control States*
 
 Contols states can be observed or changed with use of the controlState property. This property
 will be on of four values:
 
 * `MKControlStateNormal` : A control the is enabled and can receive actions
 * `MKControlStateHighlighted` : A control that is being touched
 * `MKControlStateDisabled` : A control that is disabled and cannot recive actions
 * `MKControlStateWorking` : A contol the procecessing an action. Control will be disabled while 
 in a working state.
 
 *MKGraphics Support*
 
 MKControl conforms to the MKGraphicsFactory protocol. Check subclass documentation for specifics
 on what graphic properties are expected.
 
 *Required Frameworks*
 
 * Foundation
 * UIKit
 * Quartz Core
 * Core Graphics
 
 *Required Classes*
 
 * MKMacros
 * MKGraphics
 
 *Required Protocols
 
 * MKControlDelegate
-----------------------------------------------------------------------------------------------*/

@interface MKControl : UIControl <MKGraphicFactory> {
    id mDelegate;
    BOOL mWorking;
    NSMutableSet *mTargets;
    MKGraphicsStructures *mGraphics;
    MKControlState mControlState;
    
    struct {
        bool blockUsage;
        bool targetUsage;
        bool isEnabled;
        bool isHighlighted;
    } MKControlFlags;
}

///---------------------------------------------------------
/// @name Positioning
///---------------------------------------------------------

/** 
 Moves the location of the control object. The point assigned
 will represent the top left conner of the control

 @warning *Note* Many MKControl objects set their own width and
 height. Using the location property is the preffered method of
 moving a controls position.
*/
@property (nonatomic, assign) CGPoint location;

///---------------------------------------------------------
/// @name Responding to actions
///---------------------------------------------------------

/**
 Sets a code block to complete after an action is completed.
 
 @param actionBlock the code block.
 
 The action block is in this format `^(MKAction action)`.
 MKAction is the action that was completed.
*/
- (void)completedAction:(MKActionBlock)actionBlock;

/**
 Sets the target and callback method to perform after an action takes place.
 
 @param target the object to send the message to.
 
 @param selector the selector to call.
 
 @param action the action to listen for.
*/
- (void)addTarget:(id)target selector:(SEL)selector action:(MKAction)controlAction;

///---------------------------------------------------------
/// @name Control States
///---------------------------------------------------------

/** tells if the controll is in working state. Default is `NO`. */
@property (nonatomic, assign) BOOL working;

/** The state of a control object. Possible Values are:
 
 * `MKControlStateNormal` : A control the is enabled and can receive actions
 * `MKControlStateHighlighted` : A control that is being touched
 * `MKControlStateDisabled` : A control that is disabled and cannot recive actions
 * `MKControlStateWorking` : A contol the procecessing an action. Control will be disabled while 
 in a working state.
*/
@property (nonatomic, assign) MKControlState controlState;

///---------------------------------------------------------
/// @name Delegates
///---------------------------------------------------------

/** delegate the controls delegate */
@property (nonatomic, assign) id<MKControlDelegate> delegate;

///---------------------------------------------------------
/// @name Code Blocks
///---------------------------------------------------------

/** the action completion block */
@property (nonatomic, copy) MKActionBlock action;

///---------------------------------------------------------
/// @name Sending Actions
///---------------------------------------------------------

/** 
 Sends actions to the targest, blocks, and delegates.
 
 @param action the action to send
*/
- (void)processAction:(MKAction)action;

///--------------------------------------------------------
/// @name Observing Changes
///--------------------------------------------------------

/**
 This method is for catagories to observer dealloc calls. Default 
 implemtation does nothing.
*/
- (void)didRelease;

@end

@interface MKControlTarget : NSObject

@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, assign) MKAction action;

@end

