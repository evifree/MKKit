//
//  MKAIPController.m
//  MKKit
//
//  Created by Matthew King on 5/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MKIAPController.h"

@interface MKIAPController ()

- (id)initWithIdentifiers:(NSSet *)identifiers response:(MKProductResponseBlock)response;
- (id)initWithIdentifiers:(NSSet *)identifiers completion:(MKPurchaseCompletionBlock)completion;
- (id)initWithCompletion:(MKRestoreCompletionBlock)completion;

- (void)completeTransaction:(SKPaymentTransaction *)transaction;
- (void)restoreTransaction:(SKPaymentTransaction *)transaction;
- (void)failedTransaction:(SKPaymentTransaction *)transaction;

@end

@implementation MKIAPController

@synthesize delegate=mDelegate, productResponse, purchaseCompleteBlock, restoreCompleteBlock;

#pragma mark - Initalizer

- (id)initWithDelegate:(id<MKIAPDelegate>)delegate {
    self = [super init];
    if (self) {
        mDelegate = delegate;
    }
    return  self;
}

- (id)initWithIdentifiers:(NSSet *)identifiers response:(MKProductResponseBlock)response {
    self = [super init];
    if (self) {
        self.productResponse = response;
        mIsPurchaseRequest = NO;
        
        SKProductsRequest *request = [[[SKProductsRequest alloc] initWithProductIdentifiers:identifiers] autorelease];
        request.delegate = self;
        [request start];
    }
    return self;
}

- (id)initWithIdentifiers:(NSSet *)identifiers completion:(MKPurchaseCompletionBlock)completion {
    self = [super init];
    if (self) {
        self.purchaseCompleteBlock = completion;
        mIsPurchaseRequest = YES;
        
        SKProductsRequest *request = [[[SKProductsRequest alloc] initWithProductIdentifiers:identifiers] autorelease];
        request.delegate = self;
        [request start];
    }
    return self;
}

- (id)initWithCompletion:(MKRestoreCompletionBlock)completion {
    self = [super init];
    if (self) {
        self.restoreCompleteBlock = completion;
        
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    }
    return self;
}

#pragma mark - Requests

+ (void)productsRequestWithIdentifiers:(NSSet *)identifiers response:(MKProductResponseBlock)response {
    [self release];
    
    [[self alloc] initWithIdentifiers:identifiers response:response];
}

- (void)productsRequestWithIdentifiers:(NSSet *)identifiers {
    mIsPurchaseRequest = NO;
    
    SKProductsRequest *request = [[[SKProductsRequest alloc] initWithProductIdentifiers:identifiers] autorelease];
    request.delegate = self;
    [request start];
}

#pragma mark - Purchasing

+ (void)purchaseRequestWithIdentifiers:(NSSet *)identifiers completion:(MKPurchaseCompletionBlock)completion {
    [self release];
    
    [[self alloc] initWithIdentifiers:identifiers completion:completion];
}

- (void)purchaseRequestWithIdentifiers:(NSSet *)identifiers {
    mIsPurchaseRequest = YES;
    
    SKProductsRequest *request = [[[SKProductsRequest alloc] initWithProductIdentifiers:identifiers] autorelease];
    request.delegate = self;
    [request start];
}

#pragma mark - Restoring

+ (void)restorePurchase:(MKRestoreCompletionBlock)completion {
    [self release];
    
    [[self alloc] initWithCompletion:completion];
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
        [self autorelease];
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
    
    self.restoreCompleteBlock(transaction, nil);
    
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

#pragma mark - Memory Managment

- (void)dealloc {
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    
    [super dealloc];
}

@end
