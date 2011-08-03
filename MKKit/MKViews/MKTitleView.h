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

/**
 Creates an instance of MKTitleView.
 
 @param title the string that will be displayed on the navigation bar
 
 @param image the image icon that will displayed on the navigation bar.
 MKTitleView expects the image to 25px by 25px. The image should be a mask
 with only black and transparent colors.
 
 @return MKTitleView instance
*/ 
- (id)initWithTitle:(NSString *)title image:(UIImage *)image;

@end

@interface MKTitleViewIcon : MKView {
@private
    UIImage *mImage;
}

@property (nonatomic, retain) UIImage *image;

- (id)initWithFrame:(CGRect)frame icon:(UIImage *)icon;

@end
