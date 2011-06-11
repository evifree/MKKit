//
//  MKCoreData.m
//  MKKit
//
//  Created by Matthew King on 5/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MKCoreData.h"

@interface MKCoreData ()

- (id)initWithContext:(NSManagedObjectContext *)context;

@end


@implementation MKCoreData

@synthesize fechCompletionBlock=mFechCompletionBlock;

static NSManagedObjectContext *managedObjectContext = nil;
static MKCoreData *sharedData = nil;

#pragma mark -
#pragma mark Set Up

+ (MKCoreData *)sharedData {
    if (!managedObjectContext) {
        NSException *exception = [NSException exceptionWithName:@"No context set" reason:@"Context needs to be set first using +[MKCoreData sharedDataWithContext:]" userInfo:nil];
        [exception raise];
    }
    
	return sharedData;
}

+ (void)sharedDataWithContext:(NSManagedObjectContext *)context {
	if (!sharedData) {
		sharedData = [[self alloc] initWithContext:context];
	}
}	

- (id)initWithContext:(NSManagedObjectContext *)context {
	if (self == [super init]) {
		managedObjectContext = context;
	}
	return self;
}

#pragma mark -
#pragma mark Managed Object Context

- (NSManagedObjectContext *)getContext {
	return managedObjectContext;
}

#pragma mark -
#pragma mark Feched Results

- (NSMutableArray *)fetchedResultsForEntity:(NSString *)entity sortedBy:(NSString *)attribute accending:(BOOL)accendeing {
	NSFetchRequest *request = [[NSFetchRequest alloc] init]; 
	NSEntityDescription *anEntity = [NSEntityDescription entityForName:entity inManagedObjectContext:managedObjectContext]; 
	[request setEntity:anEntity]; 
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:attribute ascending:accendeing]; 
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil]; 
	[request setSortDescriptors:sortDescriptors]; 
	
	[sortDescriptors release]; 
	[sortDescriptor release];
	
	NSError *error; 
	NSMutableArray *mutableFetchResults = [[[managedObjectContext executeFetchRequest:request error:&error] mutableCopy] autorelease]; 
	
	if (mutableFetchResults == nil) { 
		MKErrorHandeling *handeler	= [[MKErrorHandeling alloc] init];
		[handeler applicationDidError:error];
		[handeler release];		
	} 
	
	[request release]; 
	
	return mutableFetchResults;
}

- (void)fetchResultsForEntity:(NSString *)entity sortedBy:(NSString *)attribute accending:(BOOL)accending result:(MKFechCompletionBlock)result {
    self.fechCompletionBlock = result;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init]; 
	NSEntityDescription *anEntity = [NSEntityDescription entityForName:entity inManagedObjectContext:managedObjectContext]; 
	[request setEntity:anEntity]; 
	
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:attribute ascending:accending]; 
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil]; 
	[request setSortDescriptors:sortDescriptors]; 
	
	[sortDescriptors release]; 
	[sortDescriptor release];
	
	NSError *error; 
	NSMutableArray *mutableFetchResults = [[[managedObjectContext executeFetchRequest:request error:&error] mutableCopy] autorelease]; 
	
	if (mutableFetchResults == nil) { 
		self.fechCompletionBlock(nil, error);	
	}
    else {
        self.fechCompletionBlock(mutableFetchResults, nil);
    }
	
	[request release]; 
}

#pragma mark -
#pragma mark Memory Management

- (void)removeSharedData {
	sharedData = nil;
	[sharedData release];
	
	[self release];
}

- (void)dealloc {
	[super dealloc];
	
	if (managedObjectContext) {
		managedObjectContext = nil;
		[managedObjectContext release];
	}
	
	[managedObjectContext release];
	
	if (sharedData) {
		sharedData = nil;
		[sharedData release];
	}
}

@end
