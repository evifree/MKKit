//
//  MKTableCellIAP.m
//  MKKit
//
//  Created by Matthew King on 5/28/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKTableCellIAP.h"

@interface MKTableCellIAP ()

- (void)completPurchase;

@end

@implementation MKTableCellIAP

@synthesize price=mPrice, IAPIdentifier=mIAPIdentifier, observer=mObserver;

#pragma mark - Initalizer

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithType:MKTableCellTypeNone reuseIdentifier:reuseIdentifier];
    if (self) {
        mTheLabel = [[UILabel alloc] initWithFrame:CGRectMake(14.0, 7.0, 150.0, 25.0)];
        mTheLabel.backgroundColor = CLEAR;
        mTheLabel.font = SYSTEM_BOLD(20.0);
        mTheLabel.textAlignment = UITextAlignmentLeft;
        mTheLabel.adjustsFontSizeToFitWidth = YES;
        
        [self.contentView addSubview:mTheLabel];
        [mTheLabel release];
        
        self.accessoryViewType = MKTableCellAccessoryInfoButton;
    }
    return self;
}

#pragma mark - Accessor Methods

- (void)setPrice:(NSString *)price {
    mButton = [[MKButton alloc] initWithType:MKButtonTypeIAP title:price];
    mButton.frame = CGRectMake((270.0 - mButton.frame.size.width), 7.0, mButton.frame.size.width, 30.0);
    
    
    [mButton completedAction: ^ (MKAction action) {
        if (action == MKActionTouchUp) {
            [self completPurchase];
        }
    }];
    
    [self.contentView addSubview:mButton];
    [mButton release];
}

#pragma mark - Actions

- (void)completPurchase {
    NSSet *items = [NSSet setWithObject:self.IAPIdentifier];
    self.accessoryViewType = MKTableCellAccessoryActivity;
    mButton.working = YES;
    
    [MKIAPController purchaseRequestWithIdentifiers:items completion: ^ (SKPaymentTransaction *transaction, NSError *error) {
        NSSet *identifiers = [NSSet setWithObject:transaction.payment.productIdentifier];
        if (error == nil) {
            if ([mObserver respondsToSelector:@selector(didCompleteEvent:forIdentifiers:)]) {
                [mObserver didCompleteEvent:MKIAPEventPurchaseComplete forIdentifiers:identifiers];
            }
            mButton.working = NO;
            mButton.buttonText = @"Installed";
            self.accessoryViewType = MKTableCellAccessoryInfoButton;
        }
        else {
            if ([mObserver respondsToSelector:@selector(didCompleteEvent:forIdentifiers:)]) {
                [mObserver didCompleteEvent:MKIAPEventRequestFailed forIdentifiers:identifiers];
                
                mButton.working = NO;
                mButton.buttonText = @"Retry";
                
                self.accessoryViewType = MKTableCellAccessoryInfoButton;
            }
        }
    }];
}

#pragma mark - Memory Management

- (void)dealloc {
    [super dealloc];
}

@end
