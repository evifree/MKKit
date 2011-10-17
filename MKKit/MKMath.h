//
//  MKMath.h
//  MKKit
//
//  Created by Matthew King on 2/7/10.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKObject.h"

/**------------------------------------------------------------------------------------------
 The MKMath object preforms simple math on the contents of an Array. These methods are useful
 for calculating trasient core data attributes.
 
 @warning *Note* Arrays passed to this object must contain NSDecimalNumber objects.
--------------------------------------------------------------------------------------------*/

@interface MKMath : MKObject {

}

///---------------------------------
/// @name Sums
///---------------------------------

/** 
 Returns an the sum of all the numbers in an Array
	
 @param anArray The array to be calculated. This array should contain NSDecimalNumber objects.
 
 @return NSDecimalNumber that equals the sum of all the numbers provided.
*/
- (NSDecimalNumber *)sumOfArray:(NSArray *)anArray;

/** 
 Returns an the sum of all the numbers in an Array
 
 @param anArray The array to be calculated. This array should contain NSDecimalNumber objects.
 
 @return NSDecimalNumber that equals the sum of all the numbers provided.
*/
+ (NSDecimalNumber *)sumFromArray:(NSArray *)array;

///----------------------------------
/// @name Averages
///----------------------------------

/** 
 Returns and average of all the number in an Array
 
 @param anArray The array to be averaged. This array should contain NSDecimalNumber objects.
 
 @return NSDecimalNumber that equals the average of all the numbers provided.
*/
- (NSDecimalNumber *)averageOfArray:(NSArray *)anArray;

/** 
 Returns and average of all the number in an Array
 
 @param anArray The array to be averaged. This array should contain NSDecimalNumber objects.
 
 @param NSDecimalNumber that equals the average of all the numbers provided.
*/
+ (NSDecimalNumber *)averageFromArray:(NSArray *)array;

@end
