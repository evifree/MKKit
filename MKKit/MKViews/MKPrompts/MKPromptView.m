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
        mType = type;
        if (type == MKPromptTypeGreen) {
            self.backgroundColor = [UIColor greenColor];
        }
        if (type == MKPromptTypeAmber) {
            self.backgroundColor = [UIColor yellowColor];
        }
        if (type == MKPromptTypeRed) {
            self.backgroundColor = [UIColor redColor];
        }
        
        UIImageView *shine = [[UIImageView alloc] initWithFrame:self.bounds];
        shine.image = [UIImage imageNamed:MK_PROMPT_VIEW_SHINE];
        
        [self addSubview:shine];
        [shine release];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(8.0, 8.0, 50.0, 50.0)];
        icon.image = [UIImage imageNamed:MK_PROMPT_VIEW_WARING_ICON];
        
        [self addSubview:icon];
        [icon release];
        
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
        
        [self addSubview:messageLabel];
        [messageLabel release];
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

#pragma mark - Accessor Methods

- (void)setDuration:(NSTimeInterval)duration {
    [self performSelector:@selector(removeView) withObject:nil afterDelay:duration];
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
