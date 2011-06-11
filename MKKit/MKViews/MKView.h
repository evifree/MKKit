//
//  MKView.h
//  MKKit
//
//  Created by Matthew King on 10/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <MKKit/MKKit/MKDeffinitions.h>
#import <MKKit/MKKit/MKMacros.h>
#import <UIKit/UIKit.h>

#import "MKViewDelegate.h"

typedef enum {
    MKViewAnimationTypeNone,
    MKViewAnimationTypeFadeIn,
    MKViewAnimationTypeMoveInFromTop,
    MKViewAnimationTypeAppearAboveToolbar,
} MKViewAnimationType;

@protocol MKViewDelegate;

/**-------------------------------------------------------------------------------------------------------
 The MKView class is a super class for specialty views. MKView adopts the MKViewDelegate protocol. When the 
 showWithAnimationType: method is used, views are add to the application's keyWindow. 
 
 @warning *Note* When the showWithAnitmationType: method is used, views are added to the application's 
 key window. Some subclass of MKView handel removing themselfs. You should check the documentation of the
 given class for removal options.
-------------------------------------------------------------------------------------------------------*/

@interface MKView : UIView {
    id mDelegate;
    
    UIViewController *mController;
    
@private
    MKViewAnimationType mAnimationType;
    BOOL mShouldRemoveView;
}

///------------------------------------------------------
/// @name Displaying
///------------------------------------------------------

/** Displayes the View on the applications key window. View can be animated onto the screen using a MKViewAnimationType.
 
 @param type the type of animations used to display the view.
 
 The folling `MKViewAnimationType`(s) are avialible:
 
 * `MKViewAnimationTypeNone` : No animations are preformed. View will just appear on the screen.
 * `MKViewAnimationTypeFadeIn` : The View will Fade onto the screen.
 * `MKViewAnimationTypeMoveInFromTop` : The View will slide onto the screen from the top.
 * `MKViewAnimationTypeAppearAboveToolbar ` : The View will above so it is placed just above a toolbar.
 
*/
- (void)showWithAnimationType:(MKViewAnimationType)type;

/** Removes the view from the Screen. The view is removed by reversing the MKViewAnimationType that was used to 
 display it.
*/
- (void)removeView;

///-----------------------------------------------------
/// @name Ownership
///-----------------------------------------------------

/** The view controller that owns the view. */
@property (nonatomic, retain) UIViewController *controller;

///------------------------------------------------------
/// @name Delegate
///------------------------------------------------------

/** The MKViewDelegate */
@property (nonatomic, assign) id<MKViewDelegate> delegate;

@end