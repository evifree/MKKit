//
//  MKTableCell.h
//  MKKit
//
//  Created by Matthew King on 3/19/10.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#import <MKKit/MKKit/MKControls/MKContolHeaders.h>
#import <MKKit/MKKit/MKErrorContol/MKInputValidation.h>
#import <MKKit/MKKit/MKErrorContol/MKValidator.h>

#import <MKKit/MKKit/MKDeffinitions.h>
#import <MKKit/MKKit/MKMacros.h>
#import <MKKit/MKKit/MKStrings.h>

#import "MKTableElements/MKElementAccentView.h"

#import "MKTableCellDelegate.h"

typedef enum {
	MKTableCellTypeNone,
	MKTableCellTypeDescription,
	MKTableCellTypeLabel,
} MKTableCellType;

typedef enum {
	MKTableCellAccessoryNone        = 0,
    MKTableCellAccessoryActivity    = 1,
    MKTableCellAccessoryAdd         = 2,
	MKTableCellAccessoryInfoButton  = 3,
    MKTableCellAccessorySubtract    = 4,
	MKTableCellAccessoryWarningIcon = 5,
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

@class MKBadgeCellView, MKView, MKSwipeCellView, MKTableCellAccentView;

/**-------------------------------------------------------------------------------------
 *Overview*
 
 An MKTableCell is a subclass UITableViewCell. MKTableCell is designed as a superClass for 
 several customized sublcasses. The MKTableCell itself creates a few basic Table Cells:
 
 * `MKTableCellTypeNone` : A blank table cell this to be used when implementing on the subclasses.
 * `MKTableCellTypeDescription` : A table cell that has two labels side by side.
 * `MKTableCellTypeLabel` : A cell with label centered on it.
  
 When a MKTableCell is created it intializes an UITableViewCell with a style of UITableViewCellStyleDefault. 
 It than removes the elements of that cell and replaces them its own. If you use the UTableCellView 
 intializer instead, be sure to set the style UITableViewCellStyleDefault to keep unneeded subviews from being 
 part of the cell.
 
 *Cell Accessories*
 
 MKTableCell objects have some addtional accessoy types built in:
 
 * `MKTableCellAccessoryNone` : No accessory.
 * `MKTableCellAccessoryActivity` : Displays an activity indicator as the cells accessory.
 * `MKTableCellAccessoryAdd` : Displays a round green button with a plus sign as the cells accessory.
 * `MKTableCellAccessoryInfoButton` : Displays an info button as the cells accessory.
 * `MKTableCellAccessorySubtract` : Displays an round red button with a minus sign as the cells accessory.
 * `MKTableCellAccessoryWarningIcon` : Dispalays a warning icon as the cell accessory. 
 
 Cell accessories are a subclass of MKControl, or UIControl. Responces to acctions from
 accessories are built in. Ues the didTapAccessoryForKey:indexPath: delegate method to observe
 actions from the accessory. 
 
 @warning *Note* If the indexPath property is not set the delegate will pass 'nil' as the 
 indexPath parameter.
 
 *Validating User Input*
 
 MKTableCell works with MKValidator to validate user input. To validate input of a form, set
 the `validationType` property of each cell that will be validated. You can then use the table
 validation methods of MKValidator to validate the cells. If you wish to use your own validation
 methods, set a class to the `validator` property of MKTableCell. The class you use must conform
 to the MKInputValidation Protocol. See MKValidator and MKInputValidation for more information.
 
 *Cell Delegate*
 
 The MKTableCellDelegate Protocol is adopted by MKTableCell.
 
 @see MKTableCellDelegate
 
 *Required Classes*
 
 * MKControl
 * MKDeffinitions
 * MKElementAccentView
 * MKMacros
 * MKStrings
 * MKSwipeCellView
 * MKTableCellAccentView
 * MKTableCellBadgeView
 * MKView
 
 *Required Libraries*
 
 * libobjc
 
 *Required Frameworks*
 
 * Foundation
 * UIKit
----------------------------------------------------------------------------------------*/

@interface MKTableCell : UITableViewCell {
	id delegate;
    id validator;
    NSString *mKey;
    
	MKTableCellType type;
	
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

/** 
 Returns an intalized MKTableCell. 
 
 @warning *Note* If you are using one of the MKTableCell subclasses or subclassing pass MKTableCellTypeNone,
 or a type designated for that subclass, for the cellType parameter.
 
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

/** 
 Sets MKTableCellAccessoryType for the cell. There are several prebuilt accessory types
 to chose from or you can use your own by setting the accessoryIcon property.
*/
@property (nonatomic, assign) MKTableCellAccessoryViewType accessoryViewType;

/** 
 Sets an image as the cells accessory. If you want to use on the prebuilt accessory types
 set the accessoryViewType property.
*/
@property (nonatomic, retain) UIImage *accessoryIcon;

///---------------------------------------------------------------------------------------
/// @name Referencing
///---------------------------------------------------------------------------------------

/** 
 A unique NSString that identifies the cell. This is used in MKTableCellDelegate methods to 
 help with easy NSMutableDictionary use.
*/
@property (nonatomic, assign) NSString *key;

/** 
 The NSIndexPath of the cell. Property must be set to return a value. 
 
 @warning *Required for delegate methods that return have an NSIndexPath parameter.*
*/
@property (nonatomic, retain) NSIndexPath *indexPath;

///---------------------------------------------------------------------------------------
/// @name Elements
///---------------------------------------------------------------------------------------

//** A refercnce to the view that holds the cell elements */
@property (nonatomic, retain) MKView *cellView;

/** A reference to the primary label of all MKTableCell Subclass that have at least on label. */
@property (nonatomic, retain) UILabel *theLabel;

/** A reference to the secondary label of all MKTableCell Subclasses that have two labels. */
@property (nonatomic, retain) UILabel *smallLabel;

/** The image displayed on cell that suport image views */
@property (nonatomic, retain) UIImage *icon;

/** 
 An imaged to be masked. The masking is completed by the MKView (IconView) catagory. The
 default gradient for the mask is a dark gray top moving to a lighter bottom.
 
 The masks gradient can be set by accessing the icon of the cell.
 
    [(MKView *)cell.cellview viewForTag:kIconViewTag].gradient = someGradient;
 
 @see MKView
 @see MKGraphicStructures
 */
@property (nonatomic, retain) UIImage *iconMask;

/** 
 A bagde that is displayed on the left hand side of the cell. A badge can
 be created by using the `MKTableCellBadgeMake(CGColorRef color, CFStringRef text)`
 function
*/
@property (nonatomic, assign) MKTableCellBadge badge;

/**
 Adds a badge to the cell in the given rect.
 
 @param text the text to display on the badge.
 
 @param color the color of the badge.
 
 @param rect the rect of the badge.
*/
- (void)addBadgeWithText:(NSString *)text color:(UIColor *)color rect:(CGRect)rect;

///---------------------------------------------------------------------------------------
/// @name Apearances
///---------------------------------------------------------------------------------------

/** 
 Sets an accent for the cell. Use the 
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
 
 @param trim the width to trim the accent view down to.
 */
- (void)accentPrimaryViewForCellAtPosition:(MKTableCellPosition)position trim:(CGFloat)trim;

/** The width of the accent view. */
@property (nonatomic, assign) CGFloat primaryViewTrim;

///---------------------------------------------------------------------------------------
/// @name Input Validation
///---------------------------------------------------------------------------------------

/** 
 Sets the validation type to preform. `MKValidator` will look for this property when
 using the table view validation methods. Setting this property will automatically set
 the `MKValidator` singlton as the cells `validator`. If you want to use your own validator,
 you need to set the `validatior` property.
 
 @see validatior
 
 @see MKValidator 
*/
@property (nonatomic, assign) MKValidationType validationType;

/** the lenght to compare to if using MKValidateIsaSetLenght */
@property (nonatomic, assign) NSInteger validatorTestStringLength;

/** `YES` is the cell validates user input, `NO` if it does not. Default is `NO`.*/
@property (nonatomic, assign, readonly) BOOL validating;

///--------------------------------------------------------------------------------------
/// @name Validation Methods
///--------------------------------------------------------------------------------------

/** 
 @warning *This method has been deprecated. Use `validtedWithType:` instead.*
*/
- (void)validateWithType:(MKValidationType)aType MK_DEPRECATED_0_8;

/** 
 Tells the validator to valiate the input using the specified type. If you set a `validationType`
 other than `MKValidationNone` you will not need to call this method directly. 
 
 @return `YES` if validation passes, `NO` if not.
 
 @warning *Note* The default implentation of this method does nothing. Subclasses need to overide
 it to run a validation.
 
 @see MKInputValidation
*/
- (BOOL)validatedWithType:(MKValidationType)aType;

///---------------------------------------------------------------------------------------
/// @name Gesture Recognition
///---------------------------------------------------------------------------------------

/** Set `YES` to allow the cell to recognize left to right swipes. Default is `NO`. */
@property (nonatomic, assign) BOOL recognizeLeftToRightSwipe;

/** Set `YES` to allow the cell to recgnize right to left swipes. Default is `NO`. */
@property (nonatomic, assign) BOOL recognizeRightToLeftSwipe;

/** Set `YES` to allow the cell to recognize long presses. Default is `NO`. */
@property (nonatomic, assign) BOOL recognizeLongPress;

///---------------------------------------------------------------------------------------
/// @name Adopted Protocols
///---------------------------------------------------------------------------------------

/** The MKTableCellDelegate 
 
 @see MKTableCellDelegate
*/
@property (assign) id<MKTableCellDelegate> delegate;

/** 
 The `MKInputValidation`. This is automatically assigned when a `validationType` is set. 
 
 @warning *Note* If you want to use one of your own objects as the validator set the validation type to
 `MKValidationNone` and assign your own object to this property. The object you assign must adopt the
 MKInputValidation protocol.
 
 @see MKInputValidation
 
 @see validationType
*/
@property (assign) id<MKInputValidation> validator;

@end

//MKTableCellAccessoryViewType mType MK_VISIBLE_ATTRIBUTE;

/**--------------------------------------------------------------------------
 This catagory of MKControl provides the control for table cell accessories.
---------------------------------------------------------------------------*/
@interface MKControl (MKTableCell)

///------------------------------------------
/// @name Creating
///------------------------------------------

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

///----------------------------------------
/// @name Type
///----------------------------------------

/** Reference to the MKTableCellAccessoryViewType */
@property (nonatomic, assign) id viewType;

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

/**
 Yes if the primary element should not atomically adjust its size. 
 Default is `NO`.
*/
@property (nonatomic, assign) BOOL pinnedPrimaryElement;

/** 
 Yes if the secondary element should not atomically adjust its size. 
 Default is `NO`.
*/
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
 Adds a Primary Element to the cell that is placed in the given
 rect. Using this method will set the pinnedPrimaryElement 
 property to `YES`.
 
 @param element the view to add to the cell
 
 @param rect the rect of the view
*/
- (void)addPrimaryElement:(UIView *)element inRect:(CGRect)rect;

/**
 Adds a Secondary Element to the cell. The secondary element 
 appears on the right side of the cell.
 
 @param element the view that will be added to the cell.
 */
- (void)addSecondaryElement:(UIView *)element;

/**
 Adds a secondary element to the cell is that fills the desired rect.
 Using this method will set the pinnedSecondary element Property to 
 `YES`.
 
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

/**
 Adds a view under the primary and seconday views. The primay and secondary
 views adjust to fit the new element. If the cell has an icon view assigned, 
 the detail element is moved to right to fit the icon.
 
 @param element the view that will be added to the cell.
*/
- (void)addDetailElement:(UIView *)element;

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

static const int kPrimaryViewTag                    = 1;
static const int kSecondaryViewTag                  = 2;
static const int kIconViewTag                       = 3;
static const int kAccentViewTag                     = 4;
static const int kBadgeViewTag                      = 5;
static const int kDetailViewTag                     = 6;
static const int kSwipeViewTag                      = 7;

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
static const CGFloat kCellDetailElementX            = 7.0;
static const CGFloat kCellDetailElementY            = 29.0;
static const CGFloat kCellDetailElementWidth        = 294.0;
static const CGFloat kCellDetailElementHeight       = 12.0;
