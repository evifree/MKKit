//
//  MKApplication.m
//  MKKit
//
//  Created by Matthew King on 9/27/11.
//  Copyright (c) 2010-2011 Matt King. All rights reserved.
//

#import "MKApplication.h"

@interface MKApplication () 

- (void)timerDidFire:(NSTimer *)timer;

@end

@implementation MKApplication 

@synthesize minutes, useIdleTimer;

#pragma mark - Initalizer

- (id)init {
    self = [super init];
    if (self) {
        MKApplicationIdleTimeDidExpire = @"MKApplicationIdleTimeDidExpire";
    }
    return self;
}

#pragma mark - Events

- (void)sendEvent:(UIEvent *)event {
    [super sendEvent:event];
    
    if (self.useIdleTimer) {
        if (!mIdleTimer) {
            [self resetIdleTimer];
        }
    }
    
    NSSet *touches = [event allTouches];
    if ([touches count] > 0) {
        UITouchPhase phase = ((UITouch *)[touches anyObject]).phase;
        if (phase == UITouchPhaseBegan) {
            [self resetIdleTimer];
        }
    }
}

#pragma mark - Idle Timer

- (void)resetIdleTimer {
    self.useIdleTimer = YES;
    if (mIdleTimer) {
        [mIdleTimer invalidate];
        [mIdleTimer release];
        mIdleTimer = nil;
    }
    
    if (self.minutes == 0) {
        self.minutes = 5;
    }
    
    int time = (self.minutes * kMKApplicationTimerMultiplier);
    mIdleTimer = [[NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(timerDidFire:) userInfo:nil repeats:NO] retain];
}

- (void)cancelIdleTimer {
    self.useIdleTimer = NO;
    if (mIdleTimer) {
        [mIdleTimer invalidate];
        [mIdleTimer release];
        mIdleTimer = nil;
    }
}

- (void)timerDidFire:(NSTimer *)timer {
    [[NSNotificationCenter defaultCenter] postNotificationName:MKApplicationIdleTimeDidExpire object:nil];
    
    [mIdleTimer release];
    mIdleTimer = nil;
}

#pragma mark - Memory Managment

- (void)dealloc {
    if (mIdleTimer) {
        [mIdleTimer release];
    }
    
    [super dealloc];
}

@end
