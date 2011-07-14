//
//  MKView.m
//  MKKit
//
//  Created by Matthew King on 10/9/10.
//  Copyright 2010 Matt King. All rights reserved.
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
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeView) name:MK_VIEW_SHOULD_REMOVE_NOTIFICATION object:nil];
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
        self.frame = CGRectMake(CENTER_VIEW_HORIZONTALLY(320.0, self.frame.size.width), (460.0 - self.frame.size.height - TOOLBAR_HEIGHT -20.0), self.frame.size.width, self.frame.size.height);
        
        [UIView animateWithDuration:0.25
                         animations: ^ { self.alpha = 1.0; }];
    }
    
    if ([mDelegate respondsToSelector:@selector(MKViewDidAppear:)]) {
        [mDelegate MKViewDidAppear:self];
    }
}


- (void)showOnViewController:(UIViewController *)controller animationType:(MKViewAnimationType)type {
    [controller.view addSubview:self];
    
    CGFloat height = 460.0;
    CGFloat width = 320.0; 
    
    if (controller.interfaceOrientation == UIInterfaceOrientationPortrait || controller.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        height = 460.0;
        width = 320.0;
    }
    if (controller.interfaceOrientation == UIInterfaceOrientationLandscapeRight || controller.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        height = 300.0;
        width = 480.0;
    }

    if (type == MKViewAnimationTypeNone) {
        self.alpha = 1.0;
    }
    
    if (type == MKViewAnimationTypeFadeIn) {
        //self.center = controller.view.center;
        self.frame = CGRectMake(CENTER_VIEW_HORIZONTALLY(width, self.frame.size.width), ((height / 2.0) - (self.frame.size.height / 2.0)), self.frame.size.width, self.frame.size.height);
        
        [UIView animateWithDuration:0.25 
                         animations: ^ { self.alpha = 1.0; }];
    }
    
    if (type == MKViewAnimationTypeMoveInFromTop) {
        CGRect moveTo = self.frame;
        
        self.frame = CGRectMake(self.frame.origin.x, (0.0 - self.frame.size.height), width, self.frame.size.height);
        
        self.alpha = 1.0;
        
        [UIView animateWithDuration:0.25
                         animations: ^ { self.frame = moveTo; }];
    }
    

    if (type == MKViewAnimationTypeAppearAboveToolbar) {
        self.frame = CGRectMake(CENTER_VIEW_HORIZONTALLY(width, self.frame.size.width), (height - self.frame.size.height - TOOLBAR_HEIGHT -20.0), self.frame.size.width, self.frame.size.height);
        
        [UIView animateWithDuration:0.25
                         animations: ^ { self.alpha = 1.0; }];
    }
    
    if ([mDelegate respondsToSelector:@selector(MKViewDidAppear:)]) {
        [mDelegate MKViewDidAppear:self];
    }
}

#pragma mark - Removing

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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MK_VIEW_SHOULD_REMOVE_NOTIFICATION object:nil];
    
	[super dealloc];
}

@end
