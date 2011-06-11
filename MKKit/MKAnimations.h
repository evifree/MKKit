//
//  MKAnimations.h
//  MKKit
//
//  Created by Matthew King on 1/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@protocol MKAnimationsDelegate;

@interface MKAnimations : NSObject {
	id delegate;
	BOOL repeat;
}

@property (nonatomic, assign) id<MKAnimationsDelegate> delegate;
@property (nonatomic, assign) BOOL repeat;

- (id)initWithDelegate:(id)theDelegate;

//** Animating Views **//

//Pulse a View
- (void)pulseView:(UIView *)theView withScaleFactor:(CGFloat)scaleFactor duration:(NSTimeInterval)duration animationID:(NSString *)animationID;

//Move a View
- (void)moveView:(UIView *)theView toRect:(CGRect)newFrame duration:(NSTimeInterval)duration animationID:(NSString *)animationID;

//Fade a View 
- (void)fadeView:(UIView *)theView duration:(NSTimeInterval)duration toAlpha:(CGFloat)alphaValue animationID:(NSString *)animationID;

@end

////////////////////////////////////////////////////////////////////

//** MKAnimation Delegate Protocal **//

@protocol MKAnimationsDelegate <NSObject> 

@optional

//Called before animation starts
- (void)willAnimateView:(UIView *)theView animationID:(NSString *)animationID;

//Called when animation stops
- (void)didAnimateView:(UIView *)theView animationID:(NSString *)animationID;

//Called when animation stops
//Call to remove view when anmimation stops
- (void)shouldRemoveSubview:(UIView *)theView animationID:(NSString *)animationID;

@end
