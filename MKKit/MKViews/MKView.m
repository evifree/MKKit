//
//  MKView.m
//  MKKit
//
//  Created by Matthew King on 10/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MKView.h"
#import "MKPopOverView.h"

#pragma mark -
#pragma mark MKView

@implementation MKView

@synthesize controller=mController, delegate=mDelegate;

#pragma mark - Initalizer

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.autoresizesSubviews = YES;
        
        mShouldRemoveView = YES;
    }
    return self;
}

#pragma mark - Showing the View

- (void)showWithAnimationType:(MKViewAnimationType)type; {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    mAnimationType = type;
	
    if (type == MKViewAnimationTypeNone) {
        self.alpha = 1.0;
    }
    
    if (type == MKViewAnimationTypeFadeIn) {
        self.center = WINDOW_CENTER;
        
        [UIView animateWithDuration:0.25 
                         animations: ^ { self.alpha = 1.0; }];
    }
    
    if (type == MKViewAnimationTypeMoveInFromTop) {
        CGRect moveTo = self.frame;
               
        self.frame = CGRectMake(self.frame.origin.x, (0.0 - self.frame.size.height), self.frame.size.width, self.frame.size.height);
        
        self.alpha = 1.0;
        
        [UIView animateWithDuration:0.25
                         animations: ^ { self.frame = moveTo; }];
    }
    
    if (type == MKViewAnimationTypeAppearAboveToolbar) {
        self.frame = CGRectMake(CENTER_VIEW_HORIZONALLY(self.frame.size.width), (460.0 - self.frame.size.height - TOOLBAR_HEIGHT -20.0), self.frame.size.width, self.frame.size.height);
        
        [UIView animateWithDuration:0.25
                         animations: ^ { self.alpha = 1.0; }];
    }
    
    if ([mDelegate respondsToSelector:@selector(MKViewDidAppear:)]) {
        [mDelegate MKViewDidAppear:self];
    }
}

- (void)removeView {
    if ([mDelegate respondsToSelector:@selector(shouldRemoveView:)]) {
        mShouldRemoveView = [mDelegate shouldRemoveView:self];
    }
    
    if (mShouldRemoveView) {
        if (mAnimationType == MKViewAnimationTypeNone) {
            [self removeFromSuperview];
        }
        
        if (mAnimationType == MKViewAnimationTypeFadeIn || mAnimationType == MKViewAnimationTypeAppearAboveToolbar) {
            [UIView animateWithDuration:0.25
                             animations: ^ { self.alpha = 1.0; }
                             completion: ^ (BOOL finished) { [self removeFromSuperview]; }];
        }
        
        if (mAnimationType == MKViewAnimationTypeMoveInFromTop) {
            CGRect moveTo = CGRectMake(self.frame.origin.x, (0.0 - self.frame.size.height), self.frame.size.width, self.frame.size.height);
            
            [UIView animateWithDuration:0.25 
                             animations: ^ { self.frame = moveTo; }
                             completion: ^ (BOOL finished) { [self removeFromSuperview]; }];
        }
    }
}

#pragma mark - Memory Management

- (void)dealloc {
    [mController release];
	[super dealloc];
}

@end
