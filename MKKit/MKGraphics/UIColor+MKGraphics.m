//
//  UIColor+MKGraphics.m
//  MKKit
//
//  Created by Matthew King on 12/26/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "UIColor+MKGraphics.h"

@implementation UIColor (MKGraphics)

+ (UIColor *)colorWithHSBADictionary:(NSDictionary *)dictionary {
    NSInteger h = [[dictionary objectForKey:@"h"] floatValue];
    NSInteger s = [[dictionary objectForKey:@"s"] floatValue];
    NSInteger b = [[dictionary objectForKey:@"b"] floatValue];
    NSInteger a = [[dictionary objectForKey:@"a"] floatValue];
    
    UIColor *hsbaColor = MK_COLOR_HSB(h, s, b, a);
    return hsbaColor;
}

+ (UIColor *)colorWithRGBADictionary:(NSDictionary *)dictionary {
    NSInteger r = [[dictionary objectForKey:@"r"] floatValue];
    NSInteger g = [[dictionary objectForKey:@"g"] floatValue];
    NSInteger b = [[dictionary objectForKey:@"b"] floatValue];
    NSInteger a = [[dictionary objectForKey:@"a"] floatValue];
    
    UIColor *rgbaColor = MK_COLOR_RGB(r, g, b, a);
    return rgbaColor;
}

@end
