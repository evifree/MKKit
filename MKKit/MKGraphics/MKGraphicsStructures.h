//
//  MKGraphicsStructures.h
//  MKKit
//
//  Created by Matthew King on 9/18/11.
//  Copyright (c) 2010-2011 Matt King. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#import <MKKit/MKKit/MKObject.h>
#import <MKKit/MKKit/MKObject+Internal.h>

#import "MKGraphicFactory.h"
#import "UIColor+MKGraphics.h"

/**--------------------------------------------------------------------------
 *Overview*
 
 MKGraphicsStructures stores graphic elements to help with uniformity across
 an application.
 
 *Usage*
 
 MKKit class that use the MKGraphicsStructures class will refereance an instance
 when preforming drawing operations. 
 
 *Using a Graphic Dictionary*
 
 MKGraphicsStructure has support the loading of grapics information from a plits
 file. For example if you want to use the same background drawing for a set of 
 views, you define a color patern in a property list an MKGraphicsStructure will 
 will convert it to an instance for your view to use.
 
 To use a graphics dictionary you need to register a property list file. This only
 needs to be done once. You can register a propert list by calling resgisterGraphicsFile:
 method. Pass on the path to you property list.
 
 After a plist file has been registered you can create instances by calling the
 graphicsWithName: method. Or by calling the MKGraphicsFactory method initWithGraphicsName:
 for classes that conform to the MKGraphicsFactory protocol.
 
 Check the documentation of the class you are using to see MKGraphicsSturctures and/or 
 MKGraphicsFactory is supported, and what graphic properties are expected for the class.
 
 @warning *Note* the initWithGraphicsName: method is primarlly used by super classes. Check
 the documentation of classes you are using for creation methods that suport the use of
 MKGraphicStrutures.
 
 The Following Classes currently support the use of a graphics dictionary:
 
 * MKBarButtonItem
 * MKImage
 * MKView
 
 *Creating a Graphics Dictionary*
 
 An graphics dictionary is created with a property list file. The property list 
 needs have an NSDictionary object as the main level. From there it should contain
 a NSDictionary object for each graphic structure you want to use in your app. The 
 keys for these dictionary(s) are up to you.
 
 For example if you wanted a graphics structure for icons displayed on your navigation
 bar the key may be MyNavIcon. This dictionary should contain a series of NSString and 
 NSDictionary objects that corrispond the apropreate vaules and keys. The following is 
 list of expected keys and values:
 
 Colors
 
 * key : `MKGraphicsFillColor` value : `NSDictionary`
 * key : `MKGraphicsTopColor` value : `NSDictionary`
 * key : `MKGrpahicsBottomColor` value : `NSDictionary`
 * key : `MKGraphicsBorderColor` value : `NSDictionary`
 * key : `MKGraphicsDisabledColor` value : `NSDictionary`
 * key : `MKGraphicsTouchedColor` value : `NSDictionary`
 
 All color dictionaries should have the following structure:
 
 * MKGraphicsFillColor, MKGraphicsTopColor, or MKGraphicsBottomColor Dictionary key : `MKGraphicsColorHSBA` or 
 `MKGrapicsColorRGBA` value : `NSDictionary`
 * MKGraphicsColorHSBA keys : `h, s, b, a` : value `NSString` to represent the hue, saturation, brightness, and
 alpha values of a color, given in raw values.
 * MKGraphicsColorRGBA keys : `r, g, b, a` : value `NSString` to respresent the red, green, blue, and alpha
 values of a color, given in raw values.
 
 @warning *Note* If a fill color used a top color and bottom color does not need to be used and vise
 versa.

 Bools
 
 * key : `MKGraphicsUseLinerShine` value : `NSString` *YES* to use a shine *NO* (or omit) to not.
 * key : `MKGraphicsBordered` value : `NSString` *YES* to draw a border *NO* (or omit) to not. *This key does not
 need to be assigned in your graphics dictionary, assigning a border color will automatically set the value of 
 this key to YES*.
 
 Floats
 
 * key : `MKGraphicsBorderWidth` value : `NSString` the string representaion of a float value default is *2.0*.
 
 @warning An example of an graphic dictonary property list is available from the downloads section of the 
 MKKit github project.
 
 *Required Classes*
 
 * MKObject
 
 *Required Frameworks*
 
 * Foundation
 * UIKit
 * Core Graphics
--------------------------------------------------------------------------*/

