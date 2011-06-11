//
//  MKAnimations.m
//  MKKit
//
//  Created by Matthew King on 1/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MKAnimations.h"

@implementation MKAnimations

@synthesize delegate, repeat;

#pragma mark --
#pragma mark Initalize

/**
 //Initialize Class and set the Delgegate
 **/ 
- (id)initWithDelegate:(id)theDelegate {
	if (theDelegate) {
		[self setDelegate:theDelegate];
		self.repeat = NO; 
	}
	return self;
}

#pragma mark --
#pragma mark Pulse a View

/**
 //Grow the view and call willAnimateView:
**/ 
- (void)pulseView:(UIView *)theView withScaleFactor:(CGFloat)scaleFactor duration:(NSTimeInterval)duration animationID:(NSString *)animationID {
	[UIView beginAnimations:animationID context:theView];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationWillStartSelector:@selector(animationWillStart:context:)];
	[UIView setAnimationDidStopSelector:@selector(pulseViewDidPulseUP:finished:context:)];
	CGAffineTransform transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
	theView.transform = transform;
	[UIView commitAnimations];
}

/**
 //Return the view
 **/ 
- (void)pulseViewDidPulseUP:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	UIView *theView = (UIView *)context;
	
	[UIView beginAnimations:animationID context:theView];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	CGAffineTransform transform = CGAffineTransformMakeScale(1.0, 1.0);
	theView.transform = transform;
	[UIView commitAnimations];
}

#pragma mark --
#pragma mark Move a View

/**
 //Move a View to a new Location
**/ 
- (void)moveView:(UIView *)theView toRect:(CGRect)newFrame duration:(NSTimeInterval)duration animationID:(NSString *)animationID {
	[UIView beginAnimations:animationID context:theView];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	theView.frame = newFrame;
	[UIView commitAnimations];
}

#pragma mark --
#pragma mark Fade a View Onto the Window

/**
 //Fade a View on to the Window
**/
- (void)fadeView:(UIView *)theView duration:(NSTimeInterval)duration toAlpha:(CGFloat)alphaValue animationID:(NSString *)animationID {
	[UIView beginAnimations:animationID context:theView];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationRepeatAutoreverses:repeat];
	[UIView setAnimationWillStartSelector:@selector(animationWillStart:context:)];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	theView.alpha = alphaValue;
	[UIView commitAnimations];
}


#pragma mark --
#pragma mark Delegate Method Calls

/**
 //Call didAnimateView:
 **/ 
- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	UIView *theView = (UIView *)context;
	
	if ([delegate respondsToSelector:@selector(didAnimateView:animationID:)]) {
		[delegate didAnimateView:theView animationID:animationID];
	}
	
	if ([delegate respondsToSelector:@selector(shouldRemoveSubview:animationID:)]) {
		[delegate shouldRemoveSubview:theView animationID:animationID];
	}
}

- (void)animationWillStart:(NSString *)animationID context:(void *)context {
	UIView *theView = (UIView *)context;
	
	if ([delegate respondsToSelector:@selector(willAnimateView:animationID:)]) {
		[delegate willAnimateView:theView animationID:animationID];
	}
}

- (void)dealloc {
	[super dealloc];
}

@end
