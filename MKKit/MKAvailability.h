//
//  MKAvailablity.h
//  MKKit
//
//  Created by Matthew King on 9/4/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#ifndef MKKit_MKAvailability_h
    #define MKKit_MKAvailability_h
#endif

#ifndef MK_MAX_VERSION_ALLOWED
    #define MK_MAX_VERSION_ALLOWED      0000
#endif

#define MK_KIT_0_8                      8
#define MK_KIT_0_9                      9

#define MK_DEPRECATED_0_8               __attribute__((deprecated))
#define MK_DEPRECATED_0_9               __attribute--((deprecated))
#define MK_VISIBLE_ATTRIBUTE            __attribute__((visibility ("default")))