//
//  MKSlider.h
//  MKKit
//
//  Created by Matthew King on 9/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MKControl.h"

@class MKControl;

/**-------------------------------------------------------------------------------------------------------
 The MKSlider control object creates a sliding control. The conrol allows the user to slide a puck back and forth
 on it. When the puck gets to the far right side an action is sent. This class allows you supply your own
 image for the puck.
 
 You should use `initWithFrame:` to initalize this class.
 
 This class sends the didCompleteAction: method to the delegate.
---------------------------------------------------------------------------------------------------------*/
@interface MKSlider : MKControl {
	UIImage *_puck;
	UILabel *_descriptionLabel;
	UIImageView *_puckView;
}

///----------------------------------------------------------
/// @name Slider Elements
///----------------------------------------------------------

/** The image for for the sliders puck. This is expected to a 48x38 image */
@property (nonatomic, retain) UIImage *puck;

/** The Label that is placed on the slider. This should give a reference to the action the 
 siler will complete.
*/
@property (nonatomic, retain) UILabel *descriptionLabel;

/** The image view for the pucks image. */
@property (nonatomic, retain) UIImageView *puckView;

///----------------------------------------------------------
/// @name Delegate
///----------------------------------------------------------

/** The MKControl Delegate 
 
 @see MKControlDelegate
*/
@property (nonatomic, assign) id<MKControlDelegate> delegate;

@end
