//
//  MKControlDelegate.h
//  MKKit
//
//  Created by Matthew King on 9/28/10.
//  Copyright 2010-2011 Matt King All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MKKit/MKKit/MKMacros.h>

typedef enum {
    MKActionTouchDown,
    MKActionTouchUp,
    MKActionValueChanged,
} MKAction;

/**-------------------------------------------------------------------------------------------
 The MKControlDelegate protocol sends genaric messages from MKControl subclasses.
--------------------------------------------------------------------------------------------*/

@protocol MKControlDelegate <NSObject> 

@optional

///-------------------------------------------------------------------------------------------
/// @name Completion Methods
///-------------------------------------------------------------------------------------------

/** Called whenever an action has been completed.
 
 @param sender The MKControl subclass that has completed an action.
 
 @warning *Warning* This method is depreciated. Use didCompleteAction:sender: 
 instead.
*/
- (void)didCompleteAction:(id)sender MK_DEPRECATED_0_8;

/** Called whenever an action has been completed.
 
 @param action The MKAction that was completed.
 @param sender The control that completed the action.
*/
- (void)didCompleteAction:(MKAction)action sender:(id)sender;

@end