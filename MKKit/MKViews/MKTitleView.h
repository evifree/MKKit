//
//  MKTitleView.h
//  MKKit
//
//  Created by Matthew King on 8/2/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKView.h"

/**---------------------------------------------------------
 MKTitleView provides a custom title view for a navigation bar.
 The view has a small icon on the right and text next to it.
----------------------------------------------------------*/

@interface MKTitleView : MKView {
    
}

///-------------------------------------
/// @name Creating
///-------------------------------------

/**
 Creates an instance of MKTitleView.
 
 @param title the string that will be displayed on the navigation bar
 
 @param image the image icon that will displayed on the navigation bar.
 
 @return MKTitleView instance
*/ 
- (id)initWithTitle:(NSString *)title image:(UIImage *)image;

/**
 Creates an instance of MKTitleView.
 
 @param title the string that will be displayed on the navigation bar.
 
 @param image the image mask that will be drawn onto the navigtaion bar.
 
 @param gradient the gradient that will be used to color the image. Use the method
 + [(id) MKGraphicStructures linearGradientWithTopColor:bottomColor:]to make a gradient.
 Pass the same color for the top and bottom for a solid color.
 
 Default is solid white.
 
 @return MKTitleView instance
*/
- (id)initWithTitle:(NSString *)title image:(UIImage *)image gradient:(MKGraphicsStructures *)gradient;

@end