//
//  MKCheckBox.h
//  MKKit
//
//  Created by Matthew King on 10/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MKControl.h"

@class MKControl;

/**----------------------------------------------------------------------------------------
 The MKCheckBox class creates a 30x30 checkbox object. When the user touches the check box it is toggled
 on and off.
 
 You should use `initWithFrame:` to initalize this class.
 
 MKCheckBox send a `UIControlEventValueChanged` action.
-------------------------------------------------------------------------------------------*/

@interface MKCheckBox : MKControl {
	BOOL _boxChecked;
	
	@private
		UIImageView *checkMarkView;
}

/** `YES` if the box is checked, `NO` if it is not */
@property (nonatomic, assign, getter=isBoxChecked) BOOL boxChecked;

@end
