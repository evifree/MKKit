//
//  MKAIPController.h
//  MKKit
//
//  Created by Matthew King on 5/28/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <StoreKit/StoreKit.h>
#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKObject.h>

typedef void (^MKProductResponseBlock)(SKProductsResponse *response, NSError *error);
typedef void (^MKPurchaseCompletionBlock)(SKPaymentTransaction *transaction, NSError *error);
typedef void (^MKRestoreCompletionBlock)(SKPaymentTransaction *transaction, NSError *error);

@protocol MKObjectDelegate;
@protocol MKIAPDelegate;

/**----------------------------------------------------------------------------------------------------------------
 *Overview*
 
 The MKIAPController executes inApp Purchases for you. This class is used by the MKIAPViewController. It can be
 used by itself as well, if you want to create your own store front.
 
 MKIAPController works in two ways. You can create an instance of it, preform requests and then recive the responses
 through the delegate. Your other option is to use factory methods with code blocks to handle the response. 
 
 @warning *Note* If you are using the MKAIPViewController, inApp Purchases are built in. The only thing not done by 
 the MKAIPViewController is restoring purchases.
 
 *Custom Store Front Usage*
 
 If you use your own store front instead of the MKIAPViewController, MKIAPContoller can still be used to process
 your transactions. Transactions can be montitored using code blocks or the MKIAPContollerDelegate. 
 
 When using code blocks you need to open and close the store. Use the openStore and closeStore class methods to do this.
 Opening and closeing only needs to be done once. After the openStore method is called, you can process as many transactions
 as you need. It is important to close the store once all transactions are complete. The closeStore class method
 closes out the store kit delegates and observers as well as releases the MKIAPController.
 
 Review the source code of MKIAPViewController and MKTableCellIAP to see examples on using code blocks for your
 inApp purchases.
 
 To use the MKIAPControllerDelegate to monitor transactions, you need to create an instance of MKIAPController.
 Ensure that your store front conforms to the MKIAPDelegate protocols.
 
 *Using the Singleton*
 
 MKIAPController offers a singleton instance if need. You can get the singleton by calling the sharedStore class method.
 The singleton instance can work with both code blocks or the MKIAPControllerDelegate. 
 
 @warning *Note* The openStore and closeStore class methods opperate off the singleton instance. The closeStore method
 will remove the singleton instance from memory.
 
 *Required Classes*
 
 * MKObject
 
 *Required Frameworks*
 
 * Foundation
 * StoreKit
 * UIKit
-----------------------------------------------------------------------------------------------------------------*/

@interface MKIAPController : MKObject <SKPaymentTransactionObserver, SKProductsRequestDelegate, SKRequestDelegate> {
@private
    id mDelegate;
    BOOL mIsPurchaseRequest;
    BOOL mIsOpen;
}

///----------------------------------------------------------------
/// @name Creating an Instance
///----------------------------------------------------------------

/**
 Returns an intialized instance of MKIAPController.
 
 @param delegate the instances delegate
*/
- (id)initWithDelegate:(id<MKIAPDelegate>)delegate;

/**
 Returns the singleton instance of MKIAPController.
*/
+ (id)sharedStore;

///---------------------------------------------------------------
/// @name Store Control
///---------------------------------------------------------------

/**
 Creates a singleton instance and prepares the MKIAPController for transactions using code blocks.
 This method is required to called before making any requests that use code blocks.
*/
+ (void)openStore;

/**
 Clears store kit observers and delegates, and removes MKIAPController singleton instance from 
 memory. Ensure that this method is not called until all the code blocks have been completed.
*/
+ (void)closeStore;

/** 
 Tells if a store is open or not. `YES` if a store has been opened, `NO' if the store is closed 
 Default is `NO`.
*/
@property (assign, readonly) BOOL storeIsOpen;

///----------------------------------------------------------------
/// @name Product Requests
///----------------------------------------------------------------

