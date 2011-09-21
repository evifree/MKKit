//
//  MKTitleView.m
//  MKKit
//
//  Created by Matthew King on 8/2/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKTitleView.h"

@interface MKTitleView ()

- (void)titleViewLabelWithText:(NSString *)text;

@end

@implementation MKTitleView

#pragma mark - Initalizer

- (id)initWithTitle:(NSString *)title image:(UIImage *)image {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, (MK_TEXT_WIDTH(title, VERDANA_BOLD(20.0)) + 32.0), 35.0)];
    if (self) {
        self.backgroundColor = CLEAR;
        self.autoresizesSubviews = YES;
        self.opaque = YES;
        self.alpha = 1.0;
        
        UIImageView *icon = [[UIImageView alloc] initWithImage:image];
        icon.frame = CGRectMake(0.0, 0.0, 25.0, 25.0);
        [self addSubview:icon];
        [icon release];
        
        [self titleViewLabelWithText:title];
        
        mShouldRemoveView = NO;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title image:(UIImage *)image gradient:(MKGraphicsStructures *)gradient {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, (MK_TEXT_WIDTH(title, VERDANA_BOLD(20.0)) + 32.0), 35.0)];
    if (self) {
        self.backgroundColor = CLEAR;
        self.autoresizesSubviews = YES;
        self.opaque = YES;
        self.alpha = 1.0;
        
        MKView *icon = [[MKView alloc] initWithImage:image gradient:gradient];
        icon.frame = CGRectMake(0.0, 2.0, 25.0, 25.0);
        [self addSubview:icon];
        [icon release];
        
        [self titleViewLabelWithText:title];        
        mShouldRemoveView = NO;
    }
    return self;
}

#pragma mark - Helpers

- (void)titleViewLabelWithText:(NSString *)text {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(32.0, 5.0, MK_TEXT_WIDTH(text, VERDANA_BOLD(20.0)), 23.0)];
    titleLabel.backgroundColor = CLEAR;
    titleLabel.font = VERDANA_BOLD(20.0);
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textColor = WHITE;
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleLabel.shadowColor = BLACK;
    titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    titleLabel.text = text;
    
    [self addSubview:titleLabel];
    [titleLabel release];
}

#pragma mark - Memory Managment

- (void)dealloc {
    [super dealloc];
}

@end