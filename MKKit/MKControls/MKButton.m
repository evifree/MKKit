//
//  MKButton.m
//  MKKit
//
//  Created by Matthew King on 5/28/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKButton.h"

@interface MKButton ()

- (float)widthForTitle:(NSString *)title;

@end

@implementation MKButton

@synthesize type=mType;

static float kHorizPadding = 20.0;

#pragma mark - Initalizer

- (id)initWithType:(MKButtonType)type title:(NSString *)title {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.0, 0.0, ([self widthForTitle:title] + (kHorizPadding * 2)) ,30.0);
        self.backgroundColor = CLEAR;
        mType = type;
        
        UIImage *button = nil;
        
        if (type == MKButtonTypeDarkBlue) {
            button = [UIImage imageNamed:MK_DARK_BLUE_BUTTON_IMAGE];
        }
        if (type == MKButtonTypeGreen) {
            button = [UIImage imageNamed:MK_GREEN_BUTTON_IMAGE];
        }
        
        mButtonView = [[UIImageView alloc] initWithFrame:self.frame];
        mButtonView.backgroundColor = CLEAR;
        mButtonView.image = button;
        
        [self addSubview:mButtonView];
        [mButtonView release];
        
        mButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 4.5, [self widthForTitle:title], 21.0)];
        mButtonLabel.backgroundColor = CLEAR;
        mButtonLabel.font = SYSTEM_BOLD(14.0);
        mButtonLabel.textColor = WHITE;
        mButtonLabel.textAlignment = UITextAlignmentCenter;
        mButtonLabel.shadowColor = BLACK;
        mButtonLabel.shadowOffset = CGSizeMake(0.0, -1.0);
        mButtonLabel.text = title;
        
        [self addSubview:mButtonLabel];
        [mButtonLabel release];
    }
    return self;
}

#pragma mark - Sizing

- (float)widthForTitle:(NSString *)title {
    CGSize size = [title sizeWithFont:SYSTEM_BOLD(14.0)];
    
    return size.width;
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    view.backgroundColor = BLACK;
    view.alpha = 0.65;
    view.tag = 1;
    
    [self addSubview:view];
    [view release];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self viewWithTag:1] removeFromSuperview];
        
    if ([mDelegate respondsToSelector:@selector(didCompleteAction:)]) {
        [mDelegate didCompleteAction:self];
    }
}

#pragma mark - Memory Managemnet

- (void)dealloc {
    [super dealloc];
}

@end
