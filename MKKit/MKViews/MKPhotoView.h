//
//  MKPhotoView.h
//  MKKit
//
//  Created by Matthew King on 8/30/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKView.h"

@interface MKPhotoView : MKView <UIPopoverControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    CGImageRef mNilPhotoMask;
    CGImageRef mPhoto;
    struct {
        bool hasPhoto;
    } MKPhotoViewFlags;
}

- (id)initWithFrame:(CGRect)frame photo:(UIImage *)aPhoto;

@property (nonatomic, retain) UIImage *photo;

@property (nonatomic, retain) UIImage *noPhotoMask;

@end
