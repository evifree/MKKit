//
//  MKSounds.h
//  MKKit
//
//  Created by Matthew King on 2/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

/**--------------------------------------------------------------------------------------------
 The MKSounds object creates and returns a playable sound from a given path. 
----------------------------------------------------------------------------------------------*/

@interface MKSounds : AVAudioPlayer {
	AVAudioPlayer *sound;
}

///-----------------------------------------------------
/// @name Initalizer
///-----------------------------------------------------

/** Returns and initalized MKSounds object.
 
 @param path Path of the sound to play.
*/
- (id)initWithPath:(NSString *)path;

///-----------------------------------------------------
/// @name Media 
///-----------------------------------------------------

/** The sound created during initalization. */
@property (nonatomic, retain) AVAudioPlayer *sound;

@end
