//
//  MKLoginViewController.m
//  MKKit
//
//  Created by Matthew King on 5/8/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKLoginViewController.h"

@interface MKLoginViewController ()

- (void)onChange:(UITextField *)textFeild;
- (void)onHelpButton:(id)sender;
- (void)onChallengeAnswer:(NSString *)answer;

- (void)checkPin;

- (void)testAtempts;

@end


@implementation MKLoginViewController

@synthesize promptLabel=mPromptLabel, headerView=mHeaderView, pin=mPin, secretEntry=mSecretEntry, pinIsSet=mPinIsSet,
maxAtempts=mMaxAtempts;

#pragma mark - Initalizer

- (id)initWithDelegate:(id)delegate {
    self = [super initWithDelegate:delegate];
    if (self) {
        mPinIsSet = [[NSUserDefaults standardUserDefaults] boolForKey:PIN_SET];
    }
    return self;
}

#pragma mark - View lifecycle

- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 367.0)];
    self.view = view;
    [view release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 140.0, 320.0, 106.0)];
    view.backgroundColor = [UIColor grayColor];
    
    MKButton *help = [[MKButton alloc] initWithType:MKButtonTypeHelp];
    help.frame = CGRectMake(295.0, 10.0, 20.0, 21.0);
    
    [help completedAction: ^ (MKAction action) {
        if (action == MKActionTouchUp) {
            [self onHelpButton:help];
        }
    }];
    
    [view addSubview:help];
    [help release];
    
    mPromptLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0, 8.0, 275.0, 21.0)];
    mPromptLabel.textColor = [UIColor whiteColor];
    mPromptLabel.font = [UIFont boldSystemFontOfSize:17.0];
    mPromptLabel.minimumFontSize = 10.0;
    mPromptLabel.textAlignment = UITextAlignmentCenter;
    mPromptLabel.backgroundColor = [UIColor clearColor];
    mPromptLabel.shadowColor = [UIColor blackColor];
    mPromptLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    
    if (mPinIsSet) {
        mPromptLabel.text = @"Enter Your Pin";
    }
    if (!mPinIsSet) {
        mPromptLabel.text = @"Set Your Pin";
    }
    
    [view addSubview:mPromptLabel];
    [mPromptLabel release];
    
    for (int i = 0; i < 4; i++) {
        CGFloat x = (24.0 + ((24.0 * i) + (50.0 *i)));
        
        UITextField *textFeild = [[UITextField alloc] initWithFrame:CGRectMake(x, 37.0, 50.0, 50.0)];
        textFeild.backgroundColor = [UIColor whiteColor];
        textFeild.keyboardType = UIKeyboardTypeNumberPad;
        textFeild.textAlignment = UITextAlignmentCenter;
        textFeild.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textFeild.keyboardAppearance = UIKeyboardAppearanceAlert;
        textFeild.font = [UIFont systemFontOfSize:32.0];
        textFeild.clearsOnBeginEditing = YES;
        
        [textFeild addTarget:self action:@selector(onChange:) forControlEvents:UIControlEventEditingChanged];
        
        switch (i) {
            case 0:
                mBoxOne = [textFeild retain];
                break;
            case 1:
                mBoxTwo = [textFeild retain];
                break;
            case 2:
                mBoxThree = [textFeild retain];
                break;
            case 3:
                mBoxFour = [textFeild retain];
            default:
                break;
        }
        
        [view addSubview:textFeild];
        [textFeild release];
    }
    
    [self.view addSubview:view];
    [view release];
    
    [mBoxOne becomeFirstResponder];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Accessor Methods

- (void)setHeaderView:(UIView *)headerView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 140.0)];
    view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:view];
    [view addSubview:headerView];
    
    [view release];
}

- (void)setSecretEntry:(BOOL)secretEntry {
    mSecretEntry = secretEntry;
    
    if (secretEntry) {
        mBoxOne.secureTextEntry = YES;
        mBoxTwo.secureTextEntry = YES;
        mBoxThree.secureTextEntry = YES;
        mBoxFour.secureTextEntry = YES;
    }
    
    if (!secretEntry) {
        mBoxOne.secureTextEntry = NO;
        mBoxTwo.secureTextEntry = NO;
        mBoxThree.secureTextEntry = NO;
        mBoxFour.secureTextEntry = NO;
    }
}

