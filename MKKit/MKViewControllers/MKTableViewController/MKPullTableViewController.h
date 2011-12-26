//
//  MKPullTableViewController.h
//  MKKit
//
//  Created by Matthew King on 12/23/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <UIKit/UIKit.h>

/**--------------------------------------------------------------------------
 *Overview*
 
 MKPullTableViewController is a subclass of UITableViewController that allows
 for pull down actions. This class does not provide any specific action for a 
 pull down such as pull to refresh. Instead it gives the ablitlty to specify 
 a pull down view of any type, and methods for observing pull and release 
 actions. It is upto you to preform any refresh or reloading actions for the
 table views data.
 
 *Observing Actions*
 
 The observation of action are built right into the class; your subclass can
 access them directry without the use of delegate or notifications. You can 
 observe the view being pulled down, pushed back up, released, and when the 
 operations are complete.
 
 @warning *Note* You need to forward the observation method to the super class
 for this view controller to function properly.
 
 *Required Frameworks*
 
 * Foundation
 * UIKit
---------------------------------------------------------------------------*/

@interface MKPullTableViewController : UITableViewController {
    UIView *mPullDownView;
    CGFloat mContentHeight;
    struct {
        BOOL isWorking;
        BOOL isDraging;
    } MKPullTableViewControllerFlags;
}

///-----------------------------------------
/// @name Pull Down View
///-----------------------------------------

/** 
 The view that will be shown when the table view is pulled Down.
 This view can be any height, MKPullDownTableViewController will
 adjust accordingly to fit the height of the view.
 
 @warning *Note* If the pullDownView has a height that is grater 
 than the available display area, the pull down control will not
 function properly.
*/
@property (nonatomic, retain) UIView *pullDownView;

///-----------------------------------------
/// @name Observing Pull Down Actions
///-----------------------------------------

/**
 Is set to `YES` when a pullDownView is fully pulled down and 
 release. Will return to `NO` when the shouldReturnPullDownView
 method is called. Default is `NO`.
 
 @warning *Note* When working is set to `YES`, no pull or push
 actions will be called.
*/
@property (nonatomic, readonly) BOOL working;

/**
 Called when the pull down view full pulled onto the screen
 
 @warning *Note* This method is called from the scroll view
 delegate, it may be called several time in a row.
*/
- (void)didPullDownPullDownView;

/** 
 Called when the pull down is pushed back up before being released.
 
 @warning *Note* This methoe is called from the scroll view delegate,
 it may be called several times in a row
*/
- (void)didPushUpPullDownView;

/** 
 Called when the pull down view is pulled and complete and then the 
 user lifts their finger from the screen.
 
 Use this method to pefrom any operations that pulling down the 
 table view will cause. (i.e., refresh data sources).
 
 @warning *Note* It is required that subclasses call `[surer didReleasePullDownView]`
 in this method.  The pull down view will not function properly if this is not
 done.
*/
- (void)didReleasePullDownView;

/**
 Called after the pull down view is progamatically moved of the top
 of the screen.
*/
- (void)pullDownOperationsCompleted;

///------------------------------------------
/// @name Notifications
///------------------------------------------

/**
 Subclasses should call this method when they have completed the 
 operations preformed in the didReleasePullDownView method.
 
 Calling this method will move the pull down view back of the top 
 of the view and call the pullDownOpertaionsCompleted method.
*/
- (void)shouldReturnPullDownView;

@end
