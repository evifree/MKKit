//
//  MKControl+Internal.m
//  MKKit
//
//  Created by Matthew King on 12/26/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKControl+Internal.h"

#import "MKBarButtonItem.h"

@implementation MKControl (Internal)

- (void)setUpControl {
    
}

- (MKGraphicsStructures *)defaultGraphics {
    MKGraphicsStructures *graphics = [MKGraphicsStructures graphicsStructure];
    
    if ([self isMemberOfClass:[MKBarButtonItem class]]) {
        graphics.fill = [UIColor whiteColor];
        graphics.touched = [UIColor whiteColor];
        graphics.disabled = MK_COLOR_HSB(345.0, 1.0, 99.0, 0.50);
    }
    
    return graphics;
}

@end
