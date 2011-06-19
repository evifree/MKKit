//
//  MKControlDelegate.h
//  MKKit
//
//  Created by Matthew King on 9/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MKActionTouchDown,
    MKActionTouchUp,
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
 
 @warning *Warning* This method is scheduled for depreciation. Use didCompleteAction:sender: 
 instead.
*/
- (void)didCompleteAction:(id)sender;

/** Called whenever an action has been completed.
 
 @param action The MKAction that was completed.
 @param sender The control that completed the action.
*/
- (void)didCompleteAction:(MKAction)action sender:(id)sender;

@end