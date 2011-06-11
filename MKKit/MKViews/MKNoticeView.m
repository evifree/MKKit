//
//  MKNoticeView.m
//  MKKit
//
//  Created by Matthew King on 5/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MKNoticeView.h"


@implementation MKNoticeView

@synthesize duration=mDuration;

#pragma mark - Intalizer

- (id)initWithMessage:(NSString *)message {
    self = [super initWithFrame:CGRectMake(CENTER_VIEW_HORIZONALLY(200.0), 360.0, 200.0, 31.0)];
    if (self) {
        self.backgroundColor = BLACK;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, 190.0, 21.0)];
        label.font = VERDANA_BOLD(14.0);
        label.textColor = WHITE;
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = CLEAR;
        label.text = message;
        
        [self addSubview:label];
        [label release];
    }
    return self;
}

#pragma mark - Factory Methods

+ (void)showWithMessage:(NSString *)message duration:(NSTimeInterval)duration {
    [self release];
    
    MKNoticeView *view = [[MKNoticeView alloc] initWithMessage:message];
    view.duration = duration;
    view.alpha = 0.0;
    [view showWithAnimationType:MKViewAnimationTypeFadeIn];
    [view release];
}

#pragma mark - Accessor Methods

- (void)setDuration:(NSTimeInterval)duration {
    [self performSelector:@selector(removeView) withObject:nil afterDelay:duration];
}

#pragma mark - Memory Management

- (void)dealloc {
    [super dealloc];
}

@end
