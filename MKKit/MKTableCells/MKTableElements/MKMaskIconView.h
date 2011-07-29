//
//  MKMaskIconView.h
//  MKKit
//
//  Created by Matthew King on 7/5/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKViews/MKViewHeader.h>

/**---------------------------------------------------------------------
 MKMaskIconView creates and colors a mask of an icon for display on a table
 cell.
----------------------------------------------------------------------*/

@interface MKMaskIconView : MKView {
    
}

///-------------------------------------
/// @name Creating
///-------------------------------------

/**
 Creates and instance of MKMaskIconView.
 
 @param image the image that will be masked. The image should be a 30x30 png
 file has black and transparent colors.
 
 @return MKMaskIconView instance
*/
- (id)initWithImage:(UIImage *)image;

@end
