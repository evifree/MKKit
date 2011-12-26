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
 
 Using a graphics dictionary works off of a singleton instance of MKGraphicStructures.
 To set the sigleton call the sharedGraphicsWithFile: method and give the path to
 your graphics dictionary property list. 
 
 @warning *Note* The MKGraphicsSigleton instance is designed specifically for use
 with graphics dictionary property list. An exception will be thrown if there is
 an attempt to access the sigleton instance before plist file has been designated.
 
 After a plist file has been assigned you can create instances by calling the
 graphicsWithName: method. Or by calling the MKGraphicsFactory method initWithGraphicsName:
 for classes that conform to the MKGraphicsFactory protocol.
 
 Check the documentation of the class you are using to see MKGraphicsSturctures and/or 
 MKGraphicsFactory is supported, and what graphic properties are expected for the class.
 
 The Following Classes currently support the use of a graphics dictionary:
 
 * MKImage
 * MKView
 
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
/// @name Singleton
///-----------------------------------------

/**
 Returns the single instance of MKGraphicsStructures
 
 @warning *Note* A dictionary must be set to create a sigleton instance
 call sharedGraphicsWithFile: to set the dictionary.
 
 @exception MKGraphicsNoSharedInstanceDictionaryException Thrown if this
 method is called and no dictionary has been set.
 
 @return singlton
*/
+ (id)sharedGraphics;

/**
 Creates the singleton instance of MKGraphicsStructure and set the 
 dictionary contantained in the property list at the given path.
 
 @return singleton
*/
+ (id)sharedGraphicsWithFile:(NSString *)path;

/**
 Releases the singleton instance.
*/
+ (void)removeSharedGraphics;

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
/// @name Aceessing Graphics
///-----------------------------------------

/** 
 The graphics dictionary that will be used for your app. Set this property using
 the sharedGraphicsWithFile: method.
*/
@property (nonatomic, readonly) NSDictionary *graphicsDictionary;

///------------------------------------------
/// @name Assigning Structures
///------------------------------------------

/**
 Assigns colors for a linear gradient
 
 @param topColor the color on the top of the gradient.
 
 @param bottomColor the color on the bottom of the gradient.
*/
- (void)assignGradientTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor;

/** the top color of the gradient */
@property (nonatomic, retain) UIColor *top;

/** the bottom color of the gradient */
@property (nonatomic, retain) UIColor *bottom;

/** the fill color of an UI object. */
@property (nonatomic, retain) UIColor *fill;

/** `YES` if a liner shine should be used on view drawing. */
@property (nonatomic, assign) BOOL useLinerShine;

@end 

// Exceptions
NSString *MKGraphicsNoSharedInstanceDictionaryException MK_VISIBLE_ATTRIBUTE;

// KVC and Shared Graphics Dictionary Keys
NSString *MKGraphicsTopColor MK_VISIBLE_ATTRIBUTE;
NSString *MKGraphicsBottomColor MK_VISIBLE_ATTRIBUTE;
NSString *MKGraphicsFillColor MK_VISIBLE_ATTRIBUTE;
NSString *MKGraphicsUseLinerShine MK_VISIBLE_ATTRIBUTE;

NSString *MKGraphicsColorHSBA MK_VISIBLE_ATTRIBUTE;
NSString *MKGraphicsColorRGBA MK_VISIBLE_ATTRIBUTE;