//
//  MKViewControllerDelegate.h
//  MKKit
//
//  Created by Matthew King on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKViewController;

/**----------------------------------------------------------------------------------------------------
 The MKViewControllerDelegate protocol gives methods to observe actions from a MKViewConrtroller. 
 
 @warning *Note* not all delegate methods are called by all MKViewController sub classes. Read over this
 documention of the subclasses to find what methods are called.
 -----------------------------------------------------------------------------------------------------*/

@protocol MKViewControllerDelegate <NSObject>

@optional

///----------------------------------------------------------------------------------------------
/// @name View Controller Methods
///----------------------------------------------------------------------------------------------

/**
 Called the done button of a MKViewController is tapped. This is typically used to dismiss a model view controller
 
 @param viewController the view controller where the done button was tapped
*/
- (void)viewControllerIsDone:(MKViewController *)viewController;

/**
 Called when the action button of MKViewController is tapped. 
 
 @param viewController the view contoller where the action button was tapped
*/
- (void)viewControllerAction:(MKViewController *)viewController;

///--------------------------------------------------------------------------------------------------
/// @name Login View Controller Methods
///--------------------------------------------------------------------------------------------------

/**
 Called when a PIN is entered into the MKLoginViewController.
 
 @param validated YES if the PIN is correct NO if it is not.
*/
- (void)pinIsValidated:(BOOL)validated;

/**
 Called when a New Pin has been set.
 
 @param pin the pin that has been set.
*/
- (void)setPin:(NSInteger)pin;

/**
 Called when the maximum PIN Atempts have been made.
 
 Return YES to clear PIN from memory.
*/
- (BOOL)maxPinAttemptsMade;

@end
