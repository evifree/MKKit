//
//  MKTabItem.h
//  MKKit
//
//  Created by Matthew King on 8/5/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKViews/MKView.h>

#import "MKTabbedView.h"

@class MKTabbedView;

/**------------------------------------------------------
 MKTabItem provides the individual tabs for the MKTabbedViewController.
 Tabs are rendered using CoreGraphics drawings.
-------------------------------------------------------*/
@interface MKTabItem : MKView {
@private
    BOOL mSelected;
    NSInteger mIndex;
    
    NSString *mTitle;
}

///--------------------------------------
/// @name Creating Instances
///--------------------------------------

/**
 Creates and instacne of MKTabbedView.
 
 @param title this text will be displayed on the tab
 
 @return MKTabbedView instance
*/
- (id)initWithTitle:(NSString *)title;

///-------------------------------------
/// @name Elements
///-------------------------------------

/** the title of the tab */
@property (nonatomic, copy) NSString *title;

/** the index of the tab */
@property (nonatomic, assign) NSInteger index;

///-------------------------------------
/// @name State
///-------------------------------------

/** YES if the tab is selected NO if it is not.
 By default the tab at index 0 is selected, the
 others are not.
 */
@property (nonatomic, assign) BOOL selected;

///--------------------------------------
/// @name Ownership
///--------------------------------------

/** the MKTabbedView instance that the tab belongs to */
@property (nonatomic, retain) MKTabbedView *tabbedView;

@end
