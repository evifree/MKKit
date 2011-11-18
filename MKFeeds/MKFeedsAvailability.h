//
//  MKFeedsAvailability.h
//  MKKit
//
//  Created by Matthew King on 10/19/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

///////////////////////////////////////////////////////////
// TOGGLE THE MACRO TO MAKE MKKIT AVAILABLE TO MKFEEDS.  //
///////////////////////////////////////////////////////////

#define MKKIT_AVAILABLE_TO_MKFEEDS              1  // 1=AVAILABLE 0=NONAVAILABLE // 

#if MKKIT_AVAILABLE_TO_MKFEEDS
    #import <MKKit/MKKit/MKMacros.h>
#else
    #define MK_VISIBLE_ATTRIBUTE                __attribute__((visibility ("default")))
    
    #if __has_feature(objc_arc)
        #define MKKIT_ARC_COMPATABLE            1  // 1=COMPATABLE 0=NONCOMPATABLE
        #define MKKIT_SAFE_RELEASE(obj)
        #define MKKIT_SAFE_AUTORELEASE(obj)
    #else
        #define MKKIT_ARC_COMPATABLE            0  // 1=COMPATABLE 0=NONCOMPATABLE
        #define MKKIT_SAFE_RELEASE(obj)         [(obj) release]
        #define MKKIT_SAFE_AUTORELEASE(obj)     [(obj) autorelease]
    #endif
#endif