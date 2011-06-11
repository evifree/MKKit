//
//  MKCoreData.h
//  MKKit
//
//  Created by Matthew King on 5/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MKKit/MKKit/MKErrorContol/MKErrorHandeling.h>

typedef void (^MKFechCompletionBlock)(NSMutableArray *results, NSError *error);

/**---------------------------------------------------------------------------------------------

 The MKCoreData class is a singleton instance used to work with Core Data thoughout an application. 
 A NSManagedObject context needs to set before this object can preform any methods. You do this by
 calling sharedDataWithContext: 
 
	[[MKCoreData sharedData] sharedDataWithContext:myContext];
-----------------------------------------------------------------------------------------------*/

@interface MKCoreData : NSObject {
	MKFechCompletionBlock mFechCompletionBlock;
}

///---------------------------------------
/// @name Creating 
///---------------------------------------

/** 
 Returns the shared instance MKCoreData. 
 
 @exception context=nil Missing Context rasied expetion if no context has been set. Set the context by
 calling the sharedDataWithContext class method.
*/
+ (MKCoreData *)sharedData;


///---------------------------------------
/// @name Removing
///---------------------------------------

/** Releases the singleton instance from memory. */
- (void)removeSharedData;

///---------------------------------------
/// @name Context
///---------------------------------------

/** Creates the singleton object on sets the default managed object context. 
 
 @param context An instance if NSManagedObjectContext.
 */
+ (void)sharedDataWithContext:(NSManagedObjectContext *)context;


/** Returns the managed object context that was set by sharedDataWithContext:. */
- (NSManagedObjectContext *)getContext;

///---------------------------------------
/// @name Getting Data Sets
///---------------------------------------

/** Returns a mutable array for the given entity.
 
 @param entity The name of the entity.
 @param sortedBy The attribute to sort the array by.
 @param accending Tells how to sort the array.
*/
- (NSMutableArray *)fetchedResultsForEntity:(NSString *)entity sortedBy:(NSString *)attribute accending:(BOOL)accendeing;

/** Preforms a fech for the given entity.
 
 @param entity The name of the entity.
 @param sortedBy The attribute to sort the array by.
 @param accending Tells how to sort the array.
 @param result Code block to preform when the fech is complete
*/
- (void)fetchResultsForEntity:(NSString *)entity sortedBy:(NSString *)attribute accending:(BOOL)accending result:(MKFechCompletionBlock)result;

///---------------------------------------
/// @name Code Blocks
///---------------------------------------

/** the code to be preformed when a fech is complete. You should not set this property directly.*/
@property (nonatomic, copy) MKFechCompletionBlock fechCompletionBlock;

@end
