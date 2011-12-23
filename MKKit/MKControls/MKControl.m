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

@dynamic location;

#pragma mark - Creation 

- (id)init {
    self = [super init];
    if (self) {
        MKControlFlags.isEnabled = YES;
    }
    return self;
}

#pragma mark - Accessor Methods
#pragma makr Setters

- (void)setLocation:(CGPoint)location {
    self.frame = CGRectMake(location.x, location.y, self.frame.size.width, self.frame.size.height);
}

- (void)setEnabled:(BOOL)enabled {
    MKControlFlags.isEnabled = enabled;
    [self setNeedsDisplay];
}

#pragma mark Getters

- (CGPoint)location {
    return CGPointMake(self.frame.origin.x, self.frame.origin.y);
}

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
    if (MKControlFlags.isEnabled) {
        [self processAction:MKActionTouchDown];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (MKControlFlags.isEnabled) {
        [self processAction:MKActionTouchUp];
    }
}

#pragma mark - Memory Management

- (void)didRelease {
    //method for catagories use.
}

- (void)dealloc { 
    [self didRelease];
    
    self.action = nil;
        
    if (MKControlFlags.targetUsage) {
        [mTargets release];
    }
    
    [super dealloc];
}

@end

@implementation MKControlTarget

@synthesize target, selector, action;

@end
