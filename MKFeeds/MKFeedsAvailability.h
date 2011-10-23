//
//  MKFeedsAvailability.h
//  MKKit
//
//  Created by Matthew King on 10/19/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#ifndef MKKIT_AVAILABLE
    #define MKKIT_AVAILABLE
    #define MKKIT_ALLOWED 9999
#else
    #define MKKIT_ALLOWED 8
#endif

#define MKKIT_MAX_ALLOWED 9


#if MKKIT_ALLOWED <= MKKIT_MAX_ALLOWED
    #import <MKKit/MKKit/MKMacros.h>
#else
    #define MK_VISIBLE_ATTRIBUTE          __attribute__((visibility ("default")))
#endif