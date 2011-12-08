//
//  MKView+MKTitleView.m
//  MKKit
//
//  Created by Matthew King on 12/5/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKView+MKTitleView.h"

@interface MKView ()

- (void)titleViewLabelWithText:(NSString *)text;

@end

@implementation MKView (MKTitleView)

+ (id)titleViewWithTitle:(NSString *)title image:(MKImage *)icon {
    return [[[self alloc] initWithTitle:title image:icon] autorelease];
}

- (id)initWithTitle:(NSString *)title image:(MKImage *)icon {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, (MK_TEXT_WIDTH(title, VERDANA_BOLD(20.0)) + 32.0), 35.0)];
    if (self) {
        self.backgroundColor = CLEAR;
        self.autoresizesSubviews = YES;
        self.opaque = YES;
        self.alpha = 1.0;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:(UIImage *)icon];
        imageView.frame = CGRectMake(0.0, 2.0, 25.0, 25.0);
        [self addSubview:imageView];
        [imageView release];
        
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

@end
