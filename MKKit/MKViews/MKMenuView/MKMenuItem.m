//
//  MKMenuItem.m
//  MKKit
//
//  Created by Matthew King on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MKMenuItem.h"


@implementation MKMenuItem

@synthesize type=mType;

#pragma mark - Initalizer

- (id)initWithType:(MKMenuItemType)type title:(NSString *)name target:(id)target selector:(SEL)selector {
    self = [super init];
    if (self) {
        self.alpha = 1.0;
        self.frame = CGRectMake(0.0, 0.0, 60.0, 80.0);
        
        mType = type;
        mTarget = [target retain];
        mSelector = selector;
        
        UIImage *iconImage = nil;
        
        if (type == MKMenuItemTypeCancel) {
            iconImage = [UIImage imageNamed:MK_MENU_VIEW_CANCEL_BUTTON];
        }
        if (type == MKMenuItemTypeCopy) {
            iconImage = [UIImage imageNamed:MK_MENU_VIEW_COPY_BUTTON];
        }
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 60.0, 60.0)];
        icon.image = iconImage;
        
        [self addSubview:icon];
        [icon release];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 60.0, 60.0, 20.0)];
        title.backgroundColor = CLEAR;
        title.font = [UIFont boldSystemFontOfSize:12.0];
        title.textColor = WHITE;
        title.textAlignment = UITextAlignmentCenter;
        title.text = name;
        
        [self addSubview:title];
        [title release];
    }
    return self;
}

- (id)initWithCustomView:(UIView *)view target:(id)target selector:(SEL)selector {
    self = [super init];
    if (self) {
        self.alpha = 1.0;
        self.frame = CGRectMake(0.0, 0.0, 60.0, 80.0);
        
        mTarget = [target retain];
        mSelector = selector;
        
        view.frame = CGRectMake(0.0, 0.0, 60.0, 80.0);
        
        [self addSubview:view];
    }
    return self;
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	NSInteger taps = [touch tapCount];
    
    if (taps == 1) {
        [mTarget performSelector:mSelector withObject:self];
    }
}

#pragma mark - Memory Managment

- (void)dealloc {
    [mTarget release];
    
    [super dealloc];
}

@end
