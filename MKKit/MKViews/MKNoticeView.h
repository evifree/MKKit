//
//  MKNoticeView.h
//  MKKit
//
//  Created by Matthew King on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MKView.h"

/**------------------------------------------------------------------------------
 MKNoticeView is used to dispaly quick notices to the user. The factory method, 
 showWithMessage:duration: will display the view for a set pierod of time and 
 then remove it. 
 
 MKNoticeView is designed for short messages such as "Action Complete".
------------------------------------------------------------------------------*/ 

@interface MKNoticeView : MKView {
    NSTimeInterval mDuration;
}

///---------------------------------------------
/// @name Creating
///---------------------------------------------

/**
 Returns an intalized instance of MKNoticeView.
 
 @param message the message displayed to the user
 
 When using this method you are resposible for displaying and removing the view.
 You can set the duration property to remove the veiw after a set time.
*/
- (id)initWithMessage:(NSString *)message;

/**
 Creates and displays an instance of MKNoticeView. The view is displayed using
 `MKViewAnimationTypeFadeIn`.
 
 @param message the message displayed to the user
 
 @param timeDuration length of time the messege will stay on screen
*/
+ (void)showWithMessage:(NSString *)message duration:(NSTimeInterval)duration;

/**
 Creates and displays an instance of MKNoticeView. The view is displayed using
 `MKViewAnimationTypeFadeIn`.
 
 @param message the message displayed to the user
 
 @param controller the view controller that the MKNoticeView will be displayed on
 
 @param duration length of time the messege will stay on screen
*/
+ (void)showWithMessage:(NSString *)message onViewController:(UIViewController *)controller duration:(NSTimeInterval)duration;

///---------------------------------------------
/// @name Behaviors
///---------------------------------------------

/** The length of time passed before the view is removed */
@property (nonatomic, assign) NSTimeInterval duration;

@end
