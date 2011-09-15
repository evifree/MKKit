//
//  MKTableCell.h
//  MKKit
//
//  Created by Matthew King on 3/19/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKControls/MKContolHeaders.h>
#import <MKKit/MKKit/MKErrorContol/MKInputValidation.h>
#import <MKKit/MKKit/MKErrorContol/MKValidator.h>

#import <MKKit/MKKit/MKDeffinitions.h>
#import <MKKit/MKKit/MKMacros.h>
#import <MKKit/MKKit/MKStrings.h>

#import "MKTableElements/MKMaskIconView.h"
#import "MKTableElements/MKElementAccentView.h"
//#import "MKTableElements/MKSwipeCellView.h"
#import "MKTableElements/MKTableCellAccentView.h"

#import "MKTableCellDelegate.h"

static const int kPrimaryViewTag                    = 1;
static const int kSecondaryViewTag                  = 2;
static const int kIconViewTag                       = 3;
static const int kAccentViewTag                     = 4;
static const int kBadgeViewTag                      = 5;

static const CGFloat kBadgeTextPadding              = 20.0;
static const CGFloat kBadgeTextFontSize             = 12.0;
static const CGFloat kBadgeHeight                   = 22.0;
static const CGFloat kBadgeY                        = 10.0;
static const CGFloat kBadgeX                        = 280.0;
static const CGFloat kBadgeXWidthAdjustment         = 30.0;

static const CGFloat kCellIconRectX                 = 10.0;
static const CGFloat kCellIconRectY                 = 7.0;
static const CGFloat kCellIconRectWidth             = 30.0;
static const CGFloat kCellIconRectHeight            = 30.0;
static const CGFloat kCellPrimaryElementX           = 7.0;
static const CGFloat kCellPrimaryElementY           = 7.0;
static const CGFloat kCellPrimaryElementyWidth      = 294.0;
static const CGFloat kCellPrimaryElementHeight      = 30.0;
static const CGFloat kCellSecondaryElementX         = 115.0;
static const CGFloat kCellSecondaryElementY         = 7.0;
static const CGFloat kCellSecondaryElementWidth     = 191.0;
static const CGFloat kCellSecondaryElementHeight    = 30.0;

typedef enum {
	MKTableCellTypeNone,
	MKTableCellTypeDescription,
	MKTableCellTypeLabel,
	MKTableCellTypeScore,
	MKTableCellTypeAction,
} MKTableCellType;

typedef enum {
	MKTableCellAccessoryNone,
    MKTableCellAccessoryActivity,
	MKTableCellAccessoryInfoButton,
	MKTableCellAccessoryWarningIcon,
} MKTableCellAccessoryViewType;

typedef enum {
    MKTableCellAccentTypePrimaryView,
    MKTableCellAccentTypeFull,
} MKTableCellAccentType;

typedef struct {
    CGColorRef color;
    CFStringRef text;
} MKTableCellBadge;

typedef struct {
    MKTableCellAccentType type;
    MKTableCellPosition position;
    CGColorRef tint;
} MKTableCellAccent;

MKTableCellBadge MKTableCellBadgeMake(CGColorRef color, CFStringRef text);
MKTableCellAccent MKTableCellAccentMake(MKTableCellAccentType type, MKTableCellPosition position, CGColorRef tint);

@protocol MKTableCellDelegate;
@protocol MKInputValidation;

@class MKBadgeCellView, MKView, MKSwipeCellView;

/**-------------------------------------------------------------------------------------
 An MKTableCell is a subclass UITableViewCell. MKTableCell is designed as a superClass for 
 several customized sublcasses. The MKTableCell itself creates a few basic Table Cells:
 
 * `MKTableCellTypeNone` : A blank table cell this to be used when implementing on the subclasses.
 * `MKTableCellTypeDescription` : A table cell that has two labels side by side.
 * `MKTableCellTypeLabel` : A cell with label centered on it.
 * `MKTableCellTypeScore` : A cell with a 30x30 image view and two labels side by side.
 * `MKTableCellTypeAction` : A cell with a 30x30 image view, one label, and a discloser arrow.
 
 When a MKTableCell is created it intializes an UITableViewCell with a style of UITableViewCellStyleDefault. 
 It than removes the elements of that cell and replaces them its own. If you use the UTableCellView 
 intializer instead, be sure to set the style UITableViewCellStyleDefault to keep unneeded subviews from being 
 part of the cell.
 
 MKTableCell objects have some addtional accessoy types built in:
 
 * `MKTableCellAccessoryNone` : No accessory.
 * `MKTableCellAccessoryActivity` : Displays an activity indicator as the cells accessory.
 * `MKTableCellAccessoryInfoButton` : Displays an info button as the cells accessory.
 * `MKTableCellAccessoryWarningIcon` : Dispalays a warning icon as the cell accessory. 
 
 The MKTableCellDelegate Protocol is adopted by MKTableCell.
----------------------------------------------------------------------------------------*/

@interface MKTableCell : UITableViewCell {
	id delegate;
    id validator;
    NSString *mKey;
    
	MKTableCellType type;
	MKTableCellAccessoryViewType accessoryViewType;
	
