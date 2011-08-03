//
//  MKTitleView.m
//  MKKit
//
//  Created by Matthew King on 8/2/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKTitleView.h"

@implementation MKTitleView

#pragma mark - Initalizer

- (id)initWithTitle:(NSString *)title image:(UIImage *)image {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, (MK_TEXT_WIDTH(title, VERDANA_BOLD(20.0)) + 32.0), 35.0)];
    if (self) {
        self.backgroundColor = CLEAR;
        self.autoresizesSubviews = YES;
        self.opaque = YES;
        self.alpha = 1.0;
        
        MKTitleViewIcon *icon = [[MKTitleViewIcon alloc] initWithFrame:CGRectMake(0.0, 2.0, 25.0, 25.0) icon:image];
        [self addSubview:icon];
        [icon release];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(32.0, 5.0, MK_TEXT_WIDTH(title, VERDANA_BOLD(20.0)), 23.0)];
        titleLabel.backgroundColor = CLEAR;
        titleLabel.font = VERDANA_BOLD(20.0);
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.textColor = WHITE;
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        titleLabel.shadowColor = BLACK;
        titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
        titleLabel.text = title;
        
        [self addSubview:titleLabel];
        [titleLabel release];
    }
    return self;
}

#pragma mark - Memory Managment

- (void)dealloc {
    [super dealloc];
}

@end

@implementation MKTitleViewIcon

@synthesize image=mImage;

#pragma mark - Initalizer

- (id)initWithFrame:(CGRect)frame icon:(UIImage *)icon {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CLEAR;
        self.opaque = YES;
        self.alpha = 1.0;
        
        mImage = [icon retain];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGRect drawRect = CGRectInset(rect, 1.0, 1.0);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, WHITE.CGColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, -1.0), 2.0, MK_SHADOW_COLOR);
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, drawRect, self.image.CGImage);
    CGContextFillRect(context, drawRect);
    CGContextRestoreGState(context);
    
    [mImage release];
}

#pragma mark - Memory Managemnt

- (void)dealloc {
    [super dealloc];
}

@end
