//
//  MKTabbedView.h
//  MKKit
//
//  Created by Matthew King on 8/4/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKViews/MKView.h>

#import "MKTabbedViewProtocols.h"
#import "MKTabItem.h"

@protocol MKTabbedViewDataSource;
@protocol MKTabbedViewDelegate;

@class MKTabView;
@class MKTabItem;

/**----------------------------------------------------------
 MKTabbedView provides the view for the MKTabbedViewController.
 Tabs and content display is controlled by this class.
 
 MKTabbedView controller implements the `MKTabbedViewDataSource`,
 and `MKTabbedViewDelegate`.
-----------------------------------------------------------*/
@interface MKTabbedView : MKView {
    id mDataSource;
    id mTabbedDelegate;
    
@private
    MKTabView *mTabView;
    MKView *mContentView;
    NSArray *tabs;
}

///---------------------------------------------------------
/// @name Tab Control
///---------------------------------------------------------

/**
 Gets the tabs from the `MKTabbedViewDataSource` and sets them on the view.
 
 @exception Invalid Array : rasied the NSArray returned by the datasource 
 contains more than 3 objects.
*/
- (void)setTabs;

/**
 Displays the content of the selected provide by the `MKTabbedDataSource`.
*/
- (void)switchToTabAtIndex:(NSInteger)index;

///----------------------------------------------------------
/// @name Getting Tabs
///----------------------------------------------------------

/** 
 Returns the tab for the specified index.
 
 @param index the index of the tab.
 
 @return MKTabItem instance
*/
- (MKTabItem *)tabAtIndex:(NSInteger)index;

///----------------------------------------------------------
/// @name Protocols
///----------------------------------------------------------

/** The MKTabbedViewDataSource */
@property (nonatomic, assign) id<MKTabbedViewDataSource> dataSource;

/** The MKTabbedViewDelegate */
@property (nonatomic, assign) id<MKTabbedViewDelegate> tabbedDelegate;

@end

@interface MKTabView : MKView {
@private

}

@end