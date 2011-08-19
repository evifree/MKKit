//
//  MKControl.m
//  MKKit
//
//  Created by Matthew King on 10/5/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKControl.h"

@implementation MKControl

@synthesize delegate=mDelegate, working=mWorking, action;

- (void)completedAction:(MKActionBlock)actionBlock {
    self.action = actionBlock;
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.action) {
        self.action(MKActionTouchDown);
    }
    
    if ([mDelegate respondsToSelector:@selector(didCompleteAction:sender:)]) {
        [mDelegate didCompleteAction:MKActionTouchDown sender:self];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.action) {
        self.action(MKActionTouchUp);
    }
    
    if ([mDelegate respondsToSelector:@selector(didCompleteAction:sender:)]) {
        [mDelegate didCompleteAction:MKActionTouchUp sender:self];
    }
}

- (void)dealloc {
    [action release];
    
    [super dealloc];
}

@end
