//
//  MKControl.m
//  MKKit
//
//  Created by Matthew King on 10/5/10.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import "MKControl.h"

@implementation MKControl

@synthesize delegate=mDelegate, working=mWorking, action;

#pragma mark - Action Responders

- (void)completedAction:(MKActionBlock)actionBlock {
    self.action = actionBlock;
    
    MKControlFlags.blockUsage = YES;
}

- (void)addTarget:(id)target selector:(SEL)selector action:(MKAction)controlAction {
    MKControlTarget *newTarget = [[MKControlTarget alloc] init];
    newTarget.target = target;
    newTarget.selector = selector;
    newTarget.action = controlAction;
    
    if (!mTargets) {
        mTargets = [[NSMutableSet alloc] initWithCapacity:1];
    }

    [mTargets addObject:newTarget];
    [newTarget release];
    
    MKControlFlags.targetUsage = YES;
}

- (void)processAction:(MKAction)controlAction {
    if (MKControlFlags.blockUsage) {
        self.action(controlAction);
    }
    
    if (MKControlFlags.targetUsage) {
        for (MKControlTarget *aTarget in mTargets) {
            if (aTarget.action == controlAction) {
                [aTarget.target performSelector:aTarget.selector withObject:self];
            }
        }
    }
    
    if ([mDelegate respondsToSelector:@selector(didCompleteAction:sender:)]) {
        [mDelegate didCompleteAction:controlAction sender:self];
    }

}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self processAction:MKActionTouchDown];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self processAction:MKActionTouchUp];
}

#pragma mark - Memory Management

- (void)didRelease {
    //method for catagories use.
}

- (void)dealloc { 
    [self didRelease];
    
    if (MKControlFlags.blockUsage) {
        [action release];
    }
    
    if (MKControlFlags.targetUsage) {
        [mTargets release];
    }
    
    [super dealloc];
}

@end

@implementation MKControlTarget

@synthesize target, selector, action;

@end
