//
//  MKControl.m
//  MKKit
//
//  Created by Matthew King on 10/5/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKControl.h"

#pragma mark - Functions

@implementation MKControl

@synthesize delegate=mDelegate, working=mWorking, action;

#pragma mark - Action Responders

- (void)completedAction:(MKActionBlock)actionBlock {
    self.action = actionBlock;
    
    mControlUsageFlags.blockUsage = YES;
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
    
    mControlUsageFlags.targetUsage = YES;
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (mControlUsageFlags.blockUsage) {
        self.action(MKActionTouchDown);
    }
    
    if (mControlUsageFlags.targetUsage) {
        for (MKControlTarget *aTarget in mTargets) {
            if (aTarget.action == MKActionTouchDown) {
                [aTarget.target performSelector:aTarget.selector withObject:self];
            }
        }
    }
    
    if ([mDelegate respondsToSelector:@selector(didCompleteAction:sender:)]) {
        [mDelegate didCompleteAction:MKActionTouchDown sender:self];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (mControlUsageFlags.blockUsage) {
        self.action(MKActionTouchUp);
    }
    
    if (mControlUsageFlags.targetUsage) {
        for (MKControlTarget *aTarget in mTargets) {
            if (aTarget.action == MKActionTouchUp) {
                [aTarget.target performSelector:aTarget.selector withObject:self];
            }
        }
    }
    
    if ([mDelegate respondsToSelector:@selector(didCompleteAction:sender:)]) {
        [mDelegate didCompleteAction:MKActionTouchUp sender:self];
    }
}

- (void)dealloc {
    if (mControlUsageFlags.blockUsage) {
        [action release];
    }
    
    if (mControlUsageFlags.targetUsage) {
        [mTargets release];
    }
    
    [super dealloc];
}

@end

@implementation MKControlTarget

@synthesize target, selector, action;

@end
