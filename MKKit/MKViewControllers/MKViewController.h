//
//  MKViewController.h
//  MKKit
//
//  Created by Matthew King on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MKKit/MKKit/MKViews/MKViewHeader.h>
#import <MKKit/MKKit/MKDeffinitions.h>
#import <MKKit/MKKit/MKGraphics/MKGraphics.h>
#import <MKKit/MKKit/MKMacros.h>

#import "MKViewControllerDelegate.h"

@protocol MKViewControllerDelegate;

/**---------------------------------------------------------------------------------------------
 MKViewController is a subclass of UIViewController. This class is designed as supper class for other
 specialty view controllers used by the MKKit.
 -----------------------------------------------------------------------------------------------*/

@interface MKViewController : UIViewController {
    id mDelegate;
}

- (id)initWithDelegate:(id)delegate;

///----------------------------------------------------------------
/// @name Notification Methods
///----------------------------------------------------------------

/** 
 Notifies the delegate that the done button has been tapped. This method
 should not be called directly.
 
 @param sender the view controller sending the message to the delegate
*/
- (void)done:(id)sender;

/** 
 Notifies the delegate that the an action button has been tapped. This method
 should not be called directly.
 
 @param sender the view controller sending the message to the delegate
*/
- (void)action:(id)sender;

///----------------------------------------------------------------
/// @name Delegate
///----------------------------------------------------------------

/** The MKViewControllerDelegate */
@property (assign) id<MKViewControllerDelegate> delegate;

@end
