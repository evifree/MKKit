//
//  MKGraphicsStructures.m
//  MKKit
//
//  Created by Matthew King on 9/18/11.
//  Copyright (c) 2010-2011 Matt King. All rights reserved.
//

#import "MKGraphicsStructures.h"

@interface MKGraphicsStructures ()

- (id)initWithLinearGradientTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor;
- (id)initWithFile:(NSString *)file;

- (void)setColorValueFromDictionary:(NSDictionary *)graphicsDict forKey:(NSString *)key;

@end

@implementation MKGraphicsStructures

@synthesize fill, useLinerShine, top, bottom, border, disabled, touched, bordered, borderWidth;

//@dynamic graphicsDictionary;

//static MKGraphicsStructures *sharedInstance = nil;

#pragma mark - Singleton Instance

/*
+ (id)sharedGraphics {
    @synchronized (self) {
        if (!sharedInstance) {
            MKGraphicsNoSharedInstanceDictionaryException = @"MKGraphicsNoSharedInstanceDictionaryException";
            NSException *exception = [NSException exceptionWithName:MKGraphicsNoSharedInstanceDictionaryException reason:@"No dictionary has been set for the shared instance. Use shared graphics with file to set the dictionary" userInfo:nil];
            @throw exception;
        }
    }
    return sharedInstance;
}

+ (id)sharedGraphicsWithFile:(NSString *)path {
    @synchronized (self) {
        if (!sharedInstance) {
            sharedInstance = [[[self class] alloc] initWithFile:path];
            return sharedInstance;
        }
    }
    return nil;
}
*/