    MKValidationType mValidationType;
    NSInteger mValidatorTestStringLength;
	BOOL mValidating;
    
	UILabel *mTheLabel;
	UILabel *mSmallLabel;
    
    MKView *mCellView;

@private
    UISwipeGestureRecognizer *mRightToLeftSwipe;
    UISwipeGestureRecognizer *mLeftToRightSwipe;
    UILongPressGestureRecognizer *mLongPress;
}

///---------------------------------------------------------------------------------------
/// @name Initalizing
///---------------------------------------------------------------------------------------

/** Returns an intalized MKTableCell. 
 
 @warning *Note* If you are using one of the MKTableCell subclasses or subclassing pass MKTableCellTypeNone
 for the cellType parameter.
 
 @param cellType The type of the cell to create. 
 
 @param resuseIdentifier The rueseIdentifier for this type of cell.
 
 @return MKTableCell instance
*/
- (id)initWithType:(MKTableCellType)cellType reuseIdentifier:(NSString *)reuseIdentifier;

///---------------------------------------------------------------------------------------
/// @name Cell Types
///---------------------------------------------------------------------------------------

/** A reference the MKTableCellType set with the initalizer. */
@property (assign) MKTableCellType type;

///---------------------------------------------------------------------------------------
/// @name Accessories
///---------------------------------------------------------------------------------------

/** Sets MKTableCellAccessoryType for the cell. */
@property (nonatomic, assign) MKTableCellAccessoryViewType accessoryViewType;

/** Sets an image as the cells accessory */
@property (nonatomic, retain) UIImage *accessoryIcon;

///---------------------------------------------------------------------------------------
/// @name Referencing
///---------------------------------------------------------------------------------------

/** A unique NSString that identifies the cell. This is used in most MKTableCellDelegate methods. */
@property (nonatomic, assign) NSString *key;

/** The NSIndexPath of the cell. Property must be set to return a value. */
@property (nonatomic, assign) NSIndexPath *indexPath;

///---------------------------------------------------------------------------------------
/// @name Cell Elements
///---------------------------------------------------------------------------------------

//** A refercnce to the view that holds the cell elements */
@property (nonatomic, retain) MKView *cellView;

/** A reference to the primary label of all MKTableCell Subclass that have at least on label. */
@property (nonatomic, retain) UILabel *theLabel;

/** A reference to the secondary label of all MKTableCell Subclasses that have two labels. */
@property (nonatomic, retain) UILabel *smallLabel;

/** The image displayed on cell that suport image views */
@property (nonatomic, retain) UIImage *icon;

/** An imaged to be masked. The masking is completed by the MKMaskIconView */
@property (nonatomic, retain) UIImage *iconMask;

/** A bagde that is displayed on the left hand side of the cell. A badge can
 be created by using the `MKTableCellBadgeMake(CGColorRef color, CFStringRef text)`
 function
*/
@property (nonatomic, assign) MKTableCellBadge badge;

/**
 Adds a badge to the cell.
 
 @param text the text to display on the badge.
 
 @param color the color of the badge.
 
 @param rect the rect of the badge.
*/
- (void)addBadgeWithText:(NSString *)text color:(UIColor *)color rect:(CGRect)rect;

///---------------------------------------------------------------------------------------
/// @name Apearances
///---------------------------------------------------------------------------------------

/** Sets an accent for the cell. Use the 
 `MKTableCellAccentMake(MKTableCellAccentType type, MKTableCellPosition position, CGColorRef tint)`
 function to create an MKTableCell Accent.
*/
@property (nonatomic, assign) MKTableCellAccent accent;

/**
 Accents the primary view of the cell by drawing a background gradient onto it.
 
 @param position the postion of the table cell `MKTableCellPositionTop, MKTableCellPositionMiddle,
 MKTableCellPositionBottom`, or `MKTableCellPositionSingleCell`. If you are using a plain table 
 view style pass `MKTableCellMiddle` for all cells.
*/
- (void)accentPrimaryViewForCellAtPosition:(MKTableCellPosition)position;

/**
 Accents the primary view of the cell by drawing a background gradient onto it, and trims
 the views width by the given amount.
 
 @param position the postion of the table cell `MKTableCellPositionTop, MKTableCellPositionMiddle,
 MKTableCellPositionBottom`, or `MKTableCellPositionSingleCell`. If you are using a plain table 
 view style pass `MKTableCellMiddle` for all cells.
 
 @param trim how much to trim off the width of the the accent view.
 */
- (void)accentPrimaryViewForCellAtPosition:(MKTableCellPosition)position trim:(CGFloat)trim;

/** The ammount to trim a accent view by */
@property (nonatomic, assign) CGFloat primaryViewTrim;

///---------------------------------------------------------------------------------------
/// @name Input Validation
///---------------------------------------------------------------------------------------

/** Sets the validation type to preform. 
 
 @see validatior
 
 @see MKInputValidation 
*/
@property (nonatomic, assign) MKValidationType validationType;

/** the lenght to compare to if using MKValidateIsaSetLenght */
@property (nonatomic, assign) NSInteger validatorTestStringLength;

