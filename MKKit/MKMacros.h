//
//  MKMacros.h
//  MKKit
//
//  Created by Matthew King on 3/31/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKDeffinitions.h>

#import <math.h>

//  constants

#define PI                                              3.14159265359f

//  iPhone view frames

#define STATUS_BAR_HEIGHT                               20.0
#define IPHONE_WIDTH                                    320.0
#define IPHONE_HEIGHT                                   480.0
    
#define IPHONE_FRAME_WITH_STATUS_BAR                    CGRectMake(0.0, 0.0, IPHONE_WIDTH, (IPHONE_HEIGHT - STATUS_BAR_HEIGHT))
#define IPHONE_FRAME_WITHOUT_STATUS_BAR                 CGRectMake(0.0, 0.0, IPHONE_WIDTH, IPHONE_HEIGHT)

//  orientations

#define DEVICE_ORIENTATION_IS_LANDSCAPED                [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight
#define DEVICE_ORIENTATION_IS_PORTRAIT                  [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown

//  points

#define WINDOW_CENTER                                   [[[UIApplication sharedApplication] keyWindow] center]
#define CENTER_VIEW_HORIZONTALLY(viewWidth, width)      (((viewWidth) - (width)) / 2)

//  sizes

#define TOOLBAR_HEIGHT                                  34.0
#define MK_TEXT_WIDTH(string, font)                     [(string) sizeWithFont:(font)].width

//  conversions

#define MK_D2R(deg)                                     ((deg) / 180.0f * PI)

//  fonts

#define COURIER_BOLD(points)                            [UIFont fontWithName:@"Courier-Bold" size:(points)]
#define SYSTEM(points)                                  [UIFont systemFontOfSize:(points)]
#define SYSTEM_BOLD(points)                             [UIFont boldSystemFontOfSize:(points)]
#define VERDANA_BOLD(points)                            [UIFont fontWithName:@"Verdana-Bold" size:(points)]

//  Colors

#define MK_COLOR_HSB(h,s,b,a)                           [UIColor colorWithHue:((h)/360.0) saturation:((s)/100.0) brightness:((b)/100.0) alpha:(a)]
#define MK_COLOR_RGB(r,g,b,a)                           [UIColor colorWithRed:((r)/255.0) green:((g)/255.0) blue:((b)/255.0) alpha:(a)]
#define MK_SHADOW_COLOR                                 MK_COLOR_RGB(51.0, 51.0, 51.0, 0.5).CGColor

#define BLACK                                           [UIColor blackColor]
#define BLUE                                            [UIColor blueColor]
#define CLEAR                                           [UIColor clearColor]
#define GRAY                                            [UIColor grayColor]
#define DARK_GRAY                                       [UIColor darkGrayColor]
#define LIGHT_GRAY                                      [UIColor lightGrayColor]
#define RED                                             [UIColor redColor]
#define WHITE                                           [UIColor whiteColor]