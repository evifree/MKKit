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

/**--------------------------------------------------------------------------
 *Overview*
 
 MKGraphicsStructures stores graphic elements to help with uniformity across
 an application.
 
 *Usage*
 
 MKKit class that use the MKGraphicsStructures class will refereance an instance
 when preforming drawing operations. 
 
 *Required Classes*
 
 * MKObject
 
 *Required Frameworks*
 
 * Foundation
 * UIKit
 * Core Graphics
--------------------------------------------------------------------------*/

@interface MKGraphicsStructures : MKObject {
@private
    UIColor *mTopColor;
    UIColor *mBottomColor;
}

///-----------------------------------------
/// @name Creating
///-----------------------------------------

/**
 Creates an autoreleasing empty instance.
 
 return MKGraphicsStructure instace
*/
+ (id)graphicsStructure;

/**
 An instance of MKGraphisStructures that sets the colors for a linear gradient.
 
 @param topColor the color on the top of the gradient.
 
 @param bottomColor the color on the bottom of the gradient.
 
 @return MKGraphicsStructure instance
*/
+ (id)linearGradientWithTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor;

///------------------------------------------
/// @name Assigning Structures
///------------------------------------------

/**
 Assings colors for a linear gradient
 
 @param topColor the color on the top of the gradient.
 
 @param bottomColor the color on the bottom of the gradient.
*/
- (void)assignGradientTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor;

/** the top color of the gradient */
@property (nonatomic, retain) UIColor *top;

/** the bottom color of the gradient */
@property (nonatomic, retain) UIColor *bottom;

@end