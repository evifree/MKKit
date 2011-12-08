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