+ (void)registerGraphicsFile:(NSString *)path {
    MKGraphicsPropertyListName = @"MKGraphicsPropertyListName";
    
    [[NSUserDefaults standardUserDefaults] setValue:path forKey:MKGraphicsPropertyListName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Creation

+ (id)graphicsStructure {
    return [[[[self class] alloc] init] autorelease];
}

+ (id)graphicsWithName:(NSString *)name {
    MKGraphicsStructures *graphics = [MKGraphicsStructures graphicsStructure];
    
    NSString *path = [[NSUserDefaults standardUserDefaults] objectForKey:MKGraphicsPropertyListName];
    NSDictionary *mainDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    if ([[mainDic objectForKey:name] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *graphicsDict = [mainDic objectForKey:name];
        
        /// COLORS ///
        if ([[graphicsDict objectForKey:MKGraphicsTopColor] isKindOfClass:[NSDictionary class]]) {
            [graphics setColorValueFromDictionary:[graphicsDict objectForKey:MKGraphicsTopColor] forKey:MKGraphicsTopColor];
        }
        if ([[graphicsDict objectForKey:MKGraphicsBottomColor] isKindOfClass:[NSDictionary class]]) {
            [graphics setColorValueFromDictionary:[graphicsDict objectForKey:MKGraphicsBottomColor] forKey:MKGraphicsBottomColor];
        }
        if ([[graphicsDict objectForKey:MKGraphicsFillColor] isKindOfClass:[NSDictionary class]]) {
            [graphics setColorValueFromDictionary:[graphicsDict objectForKey:MKGraphicsFillColor] forKey:MKGraphicsFillColor];
        }
        if ([[graphicsDict objectForKey:MKGraphicsBorderColor] isKindOfClass:[NSDictionary class]]) {
            [graphics setColorValueFromDictionary:[graphicsDict objectForKey:MKGraphicsBorderColor] forKey:MKGraphicsBorderColor];
            [graphics setValue:@"YES" forKey:MKGraphicsBordered];
            
            if ([graphicsDict objectForKey:MKGraphicsBorderWidth]) {
                [graphics setValue:[graphicsDict objectForKey:MKGraphicsBorderWidth] forKey:MKGraphicsBorderWidth];
            }
            else {
                [graphics setValue:@"2.0" forKey:MKGraphicsBorderWidth];
            }
        }
        if ([[graphicsDict objectForKey:MKGraphicsDisabledColor] isKindOfClass:[NSDictionary class]]) {
            [graphics setColorValueFromDictionary:[graphicsDict objectForKey:MKGraphicsDisabledColor] forKey:MKGraphicsDisabledColor];
        }
        if ([[graphicsDict objectForKey:MKGraphicsTouchedColor] isKindOfClass:[NSDictionary class]]) {
            [graphics setColorValueFromDictionary:[graphicsDict objectForKey:MKGraphicsTouchedColor] forKey:MKGraphicsTouchedColor];
        }
        
        /// STYLES ///
        if ([graphicsDict objectForKey:MKGraphicsUseLinerShine]) {
            [graphics setValue:[graphicsDict objectForKey:MKGraphicsUseLinerShine] forKey:MKGraphicsUseLinerShine];
        }
    }
    
    return graphics;
}

+ (id)linearGradientWithTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor {
    return [[[[self class] alloc] initWithLinearGradientTopColor:topColor bottomColor:bottomColor] autorelease];
}

- (id)init {
    self = [super init];
    if (self) {
        [self setObjectKeys];
    }
    return self;
}

- (id)initWithLinearGradientTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor {
    self = [super init];
    if (self) {
        [self setObjectKeys];
        
        self.top = topColor;
        self.bottom = bottomColor;
    }
    return self;
}

- (id)initWithFile:(NSString *)file {
    self = [super init];
    if (self) {
        [self setObjectKeys];
        mGraphicsDictionary = [[NSDictionary dictionaryWithContentsOfFile:file] retain];
    }
    return self;
}

#pragma mark - Memory Managment

- (void)dealloc {
    self.top = nil;
    self.bottom = nil;
    self.fill = nil;
    self.border = nil;
    self.disabled = nil;
    self.touched = nil;
    
    [super dealloc];
}

#pragma mark - Adding Structures

- (void)assignGradientTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor {
    self.top = topColor;
    self.bottom = bottomColor;
}

#pragma mark - Accessor Methods
#pragma mark Getters

//- (NSDictionary *)graphicsDictionary {
//    return mGraphicsDictionary;
//}

#pragma mark - KVC
#pragma mark Helpers

- (void)setObjectKeys {
    MKGraphicsTopColor          = @"MKGraphicsTopColor";
    MKGraphicsBottomColor       = @"MKGraphicsBottomColor";
    MKGraphicsFillColor         = @"MKGraphicsFillColor";
    MKGraphicsBorderColor       = @"MKGraphicsBorderColor";
    MKGraphicsDisabledColor     = @"MKGraphicsDisabledColor";
    MKGraphicsTouchedColor      = @"MKGraphicsTouchedColor";
    MKGraphicsUseLinerShine     = @"MKGraphicsUseLinerShine";
    MKGraphicsBordered          = @"MKGraphicsBordered";
    MKGraphicsBorderWidth       = @"MKGraphicsBorderWidth";
    
    MKGraphicsColorHSBA         = @"MKGraphicsColorHSBA";
    MKGraphicsColorRGBA         = @"MKGraphicsColorRGBA";
    
    MKGraphicsPropertyListName  = @"MKGraphicsPropertyListName";
}

- (void)setColorValueFromDictionary:(NSDictionary *)graphicsDict forKey:(NSString *)key {
    if ([graphicsDict objectForKey:MKGraphicsColorHSBA]) {
        UIColor *color = [UIColor colorWithHSBADictionary:[graphicsDict objectForKey:MKGraphicsColorHSBA]];
        [self setValue:color forKey:key];
    }
    if ([graphicsDict objectForKey:MKGraphicsColorRGBA]) {
        UIColor *color = [UIColor colorWithRGBADictionary:[graphicsDict objectForKey:MKGraphicsColorRGBA]];
        [self setValue:color forKey:key];
    }
}

#pragma mark Setters

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:MKGraphicsTopColor]) {
        self.top = (UIColor *)value;
    }
    if ([key isEqualToString:MKGraphicsBottomColor]) {
        self.bottom = (UIColor *)value;
    }
    if ([key isEqualToString:MKGraphicsFillColor]) {
        self.fill = (UIColor *)value;
    }
    if ([key isEqualToString:MKGraphicsBorderColor]) {
        self.border = (UIColor *)value;
    }
    if ([key isEqualToString:MKGraphicsDisabledColor]) {
        self.disabled = (UIColor *)value;
    }
    if ([key isEqualToString:MKGraphicsTouchedColor]) {
        self.touched = (UIColor *)value;
    }
    if ([key isEqualToString:MKGraphicsUseLinerShine]) {
        self.useLinerShine = [(NSString *)value boolValue];
    }
    if ([key isEqualToString:MKGraphicsBordered]) {
        self.bordered = [(NSString *)value boolValue];
    }
    if ([key isEqualToString:MKGraphicsBorderWidth]) {
        self.borderWidth = [(NSString *)value floatValue];
    }
}

#pragma mark Getters

- (id)valueForKey:(NSString *)key {
    if ([key isEqualToString:MKGraphicsTopColor]) {
        return self.top;
    }
    if ([key isEqualToString:MKGraphicsBottomColor]) {
        return self.bottom;
    }
    if ([key isEqualToString:MKGraphicsFillColor]) {
        return self.fill;
    }
    if ([key isEqualToString:MKGraphicsBorderColor]) {
        return self.border;
    }
    if ([key isEqualToString:MKGraphicsDisabledColor]) {
        return self.disabled;
    }
    if ([key isEqualToString:MKGraphicsTouchedColor]) {
        return self.touched;
    }
    if ([key isEqualToString:MKGraphicsUseLinerShine]) {
        if (self.useLinerShine) {
            return [NSString stringWithFormat:@"YES"];
        }
        else {
            return [NSString stringWithFormat:@"NO"];
        }
    }
    if ([key isEqualToString:MKGraphicsBordered]) {
        if (self.bordered) {
            return [NSString stringWithFormat:@"YES"];
        }
        else {
            return [NSString stringWithFormat:@"NO"];
        }
    }
    if ([key isEqualToString:MKGraphicsBorderWidth]) {
        return [NSString stringWithFormat:@"%f", self.borderWidth];
    }
    return nil;
}

@end