/**
 Requests product information for the given set of identifiers and executes the response block when the 
 request is returned.
 
 @param identifiers a NSSet of identifiers for the products you are requesting.
 
 @param response the code block to perform when a responces is given. 
 
 The MKProductResponseBlock is in the this format : `^(SKProductsResponse *response, NSError *error)`
*/
+ (void)productsRequestWithIdentifiers:(NSSet *)identifiers response:(MKProductResponseBlock)response;

/**
 Requests product information for the given set of identifiers and notifies the delegate when a response
 is given.
 
 @param identifiers a NSSet of identifiers for the products you are requesting.
*/
- (void)productsRequestWithIdentifiers:(NSSet *)identifiers;

///----------------------------------------------------------------
/// @name Purchases Requests
///----------------------------------------------------------------

/**
 Requests the purchase of a the products given in the set, and executes the completion block when the purchase
 is completed.
 
 @param identifiers a NSSet of identifiers for the products you purchasing.
 
 @param completion the code block to perform when the purchase is completed.
 
 The MKPurchaseCompletionBlock is in this format : `^(SKPaymentTransaction *transaction, NSError *error)`
*/
+ (void)purchaseRequestWithIdentifiers:(NSSet *)identifiers completion:(MKPurchaseCompletionBlock)completion;

/**
 Requests the purchase of a the products given in the set, and notifies the delegate when the purchase
 is completed.
 
 @param identifiers a NSSet of identifiers for the products you purchasing.
*/
- (void)purchaseRequestWithIdentifiers:(NSSet *)identifiers;

///----------------------------------------------------------------
/// @name Restoring Requests
///----------------------------------------------------------------

/**
 Restores previouse purchases that were made on the account, and executes the completion block when
 the restore is finished.
 
 @param completion block the code block to perform when the restore is complete
 
 The MKRestoreCompletionBlock is in this format : `^(SKPaymentTransaction *transaction, NSError *error)`
*/
+ (void)restorePurchase:(MKRestoreCompletionBlock)completion;

/**
 Restores previouse purchases that were made on the account, and notifies the delegate when
 the restore is finished.
*/
- (void)restorePurchases;

///----------------------------------------------------------------
/// @name Delegate
///----------------------------------------------------------------

/** The MKIAPDelegate */
@property (nonatomic, assign) id<MKIAPDelegate> delegate;

///----------------------------------------------------------------
/// @name Code Blocks
///----------------------------------------------------------------

/**
 The response the code block to perform when a responces is given. 
 
 The MKProductResponseBlock is in the this format : `^(SKProductsResponse *response, NSError *error)`
*/
@property (nonatomic, copy) MKProductResponseBlock productResponse;

/**
 The completion the code block to perform when the purchase is completed.
 
 The MKPurchaseCompletionBlock is in this format : `^(SKPaymentTransaction *transaction, NSError *error)`
*/
@property (nonatomic, copy) MKPurchaseCompletionBlock purchaseCompleteBlock;

/**
 The completion block the code block to perform when the restore is complete
 
 The MKRestoreCompletionBlock is in this format : `^(SKPaymentTransaction *transaction, NSError *error)`
*/
@property (nonatomic, copy) MKRestoreCompletionBlock restoreCompleteBlock;

@end

/**----------------------------------------------------------------------------------------------------
 The MKIAPDelegate defines methods to recieve data from inApp Purchase requests. The delegate needs to 
 be used only if you are using the instace methods of MKIAPController. The factory methods will not call
 methods on the delegate.
-----------------------------------------------------------------------------------------------------*/

@protocol MKIAPDelegate <NSObject>

@optional

/**
 Called when a response is recieved by the MKIAPController.
 
 @param response the response that was recieved
*/
- (void)didRecieveResponse:(SKProductsResponse *)response;

/**
 Called when a transaction is completed by the MKIAPController.
 
 @param transaction the payment transaction that was completed.
*/
- (void)didCompleteTransaction:(SKPaymentTransaction *)transaction;

/**
 Called when purchase are restored.
*/
- (void)didRestorePurchases;

/**
 Called if there is an error during a request.
 
 @param error the error that occoured.
*/
- (void)didError:(NSError *)error;

@end
