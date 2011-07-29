//
//  MKErrorHandeling.h
//  MKKit
//
//  Created by Matthew King on 1/15/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKViews/MKViewHeader.h>

/**--------------------------------------------------------------------------------------------
 The MKErrorHandeling class alerts users when an error occurs. The message is displayed as an 
 MKPromptView it gets the contents of the message from the NSError object that is sent to it.
----------------------------------------------------------------------------------------------*/

@interface MKErrorHandeling : NSObject {

}

///---------------------------------------------
/// @name Handeling Errors
///---------------------------------------------

/** Displays and alert that tells the user the details of the error. 
 
 @param error The error that occoured.
*/
- (void)applicationDidError:(NSError *)error;

/** Displays and alert that tells the user the details of the error. 
 
 @param error The error that occoured.
*/
+ (void)applicationDidError:(NSError *)error;

@end
