//
//  MKSounds.m
//  MKKit
//
//  Created by Matthew King on 2/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MKSounds.h"

@implementation MKSounds

@synthesize sound;

#pragma mark -
#pragma mark Start Up

- (id)initWithPath:(NSString *)path {
    self = [super init];
    if (self) {
        NSError *error;
        
        NSURL *soundURL = [NSURL fileURLWithPath:path];
        sound = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
        [sound prepareToPlay];
    }
	return self;
}

#pragma mark -
#pragma mark Memory Managment

- (void)dealloc {
	[super dealloc];
	
	[sound release];
}

@end
