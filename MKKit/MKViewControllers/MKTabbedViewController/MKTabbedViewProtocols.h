//
//  MKTabbedViewProtocols.h
//  MKKit
//
//  Created by Matthew King on 8/4/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKTabbedView;

/**----------------------------------------------------------------
 The MKTabbedViewDataSource Protocol provides methods for suppling content
 for the MKTabbedViewController.
-----------------------------------------------------------------*/
@protocol MKTabbedViewDataSource <NSObject>

///----------------------------------------
/// @name Content Methods
///----------------------------------------

/**
 Return an array of MKTabItem instances. These instances will create
 the tabs of MKTabbedViewController
 
 @param tabbedView the MKTabbedView instance requesing the array.
 
 @exception an excepetion is raise if their are more than 3 MKTabItems
 in the array.
*/
- (NSArray *)tabsForView:(MKTabbedView *)tabbedView;

/**
 Return the view that should be displayed when the tab is touched.
 
 @param index the index of the selected tab.
*/
- (UIView *)viewForTabAtIndex:(NSInteger)index;

@end

/**----------------------------------------------------------------
 The MKTabbedViewDelegate Protocol proivides methods for handling actions
 from the MKTabbedViewController.
-----------------------------------------------------------------*/
@protocol MKTabbedViewDelegate <NSObject>

///----------------------------------------
/// @name Observing Actions
///----------------------------------------

/**
 Called when a tab is selected.
 
 @param tabbedView the tab view
 
 @param index the index of the selected tab.
 
 @warning *Note* MKTabbedViewController will automatically display the content provide
 by the `viewForTabAtIndex:` method. This method is called so you can preform any addtion
 fuctions when a tab is selected.
*/
- (void)tabbedView:(MKTabbedView *)tabbedView didSelectTabAtIndex:(NSInteger)index;

@end