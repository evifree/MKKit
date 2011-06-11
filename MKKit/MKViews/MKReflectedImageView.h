//
//  MKReflectedImageView.h
//  MKKit
//
//  Created by Matthew King on 5/16/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKView.h"

/**-----------------------------------------------------------------------------
 The MKReflecedImageView class displays an image and creates a reflection of that image
 underneath it. 
 
 @warning The frame for this view is calcuated by using the demtions of the provided image.
 Please use correct image sizes. The view will be the same width of the image, and height is 
 25% larger plus 2 pixs.  For example if your imgae is 100px high the height of the view will
 be 127px (100*.25 + 2).
-------------------------------------------------------------------------------*/

@interface MKReflectedImageView : MKView {
    UIImage *mImage;
}

///----------------------------------------------------------------------------
/// @name Creating
///----------------------------------------------------------------------------

/** 
 Returns an initalized instance of MKReflecedImageView.
 
 @param image the image that will be displayed and reflected.
 
 @param point the origin of the view. This is the top right corner.
*/
- (id)initWithImage:(UIImage *)image drawAt:(CGPoint)point;

///----------------------------------------------------------------------------
/// @name Elements
///----------------------------------------------------------------------------

/** The image of the view */
@property (nonatomic, retain, readonly) UIImage *image;

@end
