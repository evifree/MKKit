//
//  MKPageControll.h
//  MKKit
//
//  Created by Matthew King on 11/30/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKObject.h"

/**-------------------------------------------------------------------------
 *Overview*
 
 MKPageControl provides methods to assist the UIPageViewController.  MKPageContoll
 is a singleton instance so it can be accessed from all pages.  Set the singleton
 instance to a UIPageViewController datasource and it will control the navigation
 though pages.
 
 *Required Frameworks*
 
 * Foundation
 * UIKit
 
 *Required Classes*
 
 MKObject
--------------------------------------------------------------------------*/

@interface MKPageControl : MKObject <UIPageViewControllerDataSource> {
    NSMutableArray *mPages;
}

///------------------------------------------------
/// @name Creating
///------------------------------------------------

/**
 Returns the singleton instance or creates on if
 it does not exist.
 
 @return MKPageControl singleton
*/
+ (MKPageControl *)sharedPages;

///------------------------------------------------
/// @name Page Controll
///------------------------------------------------

/**
 Adds a page to end of the stack. 
 
 @param page the view controller that to add.
*/
- (void)addPage:(UIViewController *)page;

/**
 Removes all pages from and releases the singleton.
*/
- (void)removeAllPages;

/**
 The next page of the stack. Returns nil if 
 no page exists.
 
 @return UIViewController instance
*/
- (UIViewController *)nextPage;

/**
 The previous page of the stack. Returns nil if 
 no page exists.
 
 @return UIViewController instance
*/
- (UIViewController *)previousPage;

/** The current page number */
@property (nonatomic, readonly) NSInteger currentPage;

/** The total number of pages */
@property (nonatomic, readonly) NSInteger numberOfPages;

///-------------------------------------------------
/// @name Page View Controller
///-------------------------------------------------

/** The UIPageViewController of that is displaying. This property must
 be set manually.
*/
@property (nonatomic, retain) UIPageViewController *pageViewController;

/** The parent of the UIPageViewController. This property must be set
 manually.
*/
@property (nonatomic, retain) UIViewController *parentViewController;

@end
