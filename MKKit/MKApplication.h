//
//  MKApplication.h
//  MKKit
//
//  Created by Matthew King on 9/27/11.
//  Copyright (c) 2010-2011 Matt King. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKKit/MKKit.h>

/**-------------------------------------------------------------------
 MKApplication subclasses UIApplication to add some special methods. 
 
 @warning *Important Notice* To use MKApplication you must add the class
 files to your project. Make sure to check the `Copy items into projects
 destination group folder` box.
 
 To use MKApplication you need make changes in your applications main.m
 file. Replace the method call `UIApplicationMain(argc, argv, nil, nil)` with
 `UIApplicationMain(argc, argv, @"MKApplication", nil)`. 
--------------------------------------------------------------------*/

@interface MKApplication : UIApplication {
@private
    NSTimer *mIdleTimer;
}

///------------------------------
/// @name Idle Timer
///------------------------------

/**
 Set this property to YES to turn on an idle timer for the application.
 An Idle timer will send a message if there are no touches for a set
 amount of time. 
 
 The timer will post a `MKApplicationIdleTimeDidExpire` Notification when
 the time is up. 
 
 The idle time is automatically reset everytime the user touhes anywhere on
 the screen. You can reset the timer yourself at anytime by calling the resetIdleTimer
 method. 
 
 @see minutes
 @see resetIdleTimer
*/
@property (nonatomic, assign) BOOL useIdleTimer;

/**
 The number of minutes until an idle timer expires. Default is 5 mins.
*/
@property (nonatomic, assign) NSInteger minutes;

/** 
 Resets the idle timer. If useIdleTimer is set to `NO` calling this method will
 change set it to `YES`.
*/
- (void)resetIdleTimer;

@end

NSString *MKApplicationIdleTimeDidExpire MK_VISIBLE_ATTRIBUTE;

static const float kMKApplicationTimerMultiplier   = 60.0;