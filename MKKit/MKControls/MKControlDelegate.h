//
//  MKControlDelegate.h
//  MKKit
//
//  Created by Matthew King on 9/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**-------------------------------------------------------------------------------------------
 The MKControlDelegate protocol sends genaric messages from MKControl subclasses.
--------------------------------------------------------------------------------------------*/

@protocol MKControlDelegate <NSObject> 

@optional

///-------------------------------------------------------------------------------------------
/// @name Completion Methods
///-------------------------------------------------------------------------------------------

/** Called whenever and action has been completed.
 
 @param sender The MKControl subclass that has completed an action.
*/
- (void)didCompleteAction:(id)sender;

@end