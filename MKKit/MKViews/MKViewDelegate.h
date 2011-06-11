//
//  MKViewDelegate.h
//  MKKit
//
//  Created by Matthew King on 10/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKView;

/**-------------------------------------------------------------------
 The MKViewDelegate protocol provides delegate methods for MKView and 
 its subclasses
--------------------------------------------------------------------*/

@protocol MKViewDelegate <NSObject>

@optional

///------------------------------------------------------------------
/// @name Add/Remove methods
///------------------------------------------------------------------

/**
 Some MKView objects will automatically remove themselfs after a certain action. This
 method can be used to set if the view should be removed or not.  If this method is not
 used the MKView object follows its default behaivor.
 
 @param view the MKView that is asking to be removed.
*/
- (BOOL)shouldRemoveView:(MKView *)view;

/**
 Called after a view is added to the screen
 
 @param view the MKView that was added.
*/
- (void)MKViewDidAppear:(MKView *)view;

///------------------------------------------------------------------
/// @name MKPopOverView Methods
///------------------------------------------------------------------

/**
 Called when a cell of the popover view is selected.
 
 @param view the MKKView that recived the selection.
 
 @param index the index of the selected cell.
*/
- (void)popOverView:(MKView *)view selectedCellAtIndex:(NSInteger)index;

@end