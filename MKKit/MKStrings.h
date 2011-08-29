//
//  MKStrings.h
//  MKKit
//
//  Created by Matthew King on 1/15/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>

/**---------------------------------------------------------------------------------------------------
 The MKStrings class formats NSDate and NSNumber objects into readable strings. This class also returns
 string represtions of directory paths.
-----------------------------------------------------------------------------------------------------*/

@interface MKStrings : NSObject {
	
}

///-----------------------------------------------------------------------
/// @name Date Strings
///-----------------------------------------------------------------------

/** Returns a string representation from a date and a specified format.
 
 @param date The date to format.
 @param format a string representation of the date format.
 
 Here are some examples
 
 Date Formats:
 
 * `@"MMM dd YYYY"` will return Jan 01 2011.
 * `@"MMMM dd YYYY"` will return January 01 2011.
 * `@"MM-dd-YYYY"` will return 01-01-2011.
 
 Time Formats:
 
 * `@"h:mm"` will return 1:00.
 * `@"hh:mm.ss"` will return 01:00.00.
 * `@"kk:mm"` will return 13:00.
*/
- (NSString *)date:(NSDate *)date withFormat:(NSString *)format;

/** Returns a string representation from a date and a specified format.
 
 @param date The date to format.
 @param format a string representation of the date format.
 
 Here are some examples
 
 Date Formats:
 
 * `@"MMM dd YYYY"` will return Jan 01 2011.
 * `@"MMMM dd YYYY"` will return January 01 2011.
 * `@"MM-dd-YYYY"` will return 01-01-2011.
 
 Time Formats:
 
 * `@"h:mm"` will return 1:00.
 * `@"hh:mm.ss"` will return 01:00.00.
 * `@"kk:mm"` will return 13:00.
 */
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;


///-----------------------------------------------------------------------
/// @name Number Strings
///-----------------------------------------------------------------------

/** Returns a string from a given number that is formatted into the local currency.
 
 @param number The number to format.
*/
- (NSString *)localCurrencyFromNumber:(NSNumber *)number; 

/** Returns a string from a given number that is formatted into the local currency.
 
 @param number The number to format.
 */
+ (NSString *)localCurrencyWithNumber:(NSNumber *)number;

/** Returns a string representaion of a decimal number with a set number of decimal places.
 
 @param number the NSNubmer instance to convert into a string.
 
 @param places the number of decimal places the string should have.
 
 @return an NSString intances that represents the given number.
*/
- (NSString *)stringFromDecimalNumber:(NSNumber *)number decimalPlaces:(NSUInteger)places;

/** Returns a string representaion of a decimal number with a set number of decimal places.
 
 @param number the NSNubmer instance to convert into a string.
 
 @param places the number of decimal places the string should have.
 
 @return an NSString intances that represents the given number.
 */
+ (NSString *)stringWithDecimalNumber:(NSNumber *)number decimalPlaces:(NSUInteger)places;

///-----------------------------------------------------------------------
/// @name Path Strings
///-----------------------------------------------------------------------

/** Returns the path to the applications document directory */
- (NSString *)documentsDirectoryPath;

@end
