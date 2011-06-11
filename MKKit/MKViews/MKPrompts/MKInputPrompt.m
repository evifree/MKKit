//
//  MKInputPrompt.m
//  MKKit
//
//  Created by Matthew King on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MKInputPrompt.h"

@interface MKInputPrompt ()

- (void)onDone:(id)sender;

@end

#define INPUT_MESSAGE_WIDTH               280.0
#define INPUT_MESSAGE_RIGHT_MARGIN        20.0
#define INPUT_MESSAGE_TOP_MARGIN          8.0
#define INPUT_MESSAGE_BOTTOM_MARGIN       46.0

@implementation MKInputPrompt

@synthesize textField=mTextField, onDoneBlock=mOnDoneBlock;

#pragma mark - Initalization

- (id)initWithMessage:(NSString *)message {
    self = [super initWithFrame:[self frameForMessage:message]];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        UIImageView *shine = [[UIImageView alloc] initWithFrame:self.bounds];
        shine.image = [UIImage imageNamed:MK_PROMPT_VIEW_SHINE];
        
        [self addSubview:shine];
        [shine release];
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:[self frameForText:message]];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.lineBreakMode = UILineBreakModeWordWrap;
        messageLabel.minimumFontSize = 14.0;
        messageLabel.numberOfLines = 0;
        messageLabel.font = [UIFont boldSystemFontOfSize:14.0];
        messageLabel.text = message;
        
        [self addSubview:messageLabel];
               
        mTextField = [[UITextField alloc] initWithFrame:CGRectMake(INPUT_MESSAGE_RIGHT_MARGIN, (messageLabel.frame.size.height + 16.0), INPUT_MESSAGE_WIDTH, 31.0)];
        mTextField.delegate = self;
        mTextField.keyboardType = UIKeyboardTypeDefault;
        mTextField.returnKeyType = UIReturnKeyDone;
        mTextField.borderStyle = UITextBorderStyleRoundedRect;
        mTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        [mTextField becomeFirstResponder];
        [self addSubview:mTextField];
    
        [mTextField release];
        [messageLabel release];
    }
    return self;
}

#pragma mark - Factory Methods

+ (void)showWithMessage:(NSString *)message onDone:(MKTextFieldIsDoneBlock)completionBlock {
    [self release];
    
    MKInputPrompt *prompt = [[MKInputPrompt alloc] initWithMessage:message];
    prompt.onDoneBlock = completionBlock;
    [prompt showWithAnimationType:MKViewAnimationTypeMoveInFromTop];
    [prompt release];
}

- (void)onDone:(id)sender {
    [mTextField resignFirstResponder];
    
    [self removeView];
    self.onDoneBlock(mTextField.text);
}

#pragma mark - Sizing

- (CGRect)frameForMessage:(NSString *)message {
    CGSize constraint = CGSizeMake(INPUT_MESSAGE_WIDTH, 200000.0);
    
    CGSize size = [message sizeWithFont:[UIFont boldSystemFontOfSize:14.0] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect frameRect;
    
    if (![[UIApplication sharedApplication] isStatusBarHidden]) {
        frameRect = CGRectMake(0.0, (0.0 + STATUS_BAR_HEIGHT), IPHONE_WIDTH, (INPUT_MESSAGE_TOP_MARGIN + MAX(size.height, 21.0) + INPUT_MESSAGE_BOTTOM_MARGIN));
    }
    if ([[UIApplication sharedApplication] isStatusBarHidden]) {
        frameRect = CGRectMake(0.0, 0.0, IPHONE_WIDTH, (INPUT_MESSAGE_TOP_MARGIN + MAX(size.height, 21.0) + INPUT_MESSAGE_BOTTOM_MARGIN));
    }
    
    self.frame = frameRect;
    
    return frameRect;
}

- (CGRect)frameForText:(NSString *)message {
    CGSize constraint = CGSizeMake(INPUT_MESSAGE_WIDTH, 200000.0);
    
    CGSize size = [message sizeWithFont:[UIFont boldSystemFontOfSize:14.0] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect frameRect = CGRectMake(INPUT_MESSAGE_RIGHT_MARGIN, INPUT_MESSAGE_TOP_MARGIN, INPUT_MESSAGE_WIDTH, MAX(size.height, 21.0));
    
    return frameRect;
}

#pragma mark - Delegates
#pragma mark UITextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [mTextField resignFirstResponder];

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self removeView];
    self.onDoneBlock(mTextField.text);
}

#pragma mark - Memory Management

- (void)dealloc {
    [super dealloc];
}

@end
