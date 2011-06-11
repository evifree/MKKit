//
//  MKTableCellIAP.m
//  MKKit
//
//  Created by Matthew King on 5/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MKTableCellIAP.h"

@interface MKTableCellIAP ()

- (MKButton *)buttonWithState:(MKButtonState)state title:(NSString *)title;

@end

@implementation MKTableCellIAP

@synthesize price=mPrice, IAPIdentifier=mIAPIdentifier, observer=mObserver;

#pragma mark - Initalizer

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    mButton = [self buttonWithState:MKButtonStatePrice title:price];
    
    [self.contentView addSubview:mButton];
    [mButton release];
}

- (MKButton *)buttonWithState:(MKButtonState)state title:(NSString *)title {
    MKButton *button = nil;
    
    mButtonState = state;
    
    if (state == MKButtonStatePrice || state == MKButtonStateRetry) {
        button = [[MKButton alloc] initWithType:MKButtonTypeDarkBlue title:title];
        button.frame = CGRectMake((270.0 - button.frame.size.width), 7.0, button.frame.size.width, 30.0);
        button.delegate = self;
    }
    if (state == MKButtonStateInstalling || state == MKButtonStateComplete) {
        button = [[MKButton alloc] initWithType:MKButtonTypeGreen title:title];
        button.frame = CGRectMake((270.0 - button.frame.size.width), 7.0, button.frame.size.width, 30.0);
    }
    
    return button;
}

#pragma mark - Delegates
#pragma mark MKControl

- (void)didCompleteAction:(id)sender {
    NSSet *items = [NSSet setWithObject:self.IAPIdentifier];
    
    [mButton removeFromSuperview];
    mButton = [self buttonWithState:MKButtonStateInstalling title:@"Installing"];
    
    [self addSubview:mButton];
    [mButton release];
    
    self.accessoryViewType = MKTableCellAccessoryActivity;
    
    [MKIAPController purchaseRequestWithIdentifiers:items completion: ^ (SKPaymentTransaction *transaction, NSError *error) {
        NSSet *identifiers = [NSSet setWithObject:transaction.payment.productIdentifier];
        if (error == nil) {
            if ([mObserver respondsToSelector:@selector(didCompleteEvent:forIdentifiers:)]) {
                [mObserver didCompleteEvent:MKIAPEventPurchaseComplete forIdentifiers:identifiers];
            }
            
            [mButton removeFromSuperview];
            mButton = [self buttonWithState:MKButtonStateComplete title:@"Installed"];
            
            [self addSubview:mButton];
            [mButton release];
            
            self.accessoryViewType = MKTableCellAccessoryInfoButton;
        }
        else {
            if ([mObserver respondsToSelector:@selector(didCompleteEvent:forIdentifiers:)]) {
                [mObserver didCompleteEvent:MKIAPEventRequestFailed forIdentifiers:identifiers];
                
                [mButton removeFromSuperview];
                mButton = [self buttonWithState:MKButtonStateRetry title:@"Retry"];
                
                [self addSubview:mButton];
                [mButton release];
                
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
