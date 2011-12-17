//
//  MKPopOutView+MKBarButtonItem.m
//  MKKit
//
//  Created by Matthew King on 12/17/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKPopOutView+MKBarButtonItem.h"

#import <MKKit/MKKit/MKControls/MKBarButtonItem.h>

@implementation MKPopOutView (MKBarButtonItem)

- (void)showFromButton:(MKBarButtonItem *)button onView:(UIView *)view {
    mAutoType = self.type;
    
    self.frame = CGRectMake(10.0, (CGRectGetMaxY(button.frame) + 5.0), 300.0, self.height);
    self.arrowPosition = CGRectGetMidX(button.frame);
    self.alpha = 0.0;
    
    [view addSubview:self];
    
    [UIView animateWithDuration:0.25
                     animations: ^ {
                         self.alpha = 1.0;
                     }];
}

@end
