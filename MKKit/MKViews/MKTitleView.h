//
//  MKTitleView.h
//  MKKit
//
//  Created by Matthew King on 8/2/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKView.h"

/**---------------------------------------------------------
 *Deprecated Class v0.9. Use MKView(MKTitleView) catagory methods instead.*
----------------------------------------------------------*/

MK_DEPRECATED_0_9 @interface MKTitleView : MKView {
    
}

///-------------------------------------
/// @name Deprecations
///-------------------------------------

/**
 @warning *Deprecated Method v0.9* Use MKView(MKTitleView) catagory methods instead.
*/ 
- (id)initWithTitle:(NSString *)title image:(UIImage *)image MK_DEPRECATED_0_9;

/**
 @warning *Deprecated Method v0.9* Use MKView(MKTitleView) catagory methods instead.
*/
- (id)initWithTitle:(NSString *)title image:(UIImage *)image gradient:(MKGraphicsStructures *)gradient MK_DEPRECATED_0_9;

@end