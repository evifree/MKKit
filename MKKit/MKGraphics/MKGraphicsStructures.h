//
//  MKGraphicsStructures.h
//  MKKit
//
//  Created by Matthew King on 9/18/11.
//  Copyright (c) 2010-2011 Matt King. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#import <MKKit/MKKit/MKObject.h>

/**--------------------------------------------------------------------------
 MKGraphicStructures controls the way graphics in MKKit are drawn. 
 --------------------------------------------------------------------------*/
@interface MKGraphicsStructures : MKObject {
@private
    
}

@end

/**-------------------------------------------------------------------------
 The Linear Gradient category sets the gradient pattern for graphic drawings.
 -------------------------------------------------------------------------*/
@interface MKGraphicsStructures (LinearGradient) 

///-----------------------------
/// @name Creating
///-----------------------------

/**
 An instance of MKGraphisStructures that sets the colors for a linear gradient.
 
 @param topColor the color on the top of the gradient.
 
 @param bottomColor the color on the bottom of the gradient.
*/
+ (id)linearGradientWithTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor;

///-----------------------------
/// @name Colors
///-----------------------------

/** the top color of the gradient */
@property (nonatomic, retain) UIColor *top;

/** the bottom color of the gradient */
@property (nonatomic, retain) UIColor *bottom;

@end