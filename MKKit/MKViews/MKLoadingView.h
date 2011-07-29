//
//  MKViewLoading.h
//  MKKit
//
//  Created by Matthew King on 7/12/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKView.h"

#import <MKKit/MKKit/MKGraphics/MKGraphics.h>

typedef enum {
    MKLoadingViewTypeIndicator,
    MKLoadingViewTypeProgressBar,
} MKLoadingViewType;

#define MK_LOADING_VIEW_SHOULD_REMOVE_NOTIFICATION      @"MKLoadingViewShouldRemoveNotification"

/**------------------------------------------------------------------------
 MKLoadingView Provides a small view that informs the user of a process taking
 place. There are two types of loading views that can be displayed.
 
 * `MKLoadingViewTypeIndicator` : Shows a UIActivityIndicatorView.
 * `MKLoadingViewTypeProgressBar` : Shows a custom drawn progress bar.
------------------------------------------------------------------------**/

@interface MKLoadingView : MKView {
    MKLoadingViewType mType;
    NSString *mStatusText; 
    
@private
    UILabel *mStatusLabel;
}

///-----------------------------------
/// @name Creating
///-----------------------------------

/**
 Returns and intalized instance of MKLoadingView with the given type and
 status message.
 
 @param type : the type of MKLoadingView to create.
 @param status : the status message displayed on the view

 @return MKLoadingView instance
*/
- (id)initWithType:(MKLoadingViewType)type status:(NSString *)status;

///-----------------------------------
/// @name Behaviors
///-----------------------------------

/** The text displayed on the view */
@property (nonatomic, copy) NSString *statusText;

/** The type of loading view */
@property (nonatomic, assign, readonly) MKLoadingViewType type;

///-----------------------------------
/// @name Progress Bar
///-----------------------------------

/** A float value between 0.0 and 1.0 representing the amount completed
 progress.
 
 @warning *Note* This property is only used on MKLoadingViewTypeProgressBar.
*/
@property (nonatomic, assign) CGFloat progress;

@end

