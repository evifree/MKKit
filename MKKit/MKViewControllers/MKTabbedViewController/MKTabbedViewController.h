//
//  MKTabbedViewController.h
//  MKKit
//
//  Created by Matthew King on 8/4/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKViewControllers/MKViewController.h>

#import "MKTabbedView.h"

/**-----------------------------------------------------------
 MKTabbedViewController implents an interface for display views
 usings tabs. Three tabs are displayed at the top of the view, each
 displaying a unique view. 
 
 Content of the views are provided by the `MKTabbedViewDataSource`,
 and changes can be monitored with the `MKTabbedViewDelegae`.
 MKTabbedViewController conforms to both of these protocols. 
------------------------------------------------------------*/

@interface MKTabbedViewController : MKViewController <MKTabbedViewDelegate, MKTabbedViewDataSource> {
@private 
    MKTabbedView *mTabbedView;
}

///---------------------------------------
/// @name Elements
///---------------------------------------

/** a `MKTabbedView` intsance */
@property (nonatomic, retain, readonly) MKTabbedView *tabbedView;

@end
