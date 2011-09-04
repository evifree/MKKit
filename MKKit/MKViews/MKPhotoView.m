//
//  MKPhotoView.m
//  MKKit
//
//  Created by Matthew King on 8/30/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKPhotoView.h"

@implementation MKPhotoView

@synthesize photo, noPhotoMask;

#pragma mark - Initalizer

- (id)initWithFrame:(CGRect)frame photo:(UIImage *)aPhoto {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = CLEAR;
        
        mShouldRemoveView = NO;
        
        MKPhotoViewFlags.hasPhoto = NO;
        
        if (aPhoto) {
            mPhoto = aPhoto.CGImage;
            MKPhotoViewFlags.hasPhoto = YES;
        }
    }
    return self;
}

#pragma mark - Accessor Methods

- (void)setPhoto:(UIImage *)p {
    mPhoto = p.CGImage;
    MKPhotoViewFlags.hasPhoto = YES;
    
    //[self setNeedsDisplay];
}

- (void)setNoPhotoMask:(UIImage *)p {
    mNilPhotoMask = p.CGImage;
    [self setNeedsDisplay];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGColorRef topColor =  MK_COLOR_HSB(212.0, 17.0, 93.0, 1.0).CGColor;
    CGColorRef bottomColor = MK_COLOR_HSB(212.0, 34.0, 82.0, 1.0).CGColor;
    
    if (!MKPhotoViewFlags.hasPhoto) {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0.0, rect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextClipToMask(context, rect, mNilPhotoMask);
        drawLinearGradient(context, rect, bottomColor, topColor);
        CGContextRestoreGState(context);
    }
    else {
        [self.photo drawInRect:rect];
       //CGContextSaveGState(context);
       //CGContextTranslateCTM(context, 0.0, rect.size.height);
       //CGContextScaleCTM(context, 1.0, -1.0);
       //CGContextDrawImage(context, rect, mPhoto);
       //CGContextRestoreGState(context);
    }
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    NSInteger taps = [touch tapCount];
    
    if (taps == 1) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.allowsEditing = YES;
            picker.delegate = self;
            
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:picker];
                [popover presentPopoverFromRect:self.frame inView:self.controller.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            }
            
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                [self.controller presentModalViewController:picker animated:YES];
            }
            
            [picker release];
        }
    }
}

#pragma mark - Delegates
#pragma mark Popover View

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    [popoverController release];
}

#pragma mark Image Picker 

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerEditedImage];
	
	// Create a thumbnail version of the image for the recipe object.
	CGSize size = selectedImage.size;
	CGFloat ratio = 0;
	if (size.width > size.height) {
		ratio = 44.0 / size.width;
	} else {
		ratio = 44.0 / size.height;
	}
	CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
	
	UIGraphicsBeginImageContext(rect.size);
	[selectedImage drawInRect:rect];
	self.photo = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
}

#pragma mark - Memory Managment

- (void)dealloc {
    [super dealloc];
}

@end