@interface MKGraphicsStructures : MKObject {
@private
    NSDictionary *mGraphicsDictionary;
}

///-----------------------------------------
/// @name Creating
///-----------------------------------------

/**
 Creates an autoreleasing empty instance.
 
 return MKGraphicsStructure instance
*/
+ (id)graphicsStructure;

/**
 Creates and autoreleaseing instance of MKGraphicsStructures from the give
 name. The name should corispond with on of the keys from you graphics dictionary.
 
 @return MKGraphicsStructure instance.
*/
+ (id)graphicsWithName:(NSString *)name;

/**
 An instance of MKGraphisStructures that sets the colors for a linear gradient.
 
 @param topColor the color on the top of the gradient.
 
 @param bottomColor the color on the bottom of the gradient.
 
 @return MKGraphicsStructure instance
*/
+ (id)linearGradientWithTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor;

///-----------------------------------------
/// @name Graphics Dictonary
///-----------------------------------------

/**
 Registers a property list file that used to build MKGraphicsStructures instances for
 use in your app.
 
 After a file is registered you can use graphicsWithName: method to retrive the 
 instance for the specified graphic.
*/
+ (void)registerGraphicsFile:(NSString *)path;

///-----------------------------------------
/// @name Aceessing Graphics
///-----------------------------------------

/** 
 The graphics dictionary that will be used for your app. Set this property using
 the sharedGraphicsWithFile: method.
*/
//@property (nonatomic, readonly) NSDictionary *graphicsDictionary;

///------------------------------------------
/// @name Assigning Structures
///------------------------------------------

/**
 Assigns colors for a linear gradient
 
 @param topColor the color on the top of the gradient.
 
 @param bottomColor the color on the bottom of the gradient.
*/
- (void)assignGradientTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor;

///-------------------------------------------
/// @name Coloring
///-------------------------------------------

/** the top color of the gradient */
@property (nonatomic, retain) UIColor *top;

/** the bottom color of the gradient */
@property (nonatomic, retain) UIColor *bottom;

/** the fill color of an UI object. */
@property (nonatomic, retain) UIColor *fill;

///-------------------------------------------
/// @name Contol Colors
///-------------------------------------------

/** the border color for an object */
@property (nonatomic, retain) UIColor *border;

/** the color of a disabled object */
@property (nonatomic, retain) UIColor *disabled;

/** the color of a touched object */
@property (nonatomic, retain) UIColor *touched;

///--------------------------------------------
/// @name Styling
///--------------------------------------------

/** `YES` if a liner shine should be used on view drawing. */
@property (nonatomic, assign) BOOL useLinerShine;

/** `YES` if an object should have a border drawn for it. */
@property (nonatomic, assign) BOOL bordered;

/** The width of a border if any. Default is `2.0`. */
@property (nonatomic, assign) float borderWidth;

@end 

// KVC and Shared Graphics Dictionary Keys
NSString *MKGraphicsTopColor MK_VISIBLE_ATTRIBUTE;
NSString *MKGraphicsBottomColor MK_VISIBLE_ATTRIBUTE;
NSString *MKGraphicsFillColor MK_VISIBLE_ATTRIBUTE;
NSString *MKGraphicsBorderColor MK_VISIBLE_ATTRIBUTE;
NSString *MKGraphicsDisabledColor MK_VISIBLE_ATTRIBUTE;
NSString *MKGraphicsTouchedColor MK_VISIBLE_ATTRIBUTE;
NSString *MKGraphicsUseLinerShine MK_VISIBLE_ATTRIBUTE;
NSString *MKGraphicsBordered MK_VISIBLE_ATTRIBUTE;
NSString *MKGraphicsBorderWidth MK_VISIBLE_ATTRIBUTE;

NSString *MKGraphicsColorHSBA MK_VISIBLE_ATTRIBUTE;
NSString *MKGraphicsColorRGBA MK_VISIBLE_ATTRIBUTE;

/// User Default Keys
NSString *MKGraphicsPropertyListName MK_VISIBLE_ATTRIBUTE;