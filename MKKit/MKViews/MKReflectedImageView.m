//
//  MKReflectedImageView.m
//  MKKit
//
//  Created by Matthew King on 5/16/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKReflectedImageView.h"

@interface MKReflectedImageView ()

- (UIImage *)reflectedImage:(UIImageView *)fromImage withHeight:(NSUInteger)height;

@end

CGImageRef CreateGradientImage(int pixelsWide, int pixelsHigh);
CGContextRef MyCreateBitmapContext(int pixelsWide, int pixelsHigh);

@implementation MKReflectedImageView

@synthesize image=mImage;

static const CGFloat kDefaultReflectionFraction = 0.25;
static const CGFloat kDefaultReflectionOpacity = 0.35;

#pragma mark - Initalizer

- (id)initWithImage:(UIImage *)image drawAt:(CGPoint)point {
    self = [super initWithFrame:CGRectMake(point.x, point.y, image.size.width, ((image.size.height * 2.0) + 2))];
    if (self) {
        self.backgroundColor = CLEAR;
        mImage = [image retain];
        
        NSUInteger reflectionHeight = image.size.height * kDefaultReflectionFraction;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
        imageView.image = mImage;
        
        [self addSubview:imageView];
        
        UIImageView *reflectionView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, (image.size.height + 2), image.size.width, (image.size.height * kDefaultReflectionFraction))];
        reflectionView.image = [self reflectedImage:imageView withHeight:reflectionHeight];
        
        [self addSubview:reflectionView];
        [reflectionView release];
        
        [imageView release];
        [mImage release];
    }
    return self;
}

#pragma mark - Image Reflection

CGImageRef CreateGradientImage(int pixelsWide, int pixelsHigh) {
	CGImageRef theCGImage = NULL;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
	CGContextRef gradientBitmapContext = CGBitmapContextCreate(NULL, pixelsWide, pixelsHigh,
															   8, 0, colorSpace, kCGImageAlphaNone);
	
	CGFloat colors[] = {0.0, 1.0, 1.0, 1.0};
	
	CGGradientRef grayScaleGradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
	CGColorSpaceRelease(colorSpace);
	
	CGPoint gradientStartPoint = CGPointZero;
	CGPoint gradientEndPoint = CGPointMake(0, pixelsHigh);
	
    CGContextDrawLinearGradient(gradientBitmapContext, grayScaleGradient, gradientStartPoint,
								gradientEndPoint, kCGGradientDrawsAfterEndLocation);
	CGGradientRelease(grayScaleGradient);
	
	theCGImage = CGBitmapContextCreateImage(gradientBitmapContext);
	CGContextRelease(gradientBitmapContext);
	
    return theCGImage;
}

CGContextRef MyCreateBitmapContext(int pixelsWide, int pixelsHigh) {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
	CGContextRef bitmapContext = CGBitmapContextCreate (NULL, pixelsWide, pixelsHigh, 8,
														0, colorSpace,
														(kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
	CGColorSpaceRelease(colorSpace);
    
    return bitmapContext;
}

- (UIImage *)reflectedImage:(UIImageView *)fromImage withHeight:(NSUInteger)height {
    if(height == 0)
		return nil;
    
    CGContextRef mainViewContentContext = MyCreateBitmapContext(fromImage.bounds.size.width, height);
	
    CGImageRef gradientMaskImage = CreateGradientImage(1, height);
	
    CGContextClipToMask(mainViewContentContext, CGRectMake(0.0, 0.0, fromImage.bounds.size.width, height), gradientMaskImage);
	CGImageRelease(gradientMaskImage);
	
	CGContextTranslateCTM(mainViewContentContext, 0.0, height);
	CGContextScaleCTM(mainViewContentContext, 1.0, -1.0);

	CGContextDrawImage(mainViewContentContext, fromImage.bounds, fromImage.image.CGImage);
	
	CGImageRef reflectionImage = CGBitmapContextCreateImage(mainViewContentContext);
	CGContextRelease(mainViewContentContext);
	
	UIImage *theImage = [UIImage imageWithCGImage:reflectionImage];
	
	CGImageRelease(reflectionImage);
	
	return theImage;
}

#pragma mark - Memory Management

- (void)dealloc {
    [super dealloc];
}

@end
