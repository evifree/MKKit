//
//  MKMath.h
//  MKKit
//
//  Created by Matthew King on 2/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**------------------------------------------------------------------------------------------
 The MKMath object preforms simple math on the contents of an Array. 
 
 @warning *Note* Arrays passed to this object must contain NSDecimalNumber objects.
--------------------------------------------------------------------------------------------*/

@interface MKMath : NSObject {

}

///---------------------------------
/// @name Math Methods
///---------------------------------

/** Returns an the sum of all the numbers in an Array
	
 @param anArray The array to be calculated. This array should contain NSDecimalNumber objects.
*/
- (NSDecimalNumber *)sumOfArray:(NSArray *)anArray;

/** Returns and averag of all the number in an Array
 
 @param anArray The array to be averaged. This array should contain NSDecimalNumber objects.
*/
- (NSDecimalNumber *)averageOfArray:(NSArray *)anArray;

@end
