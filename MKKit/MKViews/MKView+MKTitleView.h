//
//  MKView+MKTitleView.h
//  MKKit
//
//  Created by Matthew King on 12/5/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKView.h"

@class MKImage;

@interface MKView (MKTitleView)

///--------------------------------------------
/// @name Creating
///--------------------------------------------

/**
 Creates an autoreleased instance of MKView Suited for display on a navigation bar.
 
 @param title the string that will be displayed on the navigation bar.
 
 @param image the image that will be drawn onto the navigtaion bar. See
 MKImgae for options of creating images.
 
 @return MKView instance
*/
+ (id)titleViewWithTitle:(NSString *)title image:(MKImage *)image;

/**
 Creates an instance of MKView Suited for display on a navigation bar.
 
 @param title the string that will be displayed on the navigation bar.

 @param image the image that will be drawn onto the navigtaion bar. See
 MKImgae for options of creating images.
 
@return MKView instance
*/
- (id)initWithTitle:(NSString *)title image:(MKImage *)image;

@end
