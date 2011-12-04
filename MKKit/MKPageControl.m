//
//  MKPageControll.m
//  MKKit
//
//  Created by Matthew King on 11/30/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKPageControl.h"

static MKPageControl *sharedPages = nil;

@implementation MKPageControl

@synthesize pageViewController, parentViewController;

@dynamic currentPage, numberOfPages;

static NSInteger mCurrentPage;

#pragma mark - Creation

+ (MKPageControl *)sharedPages {
    @synchronized(self) {
        if (sharedPages == nil) {
            sharedPages = [[self alloc] init];
        }
    }
    return sharedPages;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedPages == nil) {
            sharedPages = [super allocWithZone:zone];
            return sharedPages;
        }
    }
    return nil;
}

- (id)init {
    self = [super init];
    if (self) {
        mPages = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

#pragma mark - Memory Managment

- (void)dealloc {
    sharedPages = nil;
    parentViewController = nil;
    parentViewController = nil;
    
    [super dealloc];
}

#pragma mark - Accessor Methods

- (NSInteger)currentPage {
    return mCurrentPage;
}

- (NSInteger)numberOfPages {
    return [mPages count];
}

#pragma mark - Add/Remove Pages
#pragma mark Getters

- (void)addPage:(UIViewController *)page {
    [mPages addObject:page];
    
    if (mCurrentPage == 0) {
        mCurrentPage = 1;
    }
}

- (void)removeAllPages {
    [mPages removeAllObjects];
    mCurrentPage = 0;
    
    [mPages release];
    [sharedPages release];
}

#pragma mark - Page Controll

- (UIViewController *)nextPage {
    UIViewController *nextPage = nil;
    
    @try {
        nextPage = (UIViewController *)[mPages objectAtIndex:mCurrentPage];
        mCurrentPage = (mCurrentPage + 1);
    }
    @catch (NSException *exception) {
        nextPage = nil;
    }
    @finally {
    }
    
    return nextPage;
}

- (UIViewController *)previousPage {
    UIViewController *nextPage = nil;
    
    @try {
        nextPage = (UIViewController *)[mPages objectAtIndex:(mCurrentPage - 2)];
        mCurrentPage = (mCurrentPage - 1);
    }
    @catch (NSException *exception) {
        nextPage = nil;
    }
    @finally {
    }
    
    return nextPage;
}

#pragma mark - DataSource
#pragma mark PageViewController

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    return [self nextPage];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    return [self previousPage];
}

@end

