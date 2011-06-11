//
//  MKIAPObserver.h
//  MKKit
//
//  Created by Matthew King on 5/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MKIAPViewController.h"

typedef enum {
    MKIAPEventRequestComplete,
    MKIAPEventRequestFailed,
    MKIAPEventPurchaseComplete,
    MKIAPEventRestoreComplete,
} MKIAPEvent;

/**----------------------------------------------------------------------------
 MKIAPObserver protocol provides methods to observe requests and purchases made
 by the MKIAPViewController. The messages sent to the observer will fall into 
 four event types:
 
 * `MKIAPEventRequestComplete` : a completed request
 * `MKIAPEventRequestFailed` : a failed request, this method does not post is if
 the request is canceled by the user.
 * `MKIAPEventPurchaseComplete`: a completed purchase
 * `MKIAPEventRestoreComplete` : a completed restore of purchase
----------------------------------------------------------------------------*/

@protocol MKIAPObserver <NSObject>

/**
 Called when an InApp purchase event happens.
 
 @param event the type of event that happened
 
 @param identifiers a set of identifiers that were used in the request
 
 There are four event types:
 
 * `MKIAPEventRequestComplete` : a completed request
 * `MKIAPEventRequestFailed` : a failed request, this method does not post is if
 the request is canceled by the user.
 * `MKIAPEventPurchaseComplete`: a completed purchase
 * `MKIAPEventRestoreComplete` : a completed restore of purchase
*/
- (void)didCompleteEvent:(MKIAPEvent)event forIdentifiers:(NSSet *)identifiers;

@end
