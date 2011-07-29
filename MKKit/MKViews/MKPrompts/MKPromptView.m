//
//  MKPromptView.m
//  MKKit
//
//  Created by Matthew King on 5/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MKPromptView.h"

#define MESSAGE_WIDTH               231.0
#define MESSAGE_RIGHT_MARGIN        77.0
#define MESSAGE_TOP_MARGIN          32.0
#define MESSAGE_BOTTOM_MARGIN       15.0

@implementation MKPromptView

@synthesize type=mType, duration=mDuration;

#pragma mark - Initalizer

- (id)initWithType:(MKPromptType)type title:(NSString *)title message:(NSString *)message {
    self = [super initWithFrame:[self frameForMessage:message]];
    if (self) {
        self.opaque = YES;
        self.backgroundColor = [UIColor clearColor];
        
        mType = type;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(77.0, 8.8, 231.0, 21.0)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.minimumFontSize = 16.0;
        titleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        titleLabel.shadowColor = [UIColor blackColor];
        titleLabel.text = title;
        
        [self addSubview:titleLabel];
        [titleLabel release];
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:[self frameForText:message]];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.lineBreakMode = UILineBreakModeWordWrap;
        messageLabel.minimumFontSize = 14.0;
        messageLabel.numberOfLines = 0;
        messageLabel.font = [UIFont boldSystemFontOfSize:14.0];
        messageLabel.text = message;
        messageLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        
        [self addSubview:messageLabel];
        [messageLabel release];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        self.autoresizesSubviews = YES;
    }
    return self;
}

+ (void)promptWithType:(MKPromptType)type title:(NSString *)title message:(NSString *)message duration:(NSTimeInterval)duration{
    [self release];
    
    MKPromptView *view = [[MKPromptView alloc] initWithType:type title:title message:message];
    view.duration = duration;
    [view showWithAnimationType:MKViewAnimationTypeMoveInFromTop];
    [view release];
}

#pragma mark - Drawing 

- (void)drawRect:(CGRect)rect {
    CGColorRef startColor;
    CGColorRef endColor;
    CGColorRef textColor;
    CGColorRef indentColor;
    
    if (mType == MKPromptTypeRed) {
        startColor = MK_COLOR_HSB(360.0, 98.0, 65.0, 1.0).CGColor;
        endColor = MK_COLOR_HSB(360.0, 100.0, 65.0, 1.0).CGColor;
        textColor = MK_COLOR_HSB(360.0, 100.0, 45.0, 1.0).CGColor;
        indentColor = MK_COLOR_HSB(360.0, 50.0, 97.0, 1.0).CGColor;
    }
    if (mType == MKPromptTypeGreen) {
        startColor = MK_COLOR_HSB(110.0, 92.0, 65.0, 1.0).CGColor;
        endColor = MK_COLOR_HSB(110.0, 95.0, 65.0, 1.0).CGColor;
        textColor = MK_COLOR_HSB(110.0, 95.0, 45.0, 1.0).CGColor;
        indentColor = MK_COLOR_HSB(110.0, 43.0, 97.0, 1.0).CGColor;
    }
    if (mType == MKPromptTypeAmber) {
        startColor = MK_COLOR_HSB(65.0, 77.0, 78.0, 1.0).CGColor;
        endColor = MK_COLOR_HSB(63.0, 79.0, 78.0, 1.0).CGColor;
        textColor = MK_COLOR_HSB(63.0, 91.0, 58.0, 1.0).CGColor;
        indentColor = MK_COLOR_HSB(63.0, 9.0, 98.0, 1.0).CGColor;
    }
    
    CGColorRef shadowColor = MK_COLOR_RGB(51.0, 51.0, 51.0, 0.5).CGColor;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGFloat x = CGRectGetMinX(rect);
    CGFloat y = CGRectGetMinY(rect);
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = (CGRectGetHeight(rect) - 3.0);
    
    CGRect viewRect = CGRectMake(x, y, width, height);
    CGRect iconRect = CGRectMake(28.0, -10.0, 25.0, 25.0);
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor);
    CGContextSetFillColorWithColor(context, startColor);
    CGContextFillRect(context, viewRect);
    CGContextRestoreGState(context);
    
    drawGlossAndLinearGradient(context, viewRect, startColor, endColor);
    
    CGContextSetStrokeColorWithColor(context, endColor);
    CGContextSetLineWidth(context, 1.0);    
    CGContextStrokeRect(context, rectFor1pxStroke(viewRect));
    
    NSString *text = [NSString stringWithFormat:@"!"];
    
    drawText(context, iconRect, (CFStringRef)text, textColor, indentColor, 70.0);
}

#pragma mark - Accessor Methods

- (void)setDuration:(NSTimeInterval)duration {
    if (duration != 0) {
        [self performSelector:@selector(removeView) withObject:nil afterDelay:duration];
    }
}

#pragma mark - Size Methods

- (CGRect)frameForMessage:(NSString *)message {
    CGSize constraint = CGSizeMake(MESSAGE_WIDTH, 200000.0);
    
    CGSize size = [message sizeWithFont:[UIFont boldSystemFontOfSize:14.0] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect frameRect;
    
    if (![[UIApplication sharedApplication] isStatusBarHidden]) {
        frameRect = CGRectMake(0.0, (0.0 + STATUS_BAR_HEIGHT), IPHONE_WIDTH, (MESSAGE_TOP_MARGIN + MAX(size.height, 21.0) + MESSAGE_BOTTOM_MARGIN));
    }
    if ([[UIApplication sharedApplication] isStatusBarHidden]) {
        frameRect = CGRectMake(0.0, 0.0, IPHONE_WIDTH, (MESSAGE_TOP_MARGIN + MAX(size.height, 21.0) + MESSAGE_BOTTOM_MARGIN));
    }
    
    self.frame = frameRect;
    
    return frameRect;
}

- (CGRect)frameForText:(NSString *)message {
    CGSize constraint = CGSizeMake(MESSAGE_WIDTH, 200000.0);
    
    CGSize size = [message sizeWithFont:[UIFont boldSystemFontOfSize:14.0] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect frameRect = CGRectMake(MESSAGE_RIGHT_MARGIN, MESSAGE_TOP_MARGIN, MESSAGE_WIDTH, MAX(size.height, 21.0));
    
    return frameRect;
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   [self removeView];
}


#pragma mark - Memory Management

- (void)dealloc {
    [super dealloc];
}

@end
