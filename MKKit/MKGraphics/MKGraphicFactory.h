//
//  MKGraphicFactory.h
//  MKKit
//
//  Created by Matthew King on 12/25/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKGraphicsStructures;

/**-----------------------------------------------------------------------
 *Overview*
 
 MKGraphicsFractory provides method to Create MKKit UI objects that support
 the Use of MKGraphicStructures.
------------------------------------------------------------------------*/
@protocol MKGraphicFactory <NSObject>

@required

///------------------------------------
/// @name Creating Instances
///------------------------------------

/**
 Craetes an instance of a MKKit UI object and assigns it a graphics Structure
 with the given name from a graphics property list file.
 
 @param structureName the name of the structure to use on the object.
 
 @return MKKit UI object Instance
*/
- (id)initWithGraphicsNamed:(NSString *)structureName;

///-------------------------------------
/// @name Referencing
///-------------------------------------

/** The MKGraphiceStructure that is currently in use. */
@property (nonatomic, retain) MKGraphicsStructures *graphicsStructure;

@end
