//
//  MKImage.h
//  MKKit
//
//  Created by Matthew King on 12/3/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKGraphics/MKGraphics.h>

/**-----------------------------------------------------------------------
 *Overview*
 
 MKImage is a subclass of UIImage that addes the abillity to create masks
 of images and color them the desired color.
 
 MKImage does support HiRes images.
 
 *Drawing Support*
 
 MKImage intances are supported by MKGraphicsStrutures. GraphicStrutures can
 be passes to images during their creation. Since MKImages are non-mutable 
 objcets, the class does not conform to the MKGraphicsFactory protocol. You
 can still set image grapics in you Graphic Dictonary and access them by
 calling the graphicsWithName: class method of MKGraphicsStructures. MKImage
 looks for the following graphic properties:
 
 * `fill` : If a fill is set, the image will colored in with the fill color.
 If fill is nil, MKImage will look for top and bottom properties to create 
 a gradient fill.
 * `top` : the top half of the images color.
 * `bottom` : the bottom half of the images color.
 * `useLinerShine` : `YES` if an image should be given a liner shine.
 
 *Required Frameworks*
 
 * UIKit
 * Foundation
 * Core Graphics
 
 *Required Classes* 
 
 * MKGraphics
 * MKGraphicsStructures
------------------------------------------------------------------------*/

@interface MKImage : UIImage {
    
}

///------------------------------------------
/// @name Creating
///------------------------------------------

/**
 Creates an Instace of MKImage.
 
 @param imageName the name of the image you want to mask
 
 @param color the color to make the image
 
 @return MKImage instance
*/
+ (id)imagedNamed:(NSString *)imageName graphicStruct:(MKGraphicsStructures *)graphicStruct;

/**
 Creates an Instance of MKImage.
 
 @param path the path of the image you want to mask
 
 @param color the color to make the image
 
 @return MKImage instance
*/
- (id)initWithContentsOfFile:(NSString *)path graphicStruct:(MKGraphicsStructures *)graphicStruct;

@end
