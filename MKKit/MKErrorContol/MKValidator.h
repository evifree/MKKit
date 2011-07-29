//
//  MKValidator.h
//  MKKit
//
//  Created by Matthew King on 1/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MKInputValidation.h"

#define VALIDATOR_DID_SEND_AN_ERROR                 @"validatorDidSendAnError"

/**----------------------------------------------------------------------------------
 The MKValidator is default validator for implementing the MKInputValidation protocol. This class
 will handel all of the validation methods for you. This can be overriden by add your own class
 that implements the MKInputValidation protocol.
------------------------------------------------------------------------------------*/

@interface MKValidator : NSObject <MKInputValidation> {

}

@end
