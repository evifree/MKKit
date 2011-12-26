//
//  MKView.h
//  MKKit
//
//  Created by Matthew King on 10/9/10.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKDeffinitions.h>
#import <MKKit/MKKit/MKMacros.h>
#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKGraphics/MKGraphics.h>

#import "MKViewDelegate.h"

typedef enum {
    MKViewAnimationTypeNone,
    MKViewAnimationTypeFadeIn,
    MKViewAnimationTypeMoveInFromTop,
    MKViewAnimationTypeAppearAboveToolbar,
} MKViewAnimationType;

typedef enum {
    MKTableHeaderTypeGrouped,
    MKTableHeaderTypePlain,
} MKTableHeaderType;

@protocol MKViewDelegate;

@class MKImage;

/**-------------------------------------------------------------------------------------------------------
 *Overview*
 
 The MKView class is a super class for specialty views. MKView adopts the MKViewDelegate protocol. When the 
 showWithAnimationType: method is used, views are add to the application's keyWindow. 
 
 The folling `MKViewAnimationType`(s) are avialible:
 
 * `MKViewAnimationTypeNone` : No animations are preformed. View will just appear on the screen.
 * `MKViewAnimationTypeFadeIn` : The View will Fade onto the screen.
 * `MKViewAnimationTypeMoveInFromTop` : The View will slide onto the screen from the top.
 * `MKViewAnimationTypeAppearAboveToolbar ` : The View will above so it is placed just above a toolbar.
 
 @warning *Note* When the showWithAnitmationType: method is used, views are added to the application's 
 key window. Some subclass of MKView handel removing themselfs. You should check the documentation of the
 given class for removal options.
 
 *Drawing of Views*
 
 MKView supports the use of MKGraphicsStructures and conforms to the MKGraphicsFactory protocol. If you
 are not using a graphics dictionay you set a MKGraphicsInstance using the graphicsStructure property. 
 *Note. Setting the graphicsStucture property will cause the view to redraw itself.* MKView will look for 
 following graphics properties:
 
 * `fill` : if a fill propery is set, it will be used to color the view. If the fill property is nil, 
 instance will look for top an bottom properties to create a gradiant fill.
 * `top` : this will be the top half of the views background fill.
 * `bottom` : this will be the bottom half of the view background fill.
 * `usesLinerShine` : tells if the backgound will have a liner shine added or not.
 
 *Required Frameworks*
 
 * UIKit
 * Foundation
 * Core Graphics
 
 *Required Classes*
 
 * MKGraphics
 * MKGraphicStructures
 * MKMacros
 
 *Required Protocols
 
 * MKViewDelegate
-------------------------------------------------------------------------------------------------------*/

@interface MKView : UIView <MKGraphicFactory> {
    id mDelegate;
    UIViewController *mController;
    BOOL mShouldRemoveView;
    MKViewAnimationType mAnimationType;
    MKGraphicsStructures *mGraphics;
    
@private
    struct {
        bool isHeaderView;
        bool isHeaderGrouped;
        bool isHeaderPlain;
        bool usesBackGroundFill;
    } MKViewFlags;
}

///------------------------------------------------------
/// @name Displaying
///------------------------------------------------------

/** Displayes the View on the applications key window. View can be animated onto the screen using a MKViewAnimationType.
 
 @param type the type of animations used to display the view.
*/
- (void)showWithAnimationType:(MKViewAnimationType)type;

/** Displays the View on the specified view Controller. Views can be animated onto the screen using a MKViewAnimationType.
 
 @param controller the view controller to display the view on
 
 @param type the type of animation used to display the view.
*/
- (void)showOnViewController:(UIViewController *)controller animationType:(MKViewAnimationType)type;

/** Removes the view from the Screen. The view is removed by reversing the MKViewAnimationType that was used to 
 display it.
*/
- (void)removeView;

///----------------------------------------------------
/// @name Location
///----------------------------------------------------

/** The x orign of the view */
@property (nonatomic, assign) CGFloat x;

/** The y origin of the view */
@property (nonatomic, assign) CGFloat y;

/** The width of the view */
@property (nonatomic, assign) CGFloat width;

/** The height of the view */
@property (nonatomic, assign) CGFloat height;

///----------------------------------------------------
/// @name Graphics Settings
///----------------------------------------------------

/** *DEPRECATED v0.9* use graphicStructure instead.*/
@property (nonatomic, retain) MKGraphicsStructures *gradient;// MK_DEPRECATED_0_9;

///-----------------------------------------------------
/// @name Ownership
///-----------------------------------------------------

/** The view controller that owns the view. */
@property (nonatomic, retain) IBOutlet UIViewController *controller;

///------------------------------------------------------
/// @name Delegate
///------------------------------------------------------

/** The MKViewDelegate */
@property (nonatomic, assign) id<MKViewDelegate> delegate;

- (void)didRelease;

@end

/**-----------------------------------------------------------------------
 This category makes a clone of the iOS Grouped table section header. With 
 this class you have control of the UILabel instance, not just the text. 
------------------------------------------------------------------------*/
@interface MKView (MKTableHeader) 

///---------------------------------------------
/// @name Creating
///---------------------------------------------

/**
 Returns an instace of MKView sized for a grouped table header.
 
 @param title the text that will display on the header.
 
 @param type the header type to return
 
 * `MKTableHeaderTypeGrouped` : Returns a header for grouped tables
 * `MKTableHeaderTypePlain` : Returns a header for plain tables
 
 @return MKView instance
*/
- (id)initWithTitle:(NSString *)title type:(MKTableHeaderType)type;

/**
 Returns an instace of MKView sized for a grouped table header.
 
 @param title the text that will display on the header.
 
 @param type the header type to return
 
 * `MKTableHeaderTypeGrouped` : Returns a header for grouped tables
 * `MKTableHeaderTypePlain` : Returns a header for plain tables
 
 @return MKView instance
*/
+ (id)headerViewWithTitle:(NSString *)title type:(MKTableHeaderType)type;

///---------------------------------------------
/// @name View Elements
///---------------------------------------------

/** The UILabel instance that is displayed on the view */
@property (nonatomic, retain) UILabel *titleLabel;

@end

/**-----------------------------------------------------------------------
 *Deprecated Catagory v0.9. Use MKImage methods instead.*
 -----------------------------------------------------------------------*/
@interface MKView (IconMask)

///---------------------------------------------
/// @name Depreciations
///---------------------------------------------

/**
 @warning *Deprecated Method v0.9* Use MKImage methods instead.
*/
- (id)initWithImage:(UIImage *)image gradient:(MKGraphicsStructures *)gradient MK_DEPRECATED_0_9;

/** 
 @warning *Deprecated Property v0.9* 
*/
@property (nonatomic, retain) UIImage *image MK_DEPRECATED_0_9;

@end

NSString *MKViewShouldRemoveNotification MK_VISIBLE_ATTRIBUTE;