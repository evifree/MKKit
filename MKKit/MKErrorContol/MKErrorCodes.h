//
//  MKErrorCodes.h
//  MKKit
//
//  Created by Matthew King on 11/8/10.
//  Copyright 2010 Matt King. All rights reserved.
//


#define ERROR_CODE_100                      100
#define ERROR_DESCRIPTION_100               @"Error creating context"

#define ERROR_CODE_701                      701
#define ERROR_DESCRIPTION_701               @"Validation Error : Please enter a number in this field."

#define ERROR_CODE_702                      702
#define ERROR_DESCRIPTION_702               @"Validation Error : This is a required field."

#define ERROR_CODE_703                      703
#define ERROR_DESCRIPTION_703(required)     [NSString stringWithFormat:@"Validation Error : This field must be %i characters long", (required)]