#pragma mark - Actions

- (void)onChange:(UITextField *)textFeild {
    if (textFeild == mBoxOne) {
        [mBoxTwo becomeFirstResponder];
    }
    if (textFeild == mBoxTwo) {
        [mBoxThree becomeFirstResponder];
    }
    if (textFeild == mBoxThree) {
        [mBoxFour becomeFirstResponder];
    }
    if (textFeild == mBoxFour) {
        [self checkPin];
    }
}

- (void)onHelpButton:(id)sender {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:CHALLENGE_SET]) {
        NSArray *questions = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Questions" ofType:@"plist"]];
        NSString *question = [questions objectAtIndex:[[[NSUserDefaults standardUserDefaults] objectForKey:CHALLENGE_QUESTION] integerValue]];
        NSString *promptString = [NSString stringWithFormat:@"What is your %@", question];
    
        [MKInputPrompt showWithMessage:promptString 
                                onDone: ^ (NSString *text) { 
                                    if ([text length] != 0) {
                                        [self onChallengeAnswer:text]; 
                                        [mBoxOne becomeFirstResponder]; 
                                    }
                                }];
    }
    else {
        [MKPromptView promptWithType:MKPromptTypeRed title:@"No Challenge Question" message:@"Your PIN cannot be retrived because no challenge question has been set." duration:3.5];
    }
}

- (void)onChallengeAnswer:(NSString *)answer {
    if ([answer isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:CHALLENGE_ANSWER]]) {
        NSString *message = [NSString stringWithFormat:@"Your PIN is %@", [[NSUserDefaults standardUserDefaults] objectForKey:PIN]];
        
        [MKPromptView promptWithType:MKPromptTypeGreen title:@"Correct!" message:message duration:3.0];
    }
    else {
        NSArray *questions = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Questions" ofType:@"plist"]];
        NSString *question = [questions objectAtIndex:[[[NSUserDefaults standardUserDefaults] objectForKey:CHALLENGE_QUESTION] integerValue]];
        NSString *promptString = [NSString stringWithFormat:@"Sorry %@ is not the correct answer. \n\nWhat is your %@", answer, question];
        
        [MKPromptView promptWithType:MKPromptTypeRed title:@"Incorrect" message:promptString duration:5.0];
    }
}

#pragma mark - Instance Methods

- (void)checkPin {
    NSString *pin = [[NSString alloc] initWithFormat:@"%@%@%@%@", mBoxOne.text, mBoxTwo.text, mBoxThree.text, mBoxFour.text];
    mPin = [pin integerValue];
    
    if (mPinIsSet) {
        if ([mDelegate respondsToSelector:@selector(pinIsValidated:)]) {
            if (mPin == [[NSUserDefaults standardUserDefaults] integerForKey:PIN]) {
                [mDelegate pinIsValidated:YES];
            }
            else {
                [mDelegate pinIsValidated:NO];
                [MKPromptView promptWithType:MKPromptTypeRed title:@"Incorrect PIN" message:@"The PIN you entered is incorrect. Please check it and try again. Tap the help button for addional assistance." duration:3.0];
                
                [self testAtempts];
            }
        }
    }
    
    if (!mPinIsSet) {
        [[NSUserDefaults standardUserDefaults] setInteger:mPin forKey:PIN];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:PIN_SET];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if ([mDelegate respondsToSelector:@selector(setPin:)]) {
            [mDelegate setPin:mPin];
        }
        
        [MKPromptView promptWithType:MKPromptTypeGreen title:@"New PIN Set" message:@"A new PIN has been set. Please set a challenge question to help you retrive your PIN if it is lost." duration:5.0];
    }
    
    [pin release];
}

- (void)testAtempts {
    mAtempts += 1;
    
    if (mAtempts == mMaxAtempts && mMaxAtempts != 0) {
        if ([mDelegate respondsToSelector:@selector(maxPinAtemptsMade)]) {
            [mDelegate maxPinAtemptsMade];
        }
    }
}

#pragma mark - Memory Managment

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [mBoxOne release];
    [mBoxTwo release];
    [mBoxThree release];
    [mBoxFour release];
    
    [super dealloc];
}

@end
