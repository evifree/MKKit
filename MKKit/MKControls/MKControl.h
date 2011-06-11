//
//  MKControl.h
//  MKKit
//
//  Created by Matthew King on 10/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKMacros.h>
#import "MKControlDelegate.h"

@protocol MKControlDelegate;

/**---------------------------------------------------------------------------------------------
 The MKControl class is the super class of all other control objects. This class implements the 
 MKControlDelegate protocol.
-----------------------------------------------------------------------------------------------*/

@interface MKControl : UIControl {
    id mDelegate;
}

///---------------------------------------------------------
/// @name Delegate
///---------------------------------------------------------

/** delegate the controls delegate */
@property (nonatomic, assign) id<MKControlDelegate> delegate;

@end
