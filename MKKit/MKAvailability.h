//
//  MKAvailablity.h
//  MKKit
//
//  Created by Matthew King on 9/4/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#define MK_KIT_0_8                          08
#define MK_KIT_0_9                          09

#define MK_KIT_CURRENT_VERSION              09

#define MK_DEPRECATED_0_8                   __attribute__((deprecated))
#define MK_DEPRECATED_0_9                   __attribute__((deprecated))

#define MK_VISIBLE_ATTRIBUTE                __attribute__((visibility ("default")))

////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////// FINDS IF PROJECT IS ARC COMPATABLE OR NOT ////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

/// EXPERIMENTAL -- NOT YET IMPLEMENTED  ///

#if __has_feature(objc_arc)
    #define MKKIT_ARC_COMPATABLE            1  // 1=COMPATABLE 0=NONCOMPATABLE
    #define MKKIT_SAFE_RELEASE(obj)
    #define MKKIT_SAFE_AUTORELEASE(obj)
#else
    #define MKKIT_ARC_COMPATABLE            0  // 1=COMPATABLE 0=NONCOMPATABLE
    #define MKKIT_SAFE_RELEASE(obj)         [(obj) release]
    #define MKKIT_SAFE_AUTORELEASE(obj)     [(obj) autorelease]
#endif

////////////////////////////////////////////////////////////////////////////////////////////////////
/// ADDTIONAL LIBRARIES AVAILABLE TO MKKIT TOGGLE THE MACROS TO MAKE LIBRARIES AVAILABLE OR NOT.  // 
////////////////////////////////////////////////////////////////////////////////////////////////////

#define MK_FEEDS_ALLOWED                1 // 1=AVAILABLE 0=NONAVAILABLE ////////////////////////////
#define MK_GRAPHS_ALLOWED               0 // 1=AVAILABLE 0=NONAVAILABLE ////////////////////////////