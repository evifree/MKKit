//
//  MKControl+Internal.h
//  MKKit
//
//  Created by Matthew King on 12/26/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKControl.h"

@class MKGraphicsStructures;

@interface MKControl (Internal)

/** Standard method to set basic control parameters */
- (void)setUpControl;

/** Return default graphics for contols. */
- (MKGraphicsStructures *)defaultGraphics;

@end