//
//  MKAIPController.m
//  MKKit
//
//  Created by Matthew King on 5/28/11.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import "MKIAPController.h"

@interface MKIAPController ()

- (void)completeTransaction:(SKPaymentTransaction *)transaction;
- (void)restoreTransaction:(SKPaymentTransaction *)transaction;
- (void)failedTransaction:(SKPaymentTransaction *)transaction;

@end

@implementation MKIAPController

@synthesize delegate=mDelegate, productResponse, purchaseCompleteBlock, restoreCompleteBlock, storeIsOpen=mIsOpen;

MKIAPController *mSharedStore = nil;

#pragma mark - Singleton

+ (id)sharedStore {
    @synchronized(self) {
        if (!mSharedStore) {
            mSharedStore = [[[self class] alloc] init];
        }
    }
    return mSharedStore;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (mSharedStore == nil) {
            mSharedStore = [super allocWithZone:zone];
            return mSharedStore;
        }
    }
    return nil;
}

#pragma mark - Opening And Closing

+ (void)openStore {
    mSharedStore = [MKIAPController sharedStore];
    mSharedStore->mIsOpen = YES;
}

+ (void)closeStore {
    if (mSharedStore) {
        mSharedStore->mIsOpen = NO;
        
        [mSharedStore release];
        mSharedStore = nil;
        
        [self release];
    }
}

#pragma mark - Initalizer

- (id)initWithDelegate:(id<MKIAPDelegate>)delegate {
    self = [super init];
    if (self) {
        mDelegate = delegate;
    }
    return  self;
}

#pragma mark - Accessor Methods

- (BOOL)storeIsOpen {
    return mIsOpen;
}
 
#pragma mark - Requests

+ (void)productsRequestWithIdentifiers:(NSSet *)identifiers response:(MKProductResponseBlock)response {
    if (mSharedStore.storeIsOpen) {
        mSharedStore.productResponse = response;
        [mSharedStore productsRequestWithIdentifiers:identifiers];
    }
}

- (void)productsRequestWithIdentifiers:(NSSet *)identifiers {
    mIsPurchaseRequest = NO;
    
    SKProductsRequest *request = [[[SKProductsRequest alloc] initWithProductIdentifiers:identifiers] autorelease];
    request.delegate = self;
    [request start];
}

#pragma mark - Purchasing

+ (void)purchaseRequestWithIdentifiers:(NSSet *)identifiers completion:(MKPurchaseCompletionBlock)completion {
    if (mSharedStore.storeIsOpen) {
        mSharedStore.purchaseCompleteBlock = completion;
        [mSharedStore purchaseRequestWithIdentifiers:identifiers];
    }
}

- (void)purchaseRequestWithIdentifiers:(NSSet *)identifiers {
    mIsPurchaseRequest = YES;
    
    SKProductsRequest *request = [[[SKProductsRequest alloc] initWithProductIdentifiers:identifiers] autorelease];
    request.delegate = self;
    [request start];
}

#pragma mark - Restoring

+ (void)restorePurchase:(MKRestoreCompletionBlock)completion {
    if (mSharedStore.storeIsOpen) {
        mSharedStore.restoreCompleteBlock = completion;
        [mSharedStore restorePurchases];
    }
}

- (void)restorePurchases {
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

#pragma mark - Delegates
#pragma mark SKProductsRequest

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    if (!mIsPurchaseRequest) {
        self.productResponse(response, nil);
        
        if ([mDelegate respondsToSelector:@selector(didRecieveResponse:)]) {
            [mDelegate didRecieveResponse:response];
        }
    }
    
    if (mIsPurchaseRequest) {
        for (SKProduct *product in response.products) {
            [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
            
            SKPayment *payment = [SKPayment paymentWithProductIdentifier:product.productIdentifier];
            [[SKPaymentQueue defaultQueue] addPayment:payment];	
        }
    }
}

#pragma mark SKRequest

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    if (self.productResponse) {
        self.productResponse(nil, error);
    }
    if (self.restoreCompleteBlock) {
        self.restoreCompleteBlock(NO, error);
    }
    if (self.purchaseCompleteBlock) {
        self.purchaseCompleteBlock(nil, error);
    }
    
    if ([mDelegate respondsToSelector:@selector(didError:)]) {
        [mDelegate didError:error];
    }
}

#pragma mark SKPaymentTransaction

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error {
    self.restoreCompleteBlock(nil, error);
	    
    if ([mDelegate respondsToSelector:@selector(didError:)]) {
        [mDelegate didError:error];
    }
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {

}

#pragma mark Transaction Observer

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    if (self.purchaseCompleteBlock) {
         self.purchaseCompleteBlock(transaction, nil);
    }
        
    if ([mDelegate respondsToSelector:@selector(didCompleteTransaction:)]) {
        [mDelegate didCompleteTransaction:transaction];
    }
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    if (restoreCompleteBlock) {
        self.restoreCompleteBlock(transaction, nil);
    }
        
    if ([mDelegate respondsToSelector:@selector(didCompleteTransaction:)]) {
        [mDelegate didCompleteTransaction:transaction];
    }
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    if ([mDelegate respondsToSelector:@selector(didError:)]) {
        [mDelegate didError:transaction.error];
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    self.purchaseCompleteBlock(transaction, transaction.error);
}
 
- (void)dealloc {
    NSLog(@"release");
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
        
    [productResponse release];
    [purchaseCompleteBlock release];
    [restoreCompleteBlock release];
    
    [super dealloc];
}

@end
