//
//  UIColor+MKGraphics.h
//  MKKit
//
//  Created by Matthew King on 12/26/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKMacros.h>

/**------------------------------------------------------------
 *Overview*
 
 Adds methods to UIColor for use with MKGraphicsStrutures and
 MKGraphicsFactory.
-------------------------------------------------------------*/
@interface UIColor (MKGraphics)

///------------------------------
/// @name Creating Instances
///------------------------------

/**
 Creates a UIColor instance from the given dictionary. Expected
 keys are `h, s, b, a` for hue, shine, brightness, and alpha.
 
 The values should be the raw value for the color. The will be
 converted to match the expetations of UIColor.
*/
+ (UIColor *)colorWithHSBADictionary:(NSDictionary *)dictionary;

/**
 Creates a UIColor instance from the given dictionary. Expected
 keys are `r, g, b, a` for red, green, blue, and alpha.
 
 The values should be the raw value for the color. The will be
 converted to match the expetations of UIColor.
 */
+ (UIColor *)colorWithRGBADictionary:(NSDictionary *)dictionary;

@end
