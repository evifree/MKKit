//
//  MKValidator.m
//  MKKit
//
//  Created by Matthew King on 1/10/11.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import "MKValidator.h"

#import <MKKit/MKKit/MKTableCells/MKTableCell.h>
#import <MKKit/MKKit/MKTableCells/MKTableCellTypes/MKTableCellTextEntry.h>

@implementation MKValidator

@synthesize stringLength, tableView;

static MKValidator *mSharedValidator = nil;

#pragma mark - Singleton

+ (id)sharedValidator {
    @synchronized(self) {
        if (!mSharedValidator) {
            mSharedValidator = [[[self class] alloc] init];
        }
    }
    return mSharedValidator;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (mSharedValidator == nil) {
            mSharedValidator = [super allocWithZone:zone];
            return mSharedValidator;
        }
    }
    return nil;
}

#pragma mark - Initalizer

- (id)init {
    self = [super init];
    if (self) {
        MKValidatorDidValidateTableView = @"MKValidatorDidValitateTableView";
        MKValidatorField = @"MKValidatorField";
        MKValidatorEnteredText = @"MKValidatorEnteredText";
    }
    return self;
}

#pragma mark - Validation Object

- (void)addValidationRow:(NSIndexPath *)indexPath {
    [mValidationObjects addObject:indexPath];
}

- (void)removeValidationRow:(NSIndexPath *)indexPath {
    [mValidationObjects removeObject:indexPath];
}

- (void)removeTableView {
    [mValidationObjects removeAllObjects];
    [mValidationObjects release];
    mValidationObjects = nil;
    self.tableView = nil;
}

- (void)validate {
    BOOL validated = YES;
    
    for (NSIndexPath *indexPath in mValidationObjects) {
        MKTableCell *cell = (MKTableCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        if (![cell validatedWithType:cell.validationType]) {
            validated = NO;
        }
    }
    
    if (validated) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MKValidatorDidValidateTableView object:nil];
    }
}

#pragma mark - Auto Validation

- (void)registerTableView:(UITableView *)view {
    self.tableView = view;
    mValidationObjects = [[NSMutableSet alloc] initWithCapacity:0];
    
    NSInteger numOfSections = [tableView.dataSource numberOfSectionsInTableView:tableView];
    
    for (int i = 0; i < numOfSections; i++) {
        NSInteger numOfRows = [view.dataSource tableView:view numberOfRowsInSection:i];
        for (int j = 0; j < numOfRows; j++) {
            MKTableCell *cell = (MKTableCell *)[view.dataSource tableView:view cellForRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:i]];
            
            if (cell.validating) {
                [self addValidationRow:cell.indexPath];
            }
        }
    }
}

#pragma mark - Validation

- (BOOL)inputIsaNumber:(NSString *)text {
    BOOL validated = NO;
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		
	NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:text];
	NSString *symbol = [formatter stringFromNumber:number];
	
	[formatter release];
	
	if (![symbol isEqualToString:@"NaN"]) {
		validated = YES;
	}
	
	return validated;
}

- (BOOL)inputIsaSetLength:(NSString *)text {
    if (stringLength == 0) {
        NSException *exception = [NSException exceptionWithName:@"Invalid stringLength property" reason:@"The stringLength property cannot be nil or zero" userInfo:nil];
        [exception raise];
    }
    
    BOOL validated = NO;
    
    if ([text length] == self.stringLength) {
        validated = YES;
    }
    return validated;
}

- (BOOL)inputHasLength:(NSString *)text {
	if ([text length] != 0) {
		return YES;
	}
	return NO;
}

@end