/** YES is the cell validates user input, NO if it does not.*/
@property (nonatomic, assign, readonly) BOOL validating;

///--------------------------------------------------------------------------------------
/// @name Validation Methods
///--------------------------------------------------------------------------------------

/** Tells the validator to valiate the input using the specified type. If you set a validationType
 other than `MKValidationNone` you will not need to call this method directly.
 
 @warning *Note* The default implentation of this method does nothing. Subclasses need to overide
 it to run a validation.
 
 @see MKInputValidation
*/
- (void)validateWithType:(MKValidationType)aType;

///---------------------------------------------------------------------------------------
/// @name Gesture Recognition
///---------------------------------------------------------------------------------------

/** Set YES to allow the cell to recognize left to right swipes */
@property (nonatomic, assign) BOOL recognizeLeftToRightSwipe;

/** Set YES to allow the cell to recgnize right to left swipes */
@property (nonatomic, assign) BOOL recognizeRightToLeftSwipe;

/** Set Yes to allow the cell to recognize long presses */
@property (nonatomic, assign) BOOL recognizeLongPress;

///---------------------------------------------------------------------------------------
/// @name Adopted Protocols
///---------------------------------------------------------------------------------------

/** The MKTableCellDelegate 
 
 @see MKTableCellDelegate
*/
@property (assign) id<MKTableCellDelegate> delegate;

/** The MKInputValidator. This is automatically assigned when a validationType is set. 
 
 @warning *Note* If you want to use one of your own objects as the validator set the validation type to
 `MKValidationNone` and assign your own object to this property. The object you assign must adopt the
 MKInputValidation protocol.
 
 @see MKInputValidation
 
 @see validationType
*/
@property (assign) id<MKInputValidation> validator;

@end

/**--------------------------------------------------------------------------
 This catagory of MKControl provides the control for table cell accessories.
---------------------------------------------------------------------------*/

@interface MKControl (MKTableCell)

/**
 Retuns an istance for the specified type.
 
 @param type the type of accessory to create
 
 @return MKControl instance
*/
- (id)initWithType:(MKTableCellAccessoryViewType)type;

/**
 Returns an instance that displays the specified image.
 
 @param image the image to display as the cells accessory
 
 @return MKControl instance
*/
- (id)initWithImage:(UIImage *)image;

@end

/**--------------------------------------------------------------------------
 This catagory of MKView provides a standard layout for MKTableCell objects.
---------------------------------------------------------------------------*/

@interface MKView (MKTableCell)
    
///-----------------------------------
/// @name Creating
///-----------------------------------

/**
 Creates an instace of MKView for the given table cell.
 
 @param cell the cell the view will be placed on.
 
 @return MKView instance
*/
- (id)initWithCell:(MKTableCell *)cell;

///-----------------------------------
/// @name Layout Control
///-----------------------------------

/**
 Adjusts the elements of the cell to fit.
*/
- (void)layoutCell;

/** Yes if the secondary element should not atomically adjust its size. */
@property (nonatomic, assign) BOOL pinnedSecondaryElement;

///-----------------------------------
/// @name Adding Elements
///-----------------------------------

/**
 Adds a Primary Element to the cell. The primary element 
 appears on the left side of the cell.
 
 @param element the view that will be added to the cell.
*/
- (void)addPrimaryElement:(UIView *)element;

/**
 Adds a Secondary Element to the cell. The secondary element 
 appears on the right side of the cell.
 
 @param element the view that will be added to the cell.
 */
- (void)addSecondaryElement:(UIView *)element;

/**
 Adds a secondary element to the cell is that fills the desired rect.
 
 @param element the view to add to the cell.
 
 @param rect the rect of the view.
*/ 
- (void)addSecondaryElement:(UIView *)element inRect:(CGRect)rect;

/**
 Adds a Icon Element to the cell. The icon element 
 appears on the left side of the cell.
 
 @param element the view that will be added to the cell.
 */
- (void)addIconElement:(UIView *)element;

@end

/**----------------------------------------------------------------------------
 This catagory of MKPopOutView provides methods for displaying a pop out view from
 a MKTableCell.
-----------------------------------------------------------------------------*/

@interface MKPopOutView (MKTableCell)

///------------------------------------------------------
/// @name Identifing
///------------------------------------------------------

/** The index path of the cell showing the pop out view */
@property (nonatomic, retain, readonly) NSIndexPath *aIndexPath;

///-------------------------------------------------------
/// @name Displaying
///-------------------------------------------------------

/**
 Shows the view on the screen.
 
 @param cell the cell to display the view from
 
 @param tableView the table view to disaply on
 */
- (void)showFromCell:(MKTableCell *)cell onView:(UITableView *)tableView;

///-------------------------------------------------------
/// @name Elements
///-------------------------------------------------------

/**
 Adds a MKButtonTypeDisloserButton on the right side of the popout view
 
 @param taget the object that handles actions from the button
 
 @param selector the selector to preform when the button is tapped. The 
 expected format of the selector is `-(void)mySelector:(NSIndexPath *)indexPath`.
 */
- (void)setDisclosureButtonWithTarget:(id)target selector:(SEL)selector;

@end

